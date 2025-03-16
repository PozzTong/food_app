import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/common.dart';
import '../../../core/core.dart';
import '../../feature.dart';

class ShoeDetail extends StatefulWidget {
  const ShoeDetail({super.key});
  @override
  State<ShoeDetail> createState() => _ShoeDetailState();
}

class _ShoeDetailState extends State<ShoeDetail> {
  Color? colors;
  List<String> sizes = [
    '6',
    '6.5',
    '7',
    '7.5',
  ];
  int? _selectedIndex;
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final int index = arguments['index'];
    final String image = arguments['image'];
    final double price = arguments['price'];
    final String name = arguments['name'];
    final String cate = arguments['cate'];
    Size size = MediaQuery.of(context).size;
    Color color = Theme.of(context).scaffoldBackgroundColor;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    colors = isDarkMode ? Colors.white : Colors.black;
    return GetBuilder<CartController>(builder: (controller) {
      return Scaffold(
        body: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              color: color,
            ),
            Positioned(
              top: size.height * 0.05,
              child: Container(
                height: size.height * 0.5,
                width: size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/image/backg.png'),
                    fit: BoxFit.cover, // Adjust as needed
                  ),
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.1,
              left: size.width * 0.05,
              right: size.width * 0.05,
              child: Hero(
                tag: productlist[index].id,
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                  height: size.height * 0.4,
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.5,
              left: size.width * 0.1,
              right: size.width * 0.1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Hero(
                    tag: productlist[index].name,
                    child: Text(
                      name,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: colors
                          // letterSpacing: 0.0050,
                          // wordSpacing: 0.0050,
                          ),
                    ),
                  ),
                  Text(
                    cate,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: colors
                        // letterSpacing: 0.0050,
                        // wordSpacing: 0.0050,
                        ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        '\$ ',
                        style: style(
                          size: 22,
                          color: Colors.red,
                          fw: FontWeight.normal,
                        ),
                      ),
                      Text(
                        '$price',
                        style: style(
                          size: 18,
                          color: colors!,
                          fw: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '⭐ 4.8 (2k reviews)',
                        style: style(
                          size: 16,
                          color: colors!,
                          fw: FontWeight.normal,
                        ),
                      ),
                      Text(
                        'Free Shipping',
                        style: style(
                          size: 12,
                          color: colors!,
                          fw: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Size',
                        style: style(
                          size: 20,
                          color: colors!,
                          fw: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Select Guide',
                        style: style(
                          size: 15,
                          color: colors!,
                          fw: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                      (index) => Padding(
                        padding: EdgeInsets.all(6),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          child: Card(
                            elevation: 5,
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: Center(
                                child: Text(
                                  sizes[index],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: _selectedIndex == index
                                        ? Colors.deepPurple
                                        : colors,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: SizedBox(
                      width: size.width * 0.65,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.addToCart(productlist[index]);
                          Get.snackbar(
                            name,
                            'Qty: ${controller.cartItems.firstWhere(
                                  (p) =>
                                      p.product.name == productlist[index].name,
                                  orElse: () => CartModel(
                                    product: productlist[index],
                                    quantity: 0,
                                  ),
                                ).quantity}',
                            onTap: (snack) => Get.toNamed(RouteHelper.cartPage),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                        child: Text(
                          'add to cart'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: size.height * 0.05,
              left: 5,
              right: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackLead(),
                  IconButton(
                    onPressed: () {
                      controller.onFavo(productlist[index]);
                    },
                    icon: Icon(
                      Icons.favorite,
                      size: 35,
                      color: productlist[index].isFavorite.value
                          ? Colors.red
                          : colors,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  TextStyle style({
    required double size,
    required Color color,
    required FontWeight fw,
  }) {
    return TextStyle(
      decoration: TextDecoration.none,
      fontSize: size,
      color: color,
      fontWeight: fw,
    );
  }
}
