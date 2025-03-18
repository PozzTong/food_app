import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_app/core/core.dart';
import 'package:get/get.dart';

import '../../../common/common.dart';
import '../../feature.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.find();

  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: BackLead(),
        title: Text(
          "Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      child: Slidable(
                        key: const ValueKey(0),
                        closeOnScroll: true,
                        endActionPane: ActionPane(
                          dismissible: DismissiblePane(onDismissed: () {
                            cartController.removeonceFromCart(cart.product);
                          }), // scroll to close
                          motion: const DrawerMotion(),
                          extentRatio: 0.25,
                          openThreshold: 0.2,
                          closeThreshold: 0.2,
                          children: [
                            SlidableAction(
                              flex: 1,
                              padding: EdgeInsets.all(8),
                              borderRadius: BorderRadius.circular(5),
                              // spacing: 4,
                              onPressed: (_) {
                                cartController.removeonceFromCart(cart.product);
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete_outline,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: SizedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                height: size.width * 0.3,
                                width: size.width * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey,
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      top: -40,
                                      right: -20,
                                      left: 5,
                                      bottom: 0,
                                      child: Image.asset(cart.product.image),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  height: 100,
                                  margin: EdgeInsets.only(top: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // ignore: unnecessary_string_interpolations
                                      Text(
                                        cart.product.name,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        '\$ ${cartController.getItemTotalPrice(cart.product)}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              cartController
                                                  .removeFromCart(cart.product);
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(),
                                              child:
                                                  Icon(Icons.horizontal_rule),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(4),
                                            height: 25,
                                            width: 40,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              // color: Colors.amber,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.grey),
                                            ),
                                            child: Text('${cart.quantity}'),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              cartController
                                                  .addToCart(cart.product);
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(),
                                              child: Icon(Icons.add),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Amount",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        " \$${cartController.totalAmount.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: size.width * 0.7,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        // if (cartController.cartItems.isNotEmpty) {
                        //   Future.delayed(Duration(seconds: 1), () {
                        //     Get.back();
                        //   });
                        //   Get.snackbar(
                        //     "Order Placed",
                        //     "Your order has been placed successfully!",
                        //     snackPosition: SnackPosition.BOTTOM,
                        //     backgroundColor: Colors.green,
                        //     colorText: Colors.white,
                        //   );
                        //   cartController.cartItems.clear();
                        //   cartController.saveCart();
                        // Wait a moment before navigating back
                        // } else {
                        //   Get.back();
                        //   Get.snackbar(
                        //     "Cart Empty",
                        //     "Add items to your cart before proceeding.",
                        //     snackPosition: SnackPosition.BOTTOM,
                        //     backgroundColor: Colors.red,
                        //     colorText: Colors.white,
                        //   );
                        // }
                        Get.toNamed(RouteHelper.checkOut);
                      },
                      child: Text(
                        "Payment".toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
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
