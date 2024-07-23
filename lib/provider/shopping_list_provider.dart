import 'package:flutter/material.dart';
import 'package:nutrimate/model/list_item.dart';
import 'package:nutrimate/service/storage_service.dart';

class ShoppingListProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  List<ListItem> items = [];
  bool isLoading = true;

  ShoppingListProvider() {
    loadItems();
  }

  Future<void> loadItems() async {
    items = await _storageService.loadItems();
    isLoading = false;
    notifyListeners();
  }

  void insertItem(int index, ListItem item) {
    items.insert(index, item);
    _storageService.saveItems(items);
    notifyListeners();
  }

  void addToItemsList(ListItem item) {
    items.add(item);
    _storageService.saveItems(items);
    notifyListeners();
  }

  void removeFromList(ListItem item) {
    try {
      items.remove(item);
      _storageService.saveItems(items);
      notifyListeners();
    } catch (e) {
      throw Exception('Rimozione fallita: $e');
    }
  }

  void changeItemStatus(int index) {
    try {
      items[index].status = !items[index].status;
      _storageService.saveItems(items);
      notifyListeners();
    } catch (e) {
      throw Exception('Cambio stato fallito: $e');
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
      _storageService.saveItems(items);
      notifyListeners();
    } catch (e) {
      throw Exception('Modifica fallita: $e');
    }
  }
}
