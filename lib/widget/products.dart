import 'package:flutter/material.dart';

import 'package:nutrimate/service/api_service.dart';
import 'package:nutrimate/widget/product_card.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:openfoodfacts/openfoodfacts.dart';

import 'package:easy_debounce/easy_debounce.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late List<Product>? _products;
  late bool _isLoaded;
  late bool _showNotFound;

  @override
  void initState() {
    super.initState();
    _showNotFound = false;
    _isLoaded = false;
    ApiService().getSampleProducts().then((value) {
      _products = value;
      setState(() {
        _isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: TextField(
                cursorColor: const Color.fromARGB(244, 178, 218, 94),
                decoration: const InputDecoration(
                  focusColor: Color.fromARGB(244, 178, 218, 94),
                  fillColor: Color.fromARGB(244, 178, 218, 94),
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
                onChanged: (userInput) {
                  setState(() {
                    _showNotFound = false;
                    _isLoaded = false;
                  });
                  EasyDebounce.debounce(
                    'search-bar',
                    const Duration(milliseconds: 1000),
                    () async {
                      if (userInput.isNotEmpty) {
                        setState(() {
                          _isLoaded = false;
                        });
                        _products =
                            await ApiService().searchProducts(userInput);
                        if (_products != null) {
                          setState(() {
                            _isLoaded = true;
                          });
                        }
                        if (_products!.isEmpty) {
                          setState(() {
                            _isLoaded = true;
                            _showNotFound = true;
                          });
                        }
                      } else {
                        ApiService().getSampleProducts().then((value) {
                          setState(() {
                            _products = value;
                            _isLoaded = true;
                          });
                        });
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            // Grid di prodotti
            _isLoaded
                ? (_showNotFound
                    ? Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Nessun prodotto trovato',
                              style: GoogleFonts.kadwa(
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                          ),
                          padding: const EdgeInsets.all(8.0),
                          itemCount: _products?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return ProductCard(
                              product: _products?[index],
                            );
                          },
                        ),
                      ))
                : Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height /
                          1.3, // Per centrare il widget al centro della schermata
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(244, 178, 218, 94),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}
