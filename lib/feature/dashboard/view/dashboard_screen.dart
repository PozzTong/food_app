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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<CartController>(builder: (cartController) {
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
            'Hello,',
          ),
          actions: [
            Badges(
              icon: Icons.notifications_active_outlined,
              size: 30,
              color: Colors.pink,
              text: cartController.cartItems.length.toString(),
              isShow: cartController.cartItems.isNotEmpty,
              tap: () {
                Get.to(CartPage());
              },
            )
          ],
        ),
        body: GetBuilder<CartController>(
          builder: (cartController) {
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
                                top: 0,
                                left: 15,
                                right: 15,
                                bottom: 0,
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
                      itemCount: productlist.length,
                      itemBuilder: (context, index) {
                        final product = productlist[index];
                        return AnimatedBuilder(
                          animation: _pageController,
                          builder: (context, child) {
                            double page = _pageController.hasClients
                                ? _pageController.page ?? 0
                                : 0;
                            double scale = 1.0 -
                                ((page - index).abs() * 0.2).clamp(0.0, 0.2);
                            return TweenAnimationBuilder(
                              tween: Tween<double>(begin: 1.0, end: scale),
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                              builder: (context, value, child) {
                                return Transform.scale(
                                    scale: value,
                                    child: ShoeCard(
                                      ass: product.image,
                                      title: product.name,
                                      subtitle: product.category,
                                      add: () {
                                        cartController.addToCart(
                                          product,
                                        );
                                        Get.snackbar(
                                          product.name,
                                          'Qty: ${cartController.cartItems.firstWhere(
                                                (p) =>
                                                    p.product.name ==
                                                    product.name,
                                                orElse: () => CartModel(
                                                    product: product,
                                                    quantity:
                                                        0), // Fallback value
                                              ).quantity}',
                                          onTap: (snack) => Get.to(CartPage()),
                                        );
                                      },
                                      addColor: Colors.red,
                                      fav: () {
                                        cartController.onFavo(product);
                                      },
                                      favColor: product.isFavorite.value
                                          ? Colors.pink
                                          : Colors.black,
                                    ));
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
                    children: List.generate(5, (index) {
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
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
          },
        ),
      );
    });
  }
}
