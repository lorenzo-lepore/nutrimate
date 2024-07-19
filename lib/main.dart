import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/shopping_list_provider.dart';

import 'screen/home_screen.dart';

import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    OpenFoodAPIConfiguration.userAgent =
        UserAgent(name: 'NutriMate', url: 'NoURL');
    OpenFoodAPIConfiguration.globalCountry = OpenFoodFactsCountry.ITALY;
    OpenFoodAPIConfiguration.globalLanguages = <OpenFoodFactsLanguage>[
      OpenFoodFactsLanguage.ITALIAN
    ];

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Color.fromARGB(0, 230, 34, 34),
    ));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ShoppingListProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.white,
        ),
        title: 'NutriMate',
        home: const HomeScreen(title: 'NutriMate'),
      ),
    );
  }
}
