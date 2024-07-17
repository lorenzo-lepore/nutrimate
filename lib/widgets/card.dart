import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:nutrimate/screens/product_details_screen.dart';

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
            builder: (context) => ProductDetailsPage(product: widget.product),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
              color: Color.fromARGB(255, 173, 173, 173), width: 1.2),
              // color: Color.fromARGB(244, 178, 218, 94), width: 0.5),
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
                    'https://th.bing.com/th/id/R.be080585c0da64067404b23530a814ce?rik=vjGDbB2xFyn9Sw&riu=http%3a%2f%2fwallup.net%2fwp-content%2fuploads%2f2016%2f03%2f10%2f318375-nature-landscape-lake-mountain-forest-wildflowers-spring-pine_trees-path-Switzerland-HDR.jpg&ehk=W21nAe%2fQYSWkLQF83VxX2RflaJ7eKm%2fm0J4pW85PpjU%3d&risl=&pid=ImgRaw&r=0',
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
