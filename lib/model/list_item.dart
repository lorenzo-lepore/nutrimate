class ListItem {
  String title;
  String? barcode;
  int quantity;
  bool status;

  ListItem(
      {required this.title,
      required this.quantity,
      required this.status,
      this.barcode});

  @override
  String toString() {
    return 'ListItem(name: $title, age: $quantity)';
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'quantity': quantity,
      'status': status,
      'barcode': barcode,
    };
  }

  factory ListItem.fromJson(Map<String, dynamic> json) {
    return ListItem(
      title: json['title'],
      quantity: json['quantity'],
      status: json['status'],
      barcode: json['barcode'],
    );
  }
}
