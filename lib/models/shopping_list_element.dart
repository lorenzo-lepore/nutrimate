class ListElement {
  String title;
  String? barcode;
  int quantity;
  bool status;

  ListElement({required this.title, required this.quantity, required this.status, this.barcode});

  @override
  String toString() {
    return 'Person(name: $title, age: $quantity)';
  }
}
