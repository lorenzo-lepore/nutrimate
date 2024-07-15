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
  late Logger _logger;
  late Map<String, String> _nutriments;
  late OrderedNutrients _futureOrderedNutrients;

  Future<OrderedNutrients> fetchOrderedNutrients() async {
    final OrderedNutrients nutrients = await OpenFoodAPIClient.getOrderedNutrients(
        country: OpenFoodFactsCountry.ITALY,
        language: OpenFoodFactsLanguage.ITALIAN,
    );
    return nutrients;
  }

  @override
  void initState() {
    super.initState();
    _logger = Logger();
    _nutriments = widget.product?.nutriments?.toData() ?? {};
    fetchOrderedNutrients().then(
      (OrderedNutrients nutrients) {
        //_futureOrderedNutrients = nutrients;
        _logger.i(nutrients.toJson());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<DataRow> dataRows = _nutriments.entries.map((entry) {
      return DataRow(
        cells: [
          DataCell(Text(entry.key)),
          DataCell(Text(entry.value)),
        ],
      );
    }).toList();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.8, right: 2.8),
                  child: Column(
                    children: [
                      
                      /* FutureBuilder(
                        future: _futureOrderedNutrients,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return Text(snapshot.data.toString());
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }), */

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 16.0),
                            Image.network(
                              widget.product?.imageFrontUrl ??
                                  'Immagine non trovata',
                              width: 150,
                              height: 230,
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              '${widget.product?.getBestProductName(OpenFoodFactsLanguage.ITALIAN)}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8.0),
                            RichText(
                              text: TextSpan(
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      height: 1.5),
                                  children: <TextSpan>[
                                    const TextSpan(
                                      text: 'Codice a barre: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0),
                                    ),
                                    TextSpan(
                                      text: '${widget.product?.barcode}',
                                      style: const TextStyle(fontSize: 12.0),
                                    ),
                                  ]),
                            ),
                            const SizedBox(height: 8.0),
                            RichText(
                              text: TextSpan(
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      height: 1.5),
                                  children: <TextSpan>[
                                    const TextSpan(
                                      text: 'Ingredienti: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0),
                                    ),
                                    TextSpan(
                                      text: '${widget.product?.ingredientsText}',
                                      style: const TextStyle(fontSize: 12.0),
                                    ),
                                  ]),
                            ),
                            const SizedBox(height: 8.0),
                            RichText(
                              text: TextSpan(
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      height: 1.5),
                                  children: <TextSpan>[
                                    const TextSpan(
                                      text: 'Additivi: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0),
                                    ),
                                    TextSpan(
                                      text: (widget.product!.additives!.names
                                              .isNotEmpty)
                                          ? '${widget.product?.additives?.names.join(', ')}'
                                          : 'Nessun additivo presente.',
                                      style: const TextStyle(fontSize: 12.0),
                                    ),
                                  ]),
                            ),
                            const SizedBox(height: 8.0),
                            RichText(
                              text: TextSpan(
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      height: 1.5),
                                  children: <TextSpan>[
                                    const TextSpan(
                                      text: 'Allergeni: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0),
                                    ),
                                    TextSpan(
                                      text: (widget.product!.allergens!.names
                                              .isNotEmpty)
                                          ? '${widget.product?.allergens?.names.join(', ')}'
                                          : 'Nessun allergene presente.',
                                      style: const TextStyle(fontSize: 12.0),
                                    ),
                                  ]),
                            ),
                            const SizedBox(height: 8.0),
                            RichText(
                              text: TextSpan(
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      height: 1.5),
                                  children: <TextSpan>[
                                    const TextSpan(
                                      text: 'Porzione: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0),
                                    ),
                                    TextSpan(
                                      text: '${widget.product?.servingSize}',
                                      style: const TextStyle(fontSize: 12.0),
                                    ),
                                  ]),
                            ),
                            const SizedBox(height: 8.0),
                            DataTable(
                              columnSpacing: 3.0,
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Text(
                                    'Valori nutrizionali	',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Per 100 g / 100 ml',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  numeric: true,
                                ),
                              ],
                              rows: dataRows,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 51.0),
            backgroundColor: const Color.fromARGB(244, 178, 218, 94),
          ),
          child: const Text(
            'Aggiungi alla lista della spesa',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
