import 'package:get/get.dart';
import '../../feature.dart';

class ProductController extends GetxController {
  // Observable list of products
  var products = <Product>[
    Product(
      name: "Puma RS-2 LHT Trainers",
      category: "Men's sneakers",
      price: 125.0,
      qty: 12,
      imagePath: "assets/image/shoe.png",
    ),
    Product(
      name: "Nike Air Max",
      category: "Running shoes",
      price: 150.0,
      qty: 10,
      imagePath: "assets/image/belleza.png",
    ),
    Product(
      name: "Adidas Ultraboost",
      category: "Performance sneakers",
      price: 180.0,
      qty: 5,
      imagePath: "assets/image/air.png",
    ),
    Product(
      name: "Reebok Classic",
      category: "Casual sneakers",
      price: 95.0,
      qty: 1,
      imagePath: "assets/image/belleza.png",
    ),
  ].obs;

  // Observable list for cart
  var cart = <Product>[].obs;

  // Add product to the cart or increase quantity if it already exists
  void addToCart(Product product) {
    int index = cart.indexWhere((p) => p.name == product.name);
    if (index != -1) {
      cart[index] = Product(
        name: cart[index].name,
        category: cart[index].category,
        price: cart[index].price,
        qty: cart[index].qty + 1, // Increase qty
        imagePath: cart[index].imagePath,
      );
    } else {
      cart.add(Product(
        name: product.name,
        category: product.category,
        price: product.price,
        qty: 1, // Add with qty 1 initially
        imagePath: product.imagePath,
      ));
    }
  }

  // Remove product from cart (or decrease quantity if more than 1)
  void removeFromCart(Product product) {
    int index = cart.indexWhere((p) => p.name == product.name);
    if (index != -1) {
      if (cart[index].qty > 1) {
        cart[index] = Product(
          name: cart[index].name,
          category: cart[index].category,
          price: cart[index].price,
          qty: cart[index].qty - 1, // Decrease qty
          imagePath: cart[index].imagePath,
        );
      } else {
        cart.removeAt(index); // Remove if qty is 1
      }
    }
  }

  // Check if a product is in the cart
  bool isInCart(Product product) {
    return cart.any((p) => p.name == product.name);
  }

  // Get total quantity of items in cart
  // int get totalItems => cart.fold(0, (sum, item) => sum + item.qty);
  // Get total quantity of items in cart
  int get totalItems => cart.fold(0, (sum, item) => sum + item.qty.toInt());

  // Get total amount of the cart
  double get totalAmount =>
      cart.fold(0, (sum, item) => sum + (item.price * item.qty));
}
