import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/common.dart';
import '../../feature.dart';

class CartPage extends StatelessWidget {
  final ProductController productController = Get.find();

  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackLead(), title: Text("Cart")),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: productController.cart.length,
                itemBuilder: (context, index) {
                  final cart = productController.cart[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Card(
                      elevation: 10,
                      child: Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              leading: Image.asset(cart.imagePath,
                                  width: 50, height: 50),
                              title: Text(cart.name),
                              subtitle: Column(
                                children: [
                                  Text("Price: \$${cart.price}"),
                                  Text('Instock ${cart.qty}'),
                                  // Text('Remain ${productController.products}')
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.pink),
                              child: Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      productController.addtoCartMore(cart, 5);
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
                                            text: '${cart.qty}')
                                          ..selection = TextSelection.collapsed(
                                              offset: '${cart.qty}'.length),
                                        textAlign: TextAlign.center,
                                        // textAlignVertical:
                                        //     TextAlignVertical.top,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                        onChanged: (value) {
                                          // int? newQty = int.tryParse(value);
                                          // if (newQty != null && newQty >= 0) {
                                          //   productController.updateProductQty(
                                          //       product, newQty);
                                          // }
                                        },
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      productController.removeFromCart(cart);
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
            }),
          ),
          Obx(() => Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Total Items: ${productController.totalItems}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Total Amount: \$${productController.totalAmount.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (productController.cart.isNotEmpty) {
                          Get.snackbar(
                            "Order Placed",
                            "Your order has been placed successfully!",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                          );
                          productController.cart.clear();
                          productController.saveCart();
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
              )),
        ],
      ),
    );
  }
}
