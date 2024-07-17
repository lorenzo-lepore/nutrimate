import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutrimate/models/shopping_list_element.dart';
import 'package:nutrimate/providers/shopping_list_provider.dart';
import 'package:nutrimate/widgets/item.dart';
import 'package:provider/provider.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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

  void _removeFromList(ListElement item) {
    int index = context.read<ShoppingListProvider>().items.indexOf(item);
    // print('INDICE $index');

    context.read<ShoppingListProvider>().removeFromList(item);
    // print(
    //     'ITEMS AFTER REMOVE FROM LIST ${context.read<ShoppingListProvider>().items}');

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('${item.title} rimosso dalla lista'),
        action: SnackBarAction(
          label: 'Annulla',
          onPressed: () {
            context.read<ShoppingListProvider>().insertItem(index, item);
            // print(
            //     'ITEMS AFTER UNDO ${context.read<ShoppingListProvider>().items.toString()}');
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
          child: context.watch<ShoppingListProvider>().items.isEmpty
              ? Center(
                child: Column(
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
                  ),
              )
              : SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    itemCount:
                        context.watch<ShoppingListProvider>().items.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) => {
                          _removeFromList(context
                              .read<ShoppingListProvider>()
                              .items[index]),
                        },
                        child: MyItem(
                            item: context
                                .watch<ShoppingListProvider>()
                                .items[index]),
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
                                        context
                                            .read<ShoppingListProvider>()
                                            .addToItemsToBuy(
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
