import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/core.dart';
import '../../feature.dart';

class ProductController extends GetxController {
  RxList<Product> productList = <Product>[].obs;
  RxList<Product> cart = <Product>[].obs;

  @override
  void onInit() {
    loadCart();
    loadFav();

    super.onInit();
  }

  void saveCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartJson =
        cart.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(LocalConfig.cart, cartJson);
  }

  void loadCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartJson = prefs.getStringList(LocalConfig.cart);

    if (cartJson != null) {
      cart.value =
          cartJson.map((item) => Product.fromJson(jsonDecode(item))).toList();
    }
  }

  void saveFav() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favProducts = productlist
        .where((product) => product.isFavorite.value) // Store only favorites
        .map((product) => jsonEncode(product.toJson()))
        .toList();
    await prefs.setStringList(LocalConfig.favCart, favProducts);
  }

  void loadFav() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? storedFavorites = prefs.getStringList(LocalConfig.favCart);

    if (storedFavorites != null) {
      List<Product> favoriteProducts = storedFavorites
          .map((product) => Product.fromJson(jsonDecode(product)))
          .toList();

      for (var product in productlist) {
        product.isFavorite.value =
            favoriteProducts.any((fav) => fav.id == product.id);
      }
      update();
    }
  }

  void toggleFavorite(Product product) async {
    product.isFavorite.value = !product.isFavorite.value;
    saveFav();
    update();
  }

  void addToCart(Product product) {
    int index = cart.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      if (cart[index].qty < product.qty) {
        
        cart[index] = Product(
          id: cart[index].id,
          name: cart[index].name,
          category: cart[index].category,
          price: cart[index].price,
          qty: cart[index].qty + 1,
          imagePath: cart[index].imagePath,
        );
      } else {
        // Inform the user if the stock is insufficient
        Get.snackbar(
            "Out of stock", "You cannot add more than ${product.qty} items.");
      }
    } else {
      // Add the product to cart if not already in cart
      if (product.qty > 0) {
        cart.add(Product(
          id: product.id,
          name: product.name,
          category: product.category,
          price: product.price,
          qty: 1,
          imagePath: product.imagePath,
        ));
      } else {
        // If stock is zero, inform the user
        Get.snackbar("Out of stock", "Product is out of stock.");
      }
    }
    saveCart();
    update();
  }

  void addtoCartMore(Product product, int maxQty) {
    int index = cart.indexWhere((p) => p.name == product.name);

    if (index != -1) {
      if (cart[index].qty < maxQty) {
        cart[index] = Product(
          id: cart[index].id,
          name: cart[index].name,
          category: cart[index].category,
          price: cart[index].price,
          qty: cart[index].qty + 1,
          imagePath: cart[index].imagePath,
        );
      }
    } else {
      cart.add(Product(
        id: product.id,
        name: product.name,
        category: product.category,
        price: product.price,
        qty: 1,
        imagePath: product.imagePath,
      ));
    }
    saveCart();
  }

  void removeFromCart(Product product) {
    int index = cart.indexWhere((p) => p.id == product.id);
    if (cart[index].qty > 1) {
      cart[index] = Product(
        id: product.id,
        name: cart[index].name,
        category: cart[index].category,
        price: cart[index].price,
        qty: cart[index].qty - 1,
        imagePath: cart[index].imagePath,
      );
    } else {
      cart.removeAt(index);
    }

    saveCart();
    update();
  }

  bool isInCart(Product product) {
    return cart.any((p) => p.name == product.name);
  }

  int get totalItems => cart.fold(0, (sum, item) => sum + item.qty);

  double get totalAmount =>
      cart.fold(0, (sum, item) => sum + (item.price * item.qty));

  // void updateProductQty(Product product, int newQty) {
  //   int index = cart.indexWhere((p) => p.name == product.name);
  //   if (index != -1) {
  //     if (newQty > 0 && newQty <= product.qty) {
  //       cart[index] = Product(
  //         id: cart[index].id,
  //         name: cart[index].name,
  //         category: cart[index].category,
  //         price: cart[index].price,
  //         qty: newQty,
  //         imagePath: cart[index].imagePath,
  //       );
  //     } else if (newQty == 0) {
  //       cart.removeAt(index);
  //     } else {
  //       Get.snackbar("Insufficient stock",
  //           "You cannot set quantity greater than available stock.");
  //     }
  //   }
  //   update();
  // }
  // int get totalQuantity => products.fold(0, (sum, product) => sum + product.qty.);
}
