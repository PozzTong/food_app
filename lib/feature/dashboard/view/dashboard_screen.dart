import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/common.dart';
import '../../../core/core.dart';
import '../../feature.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.7);

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              // color: Colors.amber,
              image: DecorationImage(
                image: AssetImage(
                  'assets/image/code_clans_logo.png',
                ),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ),
        title: Text(
          'Hello,Daniel',
        ),
        actions: [
          Obx(() {
            return Badges(
              icon: Icons.notifications_active_outlined,
              size: 30,
              color: Colors.pink,
              text: productController.cart.length.toString(),
              isShow: productController.cart.isNotEmpty,
              tap: () {
                Get.to(CartPage());
              },
            );
          })
        ],
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                            top: 5,
                            left: 15,
                            right: 15,
                            bottom: 5,
                          ),
                          suffixIcon: Icon(
                            Icons.search,
                          ),
                          hintText: 'search',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.pink.withOpacity(0.2),
                    ),
                    child: Icon(
                      Icons.filter_list,
                      color: Colors.pink,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: size.width - 20,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  // color: Colors.amber,
                  gradient: LinearGradient(
                    colors: [
                      Colors.redAccent.withOpacity(0.8),
                      Colors.pink,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 300,
                        width: 200,
                        child: Image.asset(
                          'assets/image/burger.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Spacial Deal For December',
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: size.width / 3,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.yellow,
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )
                                  // shape: RoundedRectangleBorder(
                                  //   borderRadius: BorderRadius.circular(25),
                                  // ),
                                  ),
                              onPressed: () {},
                              child: Text(
                                'Buy Now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: Text(
                      'Popular Restaurant',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('see all'),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3 - 30,
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: productController.products.length,
                  itemBuilder: (context, index) {
                    final product = productController.products[index];
                    return AnimatedBuilder(
                      animation: _pageController,
                      builder: (context, child) {
                        double page = _pageController.hasClients
                            ? _pageController.page ?? 0
                            : 0;
                        double scale =
                            1.0 - ((page - index).abs() * 0.2).clamp(0.0, 0.2);
                        return TweenAnimationBuilder(
                          tween: Tween<double>(begin: 1.0, end: scale),
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          builder: (context, value, child) {
                            return Transform.scale(
                              scale: value,
                              child: ShoeCard(
                                ass: product.imagePath,
                                title: product.name,
                                subtitle: product.category,
                                add: () {},
                                fav: () {
                                  productController.addToCart(product);
                                  Get.snackbar(
                                    "Cart Updated",
                                    "Added ${product.name} (Qty: ${productController.cart.firstWhere((p) => p.name == product.name, orElse: () => Product(name: '', category: '', price: 0.0, qty: 0, imagePath: '')).qty})",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor:
                                        Colors.green.withOpacity(0.8),
                                    colorText: Colors.white,
                                    duration: Duration(seconds: 2),
                                  );
                                },
                                addColor: Colors.red,
                                favColor: Colors.red,
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: Text(
                      'Popular Menu',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(RouteHelper.menuScreen,
                          arguments: "Popular Menu");
                    },
                    child: Text('see all'),
                  ),
                ],
              ),
              Column(
                children: List.generate(20, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Card(
                      elevation: 5,
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            margin: EdgeInsets.all(8.0),
                            // padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              // color: Colors.amber,
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/image/burger.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text('Original Salad'),
                              subtitle: Text('Lovy Food'),
                              subtitleTextStyle: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '\$8',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(
                height: 70,
              )
            ],
          ),
        );
      }),
    );
  }
}

class CartPage extends StatelessWidget {
  final ProductController productController = Get.find();

   CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: productController.cart.length,
                itemBuilder: (context, index) {
                  final product = productController.cart[index];
                  return ListTile(
                    leading:
                        Image.asset(product.imagePath, width: 50, height: 50),
                    title: Text(product.name),
                    subtitle: Text("Price: \$${product.price}"),
                    trailing: Text("Qty: ${product.qty}"),
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
                          productController.cart
                              .clear(); // Clear cart after checkout
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
