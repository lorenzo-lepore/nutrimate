import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.product});

  final Product? product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
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