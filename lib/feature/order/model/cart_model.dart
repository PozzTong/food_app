class CartModel {
  final String id;
  final String name;
  final String category;
  final double price;
  int qty; // Quantity in cart
  final String imagePath;
  final int allqty; // Total stock available

  CartModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.qty, // Qty in cart
    required this.imagePath,
    required this.allqty, // Total stock available in inventory
  });

  // Convert CartModel to JSON (for storage)
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "category": category,
      "price": price,
      "qty": qty,
      "imagePath": imagePath,
      "allqty": allqty, // Store total stock
    };
  }

  // Convert JSON back to CartModel
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json["id"],
      name: json["name"],
      category: json["category"],
      price: json["price"],
      qty: json["qty"],
      imagePath: json["imagePath"],
      allqty: json["allqty"], // Load total stock
    );
  }
}
