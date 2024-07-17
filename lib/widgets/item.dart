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
        trailing: Padding(padding: EdgeInsets.only(right: 20.0),
        child: IconButton(
          icon: const Icon(Icons.push_pin),
          color: _iconColor,
          onPressed: () {
            setState(() {
             
            });
            /* setState(() {
              itemsToBuy.removeAt(index);
            }); */
          },
        )),
        /* trailing: Padding(
          padding: const EdgeInsets.only(right: 30.0),
          child: SizedBox(
            width: 106,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  color: Colors.black54,
                  onPressed: () {
                    setState(() {
                      if (widget.item.quantity > 1) {
                        widget.item.quantity--;
                      }
                    });
                  },
                ),
                const SizedBox(width: 8),
                Text(
                  widget.item.quantity.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.add),
                  color: Colors.black54,
                  onPressed: () {
                    setState(() {
                      if (widget.item.quantity < 9) {
                        widget.item.quantity++;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ), */
      ),
    );
  }
}
