import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/core.dart';
import '../../feature.dart';

class CartController extends GetxController {
   ApiClient apiClient;
   CartController({required this.apiClient});
  var cartItems = <CartModel>[].obs;

  @override
  void onInit() {
    loadCart();
    loadFav();
    super.onInit();
  }

  void loadCart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? cartJson = preferences.getStringList(SharedPreferenceHelper.cart);
    if (cartJson != null) {
      cartItems.value =
          cartJson.map((item) => CartModel.fromJson(jsonDecode(item))).toList();
    }
  }

  void saveCart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> cartJson =
        cartItems.map((item) => jsonEncode(item.toJson())).toList();
    await preferences.setStringList(SharedPreferenceHelper.cart, cartJson);
    update();
  }

  void loadFav() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? storedFavorites = prefs.getStringList(SharedPreferenceHelper.favCart);
    if (storedFavorites != null) {
      List<ProductModel> favoriteProducts = storedFavorites
          .map((product) => ProductModel.fromJson(jsonDecode(product)))
          .toList();
      for (var product in productlist) {
        product.isFavorite.value =
            favoriteProducts.any((fav) => fav.id == product.id);
      }
      update();
    }
  }

  void saveFav() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favProducts = productlist
        .where((product) => product.isFavorite.value)
        .map((product) => jsonEncode(product.toJson()))
        .toList();
    await prefs.setStringList(SharedPreferenceHelper.favCart, favProducts);
    update();
  }

  void addToCart(ProductModel product) {
    if (product.stock > 0) {
      int index = cartItems.indexWhere((item) => item.product.id == product.id);
      if (index != -1) {
        cartItems[index].quantity++;
        product.decreaseStock(1);
      } else {
        cartItems.add(CartModel(product: product, quantity: 1));
        product.decreaseStock(1);
      }
    } else {
      Get.snackbar("Out of Stock", "${product.name} is not available");
    }
    saveCart();
    update();
  }

  /// Remove product from cart and restore stock
  void removeFromCart(ProductModel product) {
    int index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
        product.increaseStock(1);
      } else {
        cartItems.removeAt(index);
        product.increaseStock(1);
      }
    }
    saveCart();
    update();
  }

  void onFavo(ProductModel product) async {
    product.toggleFavorite();
    saveFav();
    update();
  }

  /// Get total price
  double get totalPrice => cartItems.fold(
      0, (sum, item) => sum + (item.product.price * item.quantity));

  bool isInCart(ProductModel product) {
    return cartItems.any((p) => p.product.id == product.id);
  }

  int get totalItems => cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get totalAmount => cartItems.fold(
      0, (sum, item) => sum + (item.product.price * item.quantity));

  void updateProductQty(ProductModel product, int newQty) {
    int index = cartItems.indexWhere((p) => p.product.id == product.id);
    if (index != -1) {
      if (newQty > 0 && newQty <= product.stock) {
        cartItems[index].quantity = newQty;
        product.decreaseStock(newQty - cartItems[index].quantity);
        saveCart();
        update();
      } else {
        Get.snackbar("Invalid Quantity", "Please enter a valid quantity.");
      }
    }
    update();
  }

  List<ProductModel> get favoriteProducts {
    return productlist.where((product) => product.isFavorite.value).toList();
  }

}
