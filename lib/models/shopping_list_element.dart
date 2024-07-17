class ListElement {
  final String title;
  final String? barcode;
  int quantity;

  ListElement({required this.title, required this.quantity, this.barcode});

  @override
  String toString() {
    return 'Person(name: $title, age: $quantity)';
  }
}
