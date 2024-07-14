import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nutrimate/models/album.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class ApiService {
  // Example of a simple HTTP request
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<Album> fetchAlbum() async {
    final response = await http.get(Uri.parse('$baseUrl/albums/1'));

    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load album');
    }
  }

  // OpenFoodFacts API related
  List<ProductQueryConfiguration> configList = [
    ProductQueryConfiguration(
      '8013355998832',
      version: ProductQueryVersion.v3,
    ),
    ProductQueryConfiguration(
      '8001405000024',
      version: ProductQueryVersion.v3,
    ),
    ProductQueryConfiguration(
      '8076802085981',
      version: ProductQueryVersion.v3,
    ),
    ProductQueryConfiguration(
      '8076809513722',
      version: ProductQueryVersion.v3,
    ),
    ProductQueryConfiguration(
      '80135463',
      version: ProductQueryVersion.v3,
    ),
    ProductQueryConfiguration(
      '8002270014901',
      version: ProductQueryVersion.v3,
    ),
    ProductQueryConfiguration(
      '3033490004743',
      version: ProductQueryVersion.v3,
    ),
    ProductQueryConfiguration(
      '8000430070774',
      version: ProductQueryVersion.v3,
    ),
    ProductQueryConfiguration(
      '8076809546478',
      version: ProductQueryVersion.v3,
    ),
    ProductQueryConfiguration(
      '8001302001131',
      version: ProductQueryVersion.v3,
    ),
    ProductQueryConfiguration(
      '8001070000039',
      version: ProductQueryVersion.v3,
    ),
    ProductQueryConfiguration(
      '8004030044005 ',
      version: ProductQueryVersion.v3,
    ),
    ProductQueryConfiguration(
      '8001860258633',
      version: ProductQueryVersion.v3,
    ),
    ProductQueryConfiguration(
      '8000300391961 ',
      version: ProductQueryVersion.v3,
    ),
    ProductQueryConfiguration(
      '8005840008805',
      version: ProductQueryVersion.v3,
    ),
    ProductQueryConfiguration(
      '3560070998661',
      version: ProductQueryVersion.v3,
    ),
    ProductQueryConfiguration(
      '8003130144974',
      version: ProductQueryVersion.v3,
    ),
    ProductQueryConfiguration(
      '8006890683851',
      version: ProductQueryVersion.v3,
    ),
    ProductQueryConfiguration(
      '8057018222988',
      version: ProductQueryVersion.v3,
    ),
    ProductQueryConfiguration(
      '8057018224999',
      version: ProductQueryVersion.v3,
    ),
    
  ];

  List<ProductQueryConfiguration> getConfigList() {
    return configList;
  }

  ProductQueryConfiguration config = ProductQueryConfiguration(
    '5449000131805',
    version: ProductQueryVersion.v3,
  );

  ProductQueryConfiguration getProductConfig() {
    return config;
  }
}
