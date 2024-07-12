import 'package:flutter/material.dart';
import 'package:nutrimate/services/api_service.dart';
import 'package:nutrimate/widgets/card.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<ProductQueryConfiguration>? configList;
  List<Product>? products;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    products = [];
    configList = ApiService().getConfigList();
    if (configList != null && configList!.isNotEmpty) {
      getProducts();
    }
  }

  getProduct() async {
    try {
      ProductResultV3? product =
          await OpenFoodAPIClient.getProductV3(ApiService().getProductConfig());

      setState(() {
        isLoaded = true;
      });
    } catch (e) {
      throw Exception('Errore durante il recupero dei dati');
    }
  }

  getProducts() async {
    try {
      ProductResultV3? singleProduct;

      for (var i = 0; i < configList!.length; i++) {
        singleProduct = await OpenFoodAPIClient.getProductV3(configList![i]);

        if (singleProduct.product != null) {
          products?.add(singleProduct.product!);
        }
      }

      setState(() {
        isLoaded = true;
      });
    } catch (e) {
      throw Exception('Errore durante il recupero dei dati');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  hintText: 'Cerca prodotti',
                  elevation: const WidgetStatePropertyAll(2.0),
                  controller: controller,
                  onTap: () {},
                  onChanged: (_) {},
                  leading: const Icon(Icons.search),
                );
              },
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                return const [];
              },
            ),
          ),
          const SizedBox(height: 16.0),
          isLoaded
              ? Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 5.0,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: products?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductCard(
                        product: products?[index],
                      );
                    },
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
        ],
      ),
    );
  }
}
