import 'package:openfoodfacts/openfoodfacts.dart';

class ApiService {
  List<ProductQueryConfiguration> configSampleList = [
    ProductQueryConfiguration(
      '8000080004358',
      version: ProductQueryVersion.v3,
    ),
    ProductQueryConfiguration(
      '8715035110106',
      version: ProductQueryVersion.v3,
    ),
    ProductQueryConfiguration(
      '8076802085981',
      version: ProductQueryVersion.v3,
    ),
    ProductQueryConfiguration(
      '8000050109007',
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
      '4025500105341',
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
      '8000430900231',
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

  ProductQueryConfiguration config = ProductQueryConfiguration(
    '5449000131805',
    version: ProductQueryVersion.v3,
  );

  Future<Product> fetchProduct(String barcode) async {
    ProductResultV3 productResult;    
    ProductQueryConfiguration productConfig = ProductQueryConfiguration(
      barcode,
      version: ProductQueryVersion.v3,
    );
    try {
      productResult = await OpenFoodAPIClient.getProductV3(productConfig);
      return productResult.product!;
    } catch (e) {
      throw Exception('Errore durante il recupero dei dati');
    }
  }

  Future<List<Product>> getSampleProducts() async {
    ProductResultV3 singleProduct;
    List<Product> products = [];
    try {
      for (var i = 0; i < configSampleList.length; i++) {
        singleProduct = await OpenFoodAPIClient.getProductV3(configSampleList[i]);

        if (singleProduct.product != null) {
          products.add(singleProduct.product!);
        }
      }
      return products;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Product>> searchProducts(String userInput) async {
    ProductSearchQueryConfiguration configuration = ProductSearchQueryConfiguration(
      version: ProductQueryVersion.v3,
      parametersList: <Parameter>[
        SearchTerms(terms: [userInput]),
      ],
    );

    SearchResult result = await OpenFoodAPIClient.searchProducts(
      const User(userId: '', password: ''),
      configuration,
    );

    return result.products ?? [];
  }

  List<ProductQueryConfiguration> getConfigList() {
    return configSampleList;
  }

  ProductQueryConfiguration getProductConfig() {
    return config;
  }
}
