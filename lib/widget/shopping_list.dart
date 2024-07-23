import 'package:flutter/material.dart';
import 'package:nutrimate/model/list_item.dart';
import 'package:nutrimate/provider/shopping_list_provider.dart';
import 'package:nutrimate/widget/empty_list.dart';
import 'package:nutrimate/widget/shopping_list_item.dart';
import 'package:provider/provider.dart';

class ShoppingListPage extends StatelessWidget {
  const ShoppingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    void removeFromList(ListItem item) {
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

    return Visibility(
      visible: !context.watch<ShoppingListProvider>().isLoading,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: context.watch<ShoppingListProvider>().items.isEmpty
            ? const EmptyList()
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
                        removeFromList(
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
