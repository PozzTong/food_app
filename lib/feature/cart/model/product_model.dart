import 'package:get/get.dart';

class ProductModel {
  final int id;
  final String name;
  final String category;
  final double price;
  final String image;
  int stock;
  var isFavorite = false.obs;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    required this.stock,
    bool? isFavorite,
  }) {
    this.isFavorite.value = isFavorite ?? false;
  }

  /// Convert ProductModel to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "category": category,
      "price": price,
      "image": image,
      "stock": stock,
      "isFavorite": isFavorite.value,
    };
  }

  /// Create ProductModel from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      name: json["name"],
      category: json["category"],
      price: (json["price"] as num).toDouble(),
      image: json["image"],
      stock: json["stock"],
      isFavorite: json["isFavorite"] ?? false, // Handle null case
    );
  }

  /// Toggle Favorite Status
  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  /// Decrease stock when adding to cart
  void decreaseStock(int quantity) {
    if (stock >= quantity) {
      stock -= quantity;
    }
  }

  /// Increase stock when removing from cart
  void increaseStock(int quantity) {
    stock += quantity;
  }
}

// Fix: Remove leading zeros in IDs
RxList<ProductModel> productlist = <ProductModel>[
  ProductModel(
    id: 1,
    name: "Puma RS-2 LHT Trainers",
    category: "Men's sneakers",
    price: 125.0,
    stock: 12,
    image: "assets/image/shoe.png",
  ),
  ProductModel(
    id: 2,
    name: "Nike Air Max",
    category: "Running shoes",
    price: 150.0,
    stock: 10,
    image: "assets/image/belleza.png",
  ),
  ProductModel(
    id: 3,
    name: "Adidas Ultraboost",
    category: "Performance sneakers",
    price: 180.0,
    stock: 5,
    image: "assets/image/air.png",
  ),
  ProductModel(
    id: 4,
    name: "Reebok Classic",
    category: "Casual sneakers",
    price: 95.0,
    stock: 2,
    image: "assets/image/belleza.png",
  ),
].obs;
