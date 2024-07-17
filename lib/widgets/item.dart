import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrimate/models/shopping_list_element.dart';
import 'package:nutrimate/providers/shopping_list_provider.dart';
import 'package:nutrimate/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:nutrimate/screens/product_details_screen.dart';

class MyItem extends StatefulWidget {
  const MyItem({super.key, required this.item});

  final ListElement item;

  @override
  State<MyItem> createState() => _MyItemState();
}

class _MyItemState extends State<MyItem> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = false;
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
          /* Reindirizzamento su pagina dettagli prodotto (solo se il codice a barre è disponibile, altrimenti mostra uno snackbar) */
          if (widget.item.barcode == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Dettagli non disponibili. Codice a barre non presente.'),
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
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
          ),
        ),
        title: Text(
          widget.item.title,
          style: GoogleFonts.kadwa(
            decoration:
                isChecked ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          'Quantità: ${widget.item.quantity}',
          style: GoogleFonts.kadwa(
            decoration:
                isChecked ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        trailing: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: const Icon(Icons.edit),
              color: Colors.grey[700],
              onPressed: () {
                setState(() {});
              },
            )),
      ),
    );
  }
}
