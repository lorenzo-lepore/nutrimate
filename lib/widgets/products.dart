import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrimate/services/api_service.dart';
import 'package:nutrimate/widgets/card.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:easy_debounce/easy_debounce.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late List<Product>? products;
  late bool isLoaded;
  late bool showNotFound;

  @override
  void initState() {
    super.initState();
    showNotFound = false;
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
              // Barra di ricerca
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
                    showNotFound = false;
                    isLoaded = false;
                  });
                  EasyDebounce.debounce(
                    'search-bar',
                    const Duration(milliseconds: 1000),
                    () async {
                      if (userInput.isNotEmpty) {
                        setState(() {
                          isLoaded = false;
                        });
                        products = await ApiService().searchProducts(userInput);
                        if (products != null) {
                          setState(() {
                            isLoaded = true;
                          });
                        }
                        if (products!.isEmpty) {
                          setState(() {
                            isLoaded = true;
                            showNotFound = true;
                          });
                        }
                      } else {
                        ApiService().getSampleProducts().then((value) {
                          setState(() {
                            products = value;
                            isLoaded = true;
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
            isLoaded
                ? (showNotFound
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
                          itemCount: products?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return ProductCard(
                              product: products?[index],
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
