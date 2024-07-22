import 'package:openfoodfacts/openfoodfacts.dart';

class OpenFoodFactsConfiguration {
  static void setupOpenFoodFactsAPI() {
    OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'NutriMate', url: 'NoURL');

    OpenFoodAPIConfiguration.globalLanguages = <OpenFoodFactsLanguage>[
      OpenFoodFactsLanguage.ITALIAN
    ];

    OpenFoodAPIConfiguration.globalCountry = OpenFoodFactsCountry.ITALY;
  }
}
