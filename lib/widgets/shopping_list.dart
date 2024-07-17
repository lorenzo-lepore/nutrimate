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
  final List<String> listElements = [
    /* '8057018224999',
    '8057018224990',
    '8057018224998',
    '8057018224994',
    '8057018224992',
    '8057018224991',
    '8057018224993', */
  ];

  /* DEV-SHOPPING-LIST */

  bool isChecked = false;
  final List<ListElement> boughtItems = [];
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

  void _addToItemsToBuy(ListElement item) {
    setState(() {
      itemsToBuy.add(item);
    });
  }

  void _addToBoughtItems(int index) {
    setState(() {
      boughtItems.add(itemsToBuy[index]);
      itemsToBuy.removeAt(index);
    });
  }

  // 0: Lista degli elementi da acquistare - 1: Lista degli elementi acquistati
  void _removeFromList(ListElement item, int typeOfList) {
    final int index;

    if (typeOfList == 0) {
      index = itemsToBuy.indexOf(item);
      setState(() {
        itemsToBuy.remove(item);
      });
    } else if (typeOfList == 1) {
      index = boughtItems.indexOf(item);
      setState(() {
        boughtItems.remove(item);
      });
    } else {
      throw Exception('Tipo di lista non valido');
    }

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
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

  /* END-DEV-SHOPPING-LIST */

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          : SingleChildScrollView(
              child: Column(
                children: [
                  /* const SizedBox(height: 10),
                  const Text(
                    'Da acquistare',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ), // Aggiungi il tuo testo qui
                  const SizedBox(height: 10), */
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    itemCount: itemsToBuy.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) => {
                          _removeFromList(itemsToBuy[index], 0),
                        },
                        child: MyItem(item: itemsToBuy[index]),
                      );
                    },
                  ),
                  Visibility(
                      visible: boughtItems.isNotEmpty,
                      child: const SizedBox(height: 10)),
                  Visibility(
                    visible: boughtItems.isNotEmpty,
                    child: const Text(
                      'Acquistati',
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ), // Aggiungi il tuo testo qui
                  Visibility(
                      visible: boughtItems.isNotEmpty,
                      child: const SizedBox(height: 10)),
                  Visibility(
                    visible: boughtItems.isNotEmpty,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(10),
                      itemCount: boughtItems.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) => {
                            _removeFromList(boughtItems[index], 1),
                          },
                          child: MyItem(item: boughtItems[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
