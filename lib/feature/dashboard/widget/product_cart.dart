import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../feature.dart';

class CartPage extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();

  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shopping Cart")),
      body: Obx(() {
        if (productController.cart.isEmpty) {
          return Center(child: Text("Your cart is empty."));
        }
        return ListView.builder(
          itemCount: productController.cart.length,
          itemBuilder: (context, index) {
            final product = productController.cart[index];
            return Card(
              child: ListTile(
                leading: Image.asset(product.imagePath,
                    width: 50, height: 50, fit: BoxFit.cover),
                title: Text(product.name),
                subtitle: Text("\$${product.price}"),
                trailing: IconButton(
                  icon: Icon(Icons.remove_shopping_cart),
                  onPressed: () {
                    productController.removeFromCart(product);
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
