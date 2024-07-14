import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:logger/logger.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.product});

  final Product? product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final logger = Logger();
  
  Future<OrderedNutrients> getProductNutrients() async {
    OrderedNutrients orderedNutrients =
        await OpenFoodAPIClient.getOrderedNutrients(
      country: OpenFoodFactsCountry.ITALY,
      language: OpenFoodFactsLanguage.ITALIAN,
    );
  
    logger.d(orderedNutrients.nutrients[0].name);
    logger.d(orderedNutrients.nutrients[5].name);
    logger.d(orderedNutrients.nutrients[10].name);
  
    return orderedNutrients;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            Image.network(widget.product?.imageFrontUrl ?? 'Immagine non trovata'),
            const SizedBox(height: 8.0),
            Text(
              '${widget.product?.productName}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 32.0,
              ),
            ),
            const SizedBox(height: 8.0),
            FutureBuilder<OrderedNutrients>(
              future: getProductNutrients(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Text(
                        snapshot.data!.nutrients.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      )
                    : const CircularProgressIndicator();
              }
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Aggiungi alla lista'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}