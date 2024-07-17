import 'package:flutter/material.dart';
import 'package:nutrimate/models/shopping_list_element.dart';

class ShoppingListProvider extends ChangeNotifier {
  final List<ListElement> items = [
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

  void insertItem(int index, ListElement item) {
    items.insert(index, item);
    notifyListeners();
  }

  void addToItemsToBuy(ListElement item) {
    items.add(item);
    notifyListeners();
  }

  void removeFromList(ListElement item) {
    try {
      items.remove(item);
      notifyListeners();
    } catch (e) {
      throw Exception('Rimozione fallita: $e');
    }
  }

  void modifyItemDetails(int index, {String? title, int? quantity}) {
    try {
      if (title != null) {
        items[index].title = title;
      }
      if (quantity != null) {
        items[index].quantity = quantity;
      }
      notifyListeners();
    } catch (e) {
      throw Exception('Modifica fallita: $e');
    }
  }
}
