import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import './screens/home_screen.dart';

import 'package:openfoodfacts/openfoodfacts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // OpenFoodFacts configuration
    OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'NutriMate', url: 'NoURL');
    OpenFoodAPIConfiguration.globalCountry = OpenFoodFactsCountry.ITALY;
    OpenFoodAPIConfiguration.globalLanguages = <OpenFoodFactsLanguage>[
      OpenFoodFactsLanguage.ITALIAN
    ];

    // System Navigation Bar configuration
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      //systemNavigationBarColor: /* Color.fromARGB(244, 178, 218, 94), */Colors.red,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Color.fromARGB(0, 230, 34, 34),
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NutriMate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(244, 178, 218, 94),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(title: 'NutriMate'),
    );
  }
}

// Test