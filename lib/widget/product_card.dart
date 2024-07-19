import 'package:flutter/material.dart';

import 'package:openfoodfacts/openfoodfacts.dart';

import 'package:nutrimate/screen/product_details_screen.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});

  final Product? product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              product: widget.product,
              showAddButton: true,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
              color: Color.fromARGB(255, 173, 173, 173), width: 1.2),
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 8.0),
              Image.network(
                widget.product?.imageFrontSmallUrl ??
                    'https://s3-cdn.cmlabs.co/page/2023/01/24/a-guideline-on-how-to-fix-error-404-not-found-effectively-519451.png',
                fit: BoxFit.scaleDown,
                width: 95,
                height: 95,
              ),
              const SizedBox(height: 2.0),
              Text(
                '${widget.product?.productName}',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 0.5),
              Text(
                '${widget.product?.quantity}',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
