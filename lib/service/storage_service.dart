import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutrimate/model/list_item.dart';

class StorageService {
  Future<void> saveItems(List<ListItem> items) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> itemsData = items.map((item) => item.toJson()).toList();
    await prefs.setString('items', jsonEncode(itemsData));
  }

  Future<List<ListItem>> loadItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? itemsJson = prefs.getString('items');
    if (itemsJson != null) {
      List<dynamic> itemsData = jsonDecode(itemsJson);
      return itemsData.map((itemData) => ListItem.fromJson(itemData)).toList();
    }
    return [];
  }
}