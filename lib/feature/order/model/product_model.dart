import 'package:get/get.dart';

class Product {
  final int id;
  final String name;
  final String category;
  final double price;
  final int qty;
  final String imagePath;
  var isFavorite = false.obs; // Convert to RxBool

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.qty,
    required this.imagePath,
    bool isFavorite = false,
  }) {
    this.isFavorite.value = isFavorite; // Initialize
  }

  // Convert Product to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      "id":id,
      "name": name,
      "category": category,
      "price": price,
      "qty": qty,
      "imagePath": imagePath,
      "isFavorite": isFavorite.value, // Save favorite status
    };
  }

  // Convert JSON to Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      name: json["name"],
      category: json["category"],
      price: json["price"],
      qty: json["qty"],
      imagePath: json["imagePath"],
      isFavorite: json["isFavorite"] ?? false,
    );
  }
}


RxList productlist = <Product>[
  Product(
    id: 001,
    name: "Puma RS-2 LHT Trainers",
    category: "Men's sneakers",
    price: 125.0,
    qty: 12,
    imagePath: "assets/image/shoe.png",
  ),
  Product(
    id: 002,
    name: "Nike Air Max",
    category: "Running shoes",
    price: 150.0,
    qty: 10,
    imagePath: "assets/image/belleza.png",
  ),
  Product(
    id: 003,
    name: "Adidas Ultraboost",
    category: "Performance sneakers",
    price: 180.0,
    qty: 5,
    imagePath: "assets/image/air.png",
  ),
  Product(
    id: 004,
    name: "Reebok Classic",
    category: "Casual sneakers",
    price: 95.0,
    qty: 1,
    imagePath: "assets/image/belleza.png",
  ),
].obs;
