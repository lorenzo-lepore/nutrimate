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
  late List<Product>? products;
  late bool isLoaded;

  @override
  void initState() {
    super.initState();
    isLoaded = false;
    ApiService().getSampleProducts().then((value) {
      products = value;
      setState(() {
        isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            // Barra di ricerca
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Cerca prodotti',
                contentPadding: EdgeInsets.only(left: 30.0),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black38,
                  size: 20,
                ),
                prefixIconConstraints: BoxConstraints(
                  minHeight: 15,
                  minWidth: 25,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          // Grid di prodotti
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
              : Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height /
                        1.3, // Per centrare il widget al centro della schermata
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
