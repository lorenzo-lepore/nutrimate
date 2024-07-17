import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrimate/models/shopping_list_element.dart';
import 'package:nutrimate/services/api_service.dart';
import 'package:nutrimate/screens/product_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:nutrimate/providers/shopping_list_provider.dart';

class MyItem extends StatefulWidget {
  const MyItem({super.key, required this.item});

  final ListElement item;

  @override
  State<MyItem> createState() => _MyItemState();
}

class _MyItemState extends State<MyItem> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _modifiedProductNameController;
  late TextEditingController _modifiedProductQuantityController;
  late String _modifiedProductName;
  late int _modifiedProductQuantity;

  @override
  void initState() {
    super.initState();
    _modifiedProductName = widget.item.title;
    _modifiedProductQuantity = widget.item.quantity;
    _modifiedProductNameController =
        TextEditingController(text: _modifiedProductName);
    _modifiedProductQuantityController =
        TextEditingController(text: _modifiedProductQuantity.toString());
  }

  @override
  void dispose() {
    super.dispose();
    _modifiedProductNameController.dispose();
    _modifiedProductQuantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        tileColor: const Color.fromARGB(136, 236, 231, 231),
        contentPadding: const EdgeInsets.symmetric(vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onTap: () {
          if (widget.item.barcode == null) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                content:
                    Text('Dettagli non disponibili. Prodotto non tracciato.'),
                duration: Duration(seconds: 2),
              ),
            );
            return;
          } else {
            ApiService().fetchProduct(widget.item.barcode!).then((value) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(
                    product: value,
                    showAddButton: false,
                  ),
                ),
              );
            });
          }
        },
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Transform.scale(
            scale: 1.5,
            child: Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              activeColor: Colors.green[300],
              checkColor: Colors.white,
              value: context
                  .watch<ShoppingListProvider>()
                  .items
                  .elementAt(context
                      .read<ShoppingListProvider>()
                      .items
                      .indexOf(widget.item))
                  .status,
              onChanged: (bool? value) {
                context.read<ShoppingListProvider>().changeItemStatus(
                      context
                          .read<ShoppingListProvider>()
                          .items
                          .indexOf(widget.item),
                    );
              },
            ),
          ),
        ),
        title: Text(
          widget.item.title,
          style: GoogleFonts.kadwa(
            decoration: context
                    .watch<ShoppingListProvider>()
                    .items
                    .elementAt(context
                        .read<ShoppingListProvider>()
                        .items
                        .indexOf(widget.item))
                    .status
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          'Quantità: ${widget.item.quantity}',
          style: GoogleFonts.kadwa(
            decoration: context
                    .watch<ShoppingListProvider>()
                    .items
                    .elementAt(context
                        .read<ShoppingListProvider>()
                        .items
                        .indexOf(widget.item))
                    .status
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: IconButton(
            icon: const Icon(Icons.edit),
            color: Colors.grey[700],
            onPressed: () {
              setState(
                () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text('Modifica prodotto',
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
                                    enabled: widget.item.barcode == null,
                                    controller: _modifiedProductNameController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Nome prodotto',
                                    ),
                                    validator: (String? value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Inserisci un nome valido';
                                      }
                                      _modifiedProductName = value.trim();
                                      return null;
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 22.0),
                                    child: TextFormField(
                                      controller:
                                          _modifiedProductQuantityController,
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
                                        _modifiedProductQuantity =
                                            int.parse(value);
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
                                              color: Color.fromARGB(
                                                  255, 82, 100, 45)),
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            context
                                                .read<ShoppingListProvider>()
                                                .modifyItemDetails(
                                                  context
                                                      .read<
                                                          ShoppingListProvider>()
                                                      .items
                                                      .indexOf(widget.item),
                                                  title: _modifiedProductName,
                                                  quantity:
                                                      _modifiedProductQuantity,
                                                );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                content:
                                                    Text('Prodotto modificato'),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
