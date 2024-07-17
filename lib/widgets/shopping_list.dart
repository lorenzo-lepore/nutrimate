import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutrimate/models/shopping_list_element.dart';
import 'package:nutrimate/widgets/item.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key, this.listElements = const ['DAJE ROMA']});

  final List<String> listElements;

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<ListElement> itemsToBuy = [
    ListElement(title: 'Pasta', quantity: 1),
    ListElement(title: 'Riso', quantity: 1),
    ListElement(title: 'Latte', quantity: 1),
    ListElement(title: 'Pane', quantity: 1),
    ListElement(title: 'Uova', quantity: 1),
    ListElement(title: 'Pomodori', quantity: 1),
    ListElement(title: 'Cipolle', quantity: 1),
    ListElement(title: 'Patate', quantity: 1),
    ListElement(title: 'Carne', quantity: 1),
    ListElement(title: 'Pesce', quantity: 1),
    ListElement(title: 'Frutta', quantity: 1),
    ListElement(title: 'Verdura', quantity: 1),
  ];
  late String productName;
  late int productQuantity;
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    productName = '';
    productQuantity = 0;
    isChecked = false;
  }

  void _addToItemsToBuy(ListElement item) {
    setState(() {
      itemsToBuy.add(item);
    });
  }

  void _removeFromList(ListElement item) {
    final int index;

    try {
      index = itemsToBuy.indexOf(item);
      setState(() {
        itemsToBuy.remove(item);
      });
    } catch (e) {
      throw Exception('Rimozione fallita: $e');
    }

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('${item.title} rimosso dalla lista'),
        action: SnackBarAction(
          label: 'Annulla',
          onPressed: () {
            setState(() {
              itemsToBuy.insert(index, item);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: itemsToBuy.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/groceries3.svg',
                      height: 300.0,
                      width: 300.0,
                    ),
                    Text(
                      'lista vuota',
                      style: GoogleFonts.nunito(
                          color: Colors.black, fontSize: 32.0),
                    ),
                    const Text(
                      'La tua lista è vuota. Aggiungi dei prodotti manualmente o scannerizzandoli.',
                      style: TextStyle(fontSize: 16.0),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    itemCount: itemsToBuy.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) => {
                          _removeFromList(itemsToBuy[index]),
                        },
                        child: MyItem(item: itemsToBuy[index]),
                      );
                    },
                  ),
                ),
        ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: FloatingActionButton(
            backgroundColor: const Color.fromARGB(244, 178, 218, 94),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    title: Text('Aggiungi prodotto',
                        style: GoogleFonts.kadwa(),
                        textAlign: TextAlign.center),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Nome prodotto',
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Inserisci un nome';
                                  }
                                  productName = value;
                                  return null;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 22.0),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Quantità',
                                  ),
                                  validator: (String? value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        int.tryParse(value) == null) {
                                      return 'Inserisci una quantità valida';
                                    }
                                    productQuantity = int.parse(value);
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 22.0),
                                child: ButtonTheme(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          244, 178, 218, 94),
                                    ),
                                    child: const Text(
                                      'Aggiungi',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 82, 100, 45)),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _addToItemsToBuy(
                                          ListElement(
                                            title: productName,
                                            quantity: productQuantity,
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            content: Text('Prodotto aggiunto'),
                                          ),
                                        );
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Transform.scale(
              scale: 1.2,
              child: const Icon(
                Icons.add,
                color: Color.fromARGB(255, 82, 100, 45),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
