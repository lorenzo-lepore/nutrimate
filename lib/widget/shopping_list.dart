import 'package:flutter/material.dart';

import 'package:nutrimate/model/list_item.dart';
import 'package:nutrimate/provider/shopping_list_provider.dart';
import 'package:nutrimate/widget/shopping_list_item.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  void _removeFromList(ListItem item) {
    int index = context.read<ShoppingListProvider>().items.indexOf(item);

    context.read<ShoppingListProvider>().removeFromList(item);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
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
    return Visibility(
      visible: !context.watch<ShoppingListProvider>().isLoading,
      child: Padding(
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
                  itemCount: context.watch<ShoppingListProvider>().items.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) => {
                        _removeFromList(
                            context.read<ShoppingListProvider>().items[index]),
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
    );
  }
}
