import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutrimate/widgets/product_details.dart';
import 'package:nutrimate/services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.listElements = const ['DAJE ROMA']});

  final List<String> listElements;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String assetName = 'assets/groceries3.svg';
  final List<String> listElements = [
    '8057018224999',
    '8057018224990',
    '8057018224998',
    '8057018224994',
    '8057018224992',
    '8057018224991',
    '8057018224993',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: listElements.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    assetName,
                    height: 300.0,
                    width: 300.0,
                  ),
                  Text(
                    'lista vuota',
                    style:
                        GoogleFonts.nunito(color: Colors.black, fontSize: 32.0),
                  ),
                  const Text(
                    'La tua lista è vuota. Aggiungi dei prodotti manualmente o scannerizzandoli.',
                    style: TextStyle(fontSize: 16.0),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: listElements.length,
                      itemBuilder: (ctx, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Card(
                          child: ListTile(
                            title: Text(listElements[index]),
                            /* onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsPage(
                                    product: ApiService.fetchProduct(
                                        listElements[index]),
                                  ),
                                ),
                              );
                            }, */
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
