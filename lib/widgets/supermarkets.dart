import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupermarketsPage extends StatefulWidget {
  const SupermarketsPage({super.key});

  @override
  State<SupermarketsPage> createState() => _SupermarketsPageState();
}

class _SupermarketsPageState extends State<SupermarketsPage> { 
  late GoogleMapController mapController;
  late LatLng devicePosition;
  bool isLoading = true;
  final _placesAPI =
      GoogleMapsPlaces(apiKey: '${dotenv.env['MAPS_API_KEY']}');
  List<PlacesSearchResult> _placesList = [];
  Set<Marker> _markers = {};

  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      devicePosition = LatLng(position.latitude, position.longitude);
      isLoading = false;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> searchPlaces(String query, LatLng location) async {
    final result = await _placesAPI.searchNearbyWithRadius(
      Location(lat: location.latitude, lng: location.longitude),
      5000,
      type: 'supermarket',
      keyword: query,
    );

    if (result.status == 'OK') {
      setState(() {
        _placesList = result.results;
        _markers = result.results.map((place) {
          bool openNow = place.openingHours?.openNow ?? false;
          String rating = place.rating?.toString() ?? 'N/A';
          String photoUrl = place.photos.isNotEmpty == true
              ? _placesAPI.buildPhotoUrl(
                  photoReference: place.photos.first.photoReference,
                  maxWidth: 300,
                  maxHeight: 300,
                )
              : 'https://s3-cdn.cmlabs.co/page/2023/01/24/a-guideline-on-how-to-fix-error-404-not-found-effectively-519451.png';
          return Marker(
              markerId: MarkerId(place.placeId),
              position: LatLng(
                place.geometry!.location.lat,
                place.geometry!.location.lng,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text(
                          place.name,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.kadwa(
                            color: Colors.black,
                            fontSize: 32.0,
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                photoUrl,
                                isAntiAlias: true,
                                filterQuality: FilterQuality.high,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${place.vicinity}',
                              style: GoogleFonts.kadwa(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Valutazione ★: $rating',
                              style: GoogleFonts.kadwa(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 8),
                            openNow
                                ? Text(
                                    'Aperto adesso',
                                    style: GoogleFonts.kadwa(
                                      color: Colors.green,
                                      fontSize: 16.0,
                                    ),
                                  )
                                : Text(
                                    'Chiuso adesso',
                                    style: GoogleFonts.kadwa(
                                      color: Colors.red,
                                      fontSize: 16.0,
                                    ),
                                  ),
                            // const SizedBox(height: 8),
                            // Text('Orari di apertura:\n$openingHours'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Chiudi'),
                          ),
                        ],
                      );
                    });
              });
        }).toSet();
      });
    } else {
      throw Exception(result.errorMessage);
    }
  }

  @override
  void initState() {
    super.initState();
    getLocation().then((_) {
      if (!isLoading) {
        searchPlaces('supermarket', devicePosition);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 8),
              Text('Caricamento mappa in corso...'),
              Text('Assicurati di aver attivato la posizione'),
            ],
          ))
        : GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition:
                CameraPosition(target: devicePosition, zoom: 13.0),
            markers: _markers,
          );
  }
}
