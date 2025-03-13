import '../../feature.dart';

class CartModel {
  final ProductModel product;
  int quantity;

  CartModel({
    required this.product,
    required this.quantity,
  });

  /// Convert CartModel to JSON
  Map<String, dynamic> toJson() {
    return {
      "product": product.toJson(),
      "quantity": quantity,
    };
  }

  /// Create CartModel from JSON
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      product: ProductModel.fromJson(json["product"]),
      quantity: json["quantity"],
    );
  }
}
