import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SupermarketsPage extends StatefulWidget {
  const SupermarketsPage({super.key});

  @override
  State<SupermarketsPage> createState() => _SupermarketsPageState();
}

class _SupermarketsPageState extends State<SupermarketsPage> {
  static const LatLng _pGooglePlex = LatLng(37.4221, -122.0841); 

  @override
  Widget build(BuildContext context) {
    return const GoogleMap(initialCameraPosition: CameraPosition(target: _pGooglePlex, zoom: 13));
  }
}
