import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/shopping_list_provider.dart';
import 'package:nutrimate/screen/home_screen.dart';
import 'package:nutrimate/configuration/off_config.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OpenFoodFactsConfiguration.setupOpenFoodFactsAPI();
  // await dotenv.load(fileName: '.env');
  await Future.delayed(const Duration(seconds: 1));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
