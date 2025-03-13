import 'package:flutter/material.dart';
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
              return Card(
                elevation: 0,
                child: ListTile(
                  leading: Image.asset(product.image),
                  title: Text(product.name),
                  subtitle: Text("Price: \$${product.price}"),
                  trailing: IconButton(
                    icon: Icon(Icons.favorite),
                    color: product.isFavorite.value ? Colors.red : Colors.grey,
                    onPressed: () {
                      cartController.onFavo(product);
                    },
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
