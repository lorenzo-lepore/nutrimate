import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrimate/models/shopping_list_element.dart';

class MyItem extends StatefulWidget {
  const MyItem({super.key, required this.item});

  final ListElement item;

  @override
  State<MyItem> createState() => _MyItemState();
}

class _MyItemState extends State<MyItem> {
  final Color _iconColorDefault = Colors.grey[700]!;
  final Color _iconColorPinned = Colors.amberAccent[700]!;
  
  late bool isChecked;
  late bool isPinned;
  late Color _iconColor;

  @override
  void initState() {
    super.initState();
    isChecked = false;
    isPinned = false;
    _iconColor = isPinned ? _iconColorPinned : _iconColorDefault;
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
          /* Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(
                product: listProducts[index],
              ),
            ),
          ); */
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
        trailing: Padding(padding: const EdgeInsets.only(right: 20.0),
        child: IconButton(
          icon: const Icon(Icons.push_pin),
          color: _iconColor,
          onPressed: () {
            setState(() {
            });
          },
        )),
      ),
    );
  }
}
