import 'package:flutter/material.dart';
import 'package:food_app/core/core.dart';
import 'package:get/get.dart';

import '../../feature.dart';

class FavoriteScreen extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: GetBuilder<CartController>(
        builder: (cartController) {
          var favoriteProducts = cartController.favoriteProducts;
          return ListView.builder(
            itemCount: favoriteProducts.length,
            itemBuilder: (context, index) {
              var product = favoriteProducts[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(
                    RouteHelper.shoeDetail,
                    arguments: {
                      'index': index,
                      'image': product.image,
                      'price': product.price,
                      'name': product.name,
                      'cate': product.category,
                    },
                  );
                },
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    leading: Hero(
                      tag: product.id,
                      child: Image.asset(product.image),
                    ),
                    title: Hero(
                      tag: product.name,
                      child: Material(
                        color: Colors.transparent,
                        child: Text(product.name),
                      ),
                    ),
                    subtitle: Text("Price: \$${product.price}"),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite),
                      color:
                          product.isFavorite.value ? Colors.red : Colors.grey,
                      onPressed: () {
                        cartController.onFavo(product);
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
