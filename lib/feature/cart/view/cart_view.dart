import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/common.dart';
import '../../feature.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.find();

  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackLead(), title: Text("Cart")),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<CartController>(
              builder: (cartController) {
                return ListView.builder(
                  itemCount: cartController.cartItems.length,
                  itemBuilder: (context, index) {
                    final cart = cartController.cartItems[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Card(
                        elevation: 10,
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                leading: Image.asset(cart.product.image,
                                    width: 80, height: 80),
                                title: Text(cart.product.name),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Price: \$${cart.product.price}"),
                                    Text('Instock: ${cart.product.stock}'),
                                    // Text('Remain ${cartController.products}')
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.pink,
                                ),
                                child: Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        cartController.addToCart(cart.product);
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      // color: Colors.amber,
                                      height: 40,
                                      width: 50,
                                      child: Center(
                                        child: TextField(
                                          controller: TextEditingController(
                                              text: '${cart.quantity}')
                                            ..selection =
                                                TextSelection.collapsed(
                                                    offset: '${cart.quantity}'
                                                        .length),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                          onChanged: (value) {
                                            int? newQty = int.tryParse(value);
                                            if (newQty != null && newQty >= 0) {
                                              cartController.updateProductQty(
                                                  productlist[index], newQty);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        cartController
                                            .removeFromCart(cart.product);
                                      },
                                      icon: Icon(
                                        Icons.horizontal_rule,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          GetBuilder<CartController>(builder: (cartController) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "Total Items: ${cartController.totalItems}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Total Amount: \$${cartController.totalAmount.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (cartController.cartItems.isNotEmpty) {
                        Get.snackbar(
                          "Order Placed",
                          "Your order has been placed successfully!",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                        cartController.cartItems.clear();
                        // cartController.saveCart();
                      } else {
                        Get.snackbar(
                          "Cart Empty",
                          "Add items to your cart before proceeding.",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    },
                    child: Text("Checkout"),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
