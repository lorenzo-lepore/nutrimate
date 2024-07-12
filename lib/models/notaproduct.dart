class Product {
  final String barcode;
  final String name;

  const Product({
    required this.barcode,
    required this.name,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'code': String code,
        'name': String name,
      } =>
        Product(
          barcode: code,
          name: name,
        ),
      _ => throw const FormatException('Failed to load product.'),
    };
  }
}