import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutrimate/models/shopping_list_element.dart';
import 'package:nutrimate/providers/shopping_list_provider.dart';
import 'package:nutrimate/widgets/shopping_list_item.dart';
import 'package:provider/provider.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _productName;
  late int _productQuantity;
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _productName = '';
    _productQuantity = 0;
    _isChecked = false;
  }

  void _removeFromList(ListElement item) {
    int index = context.read<ShoppingListProvider>().items.indexOf(item);

    context.read<ShoppingListProvider>().removeFromList(item);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('${item.title} rimosso dalla lista'),
        action: SnackBarAction(
          label: 'Annulla',
          onPressed: () {
            context.read<ShoppingListProvider>().insertItem(index, item);
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
                    title: Text('Aggiungi prodotto non tracciato',
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
                                  border: OutlineInputBorder(),
                                  labelText: 'Nome prodotto',
                                ),
                                validator: (String? value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Inserisci un nome valido';
                                  }
                                  _productName = value.trim();
                                  return null;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 22.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Quantità',
                                  ),
                                  validator: (String? value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        int.tryParse(value) == null ||
                                        int.tryParse(value)! <= 0) {
                                      return 'Inserisci una quantità valida';
                                    }
                                    _productQuantity = int.parse(value);
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
                                            .addToItemsList(
                                              ListElement(
                                                title: _productName,
                                                quantity: _productQuantity,
                                                status: false,
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
