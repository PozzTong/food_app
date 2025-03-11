class Product {
  final String name;
  final String category;
  final double price;
  final double qty;
  final String imagePath;
  final bool isFavorite;

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.qty,
    required this.imagePath,
    this.isFavorite = false,
  });
}
