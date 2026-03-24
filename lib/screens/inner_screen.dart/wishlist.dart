import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/wishlist_provider.dart';
import 'package:shopsmart_users/screens/cart/bottom_checkout.dart';
import 'package:shopsmart_users/screens/cart/cart_widget.dart';
import 'package:shopsmart_users/services/assets_manger.dart';
import 'package:shopsmart_users/widgets/products/product_widget.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

import '../../services/my_app_functions.dart';
import '../../widgets/empty_bag.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

  static const routName = "/WishlistScreen";

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return Scaffold(
      body: wishlistProvider.getWishlistItems.isEmpty
          ? EmptyBag(
              imagePath: AssetsManager.bagwish,
              title: "Your cart is empty",
              subtitle:
                  "Looks like you haven't added anything to your cart yet",
              buttonText: "Shop Now",
            )
          : Scaffold(
              appBar: AppBar(
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(AssetsManager.shoppingcart),
                ),
                title: SubtitleText(
                  label:
                      "Wish List (${wishlistProvider.getWishlistItems.length})",
                  size: 24,
                  weight: FontWeight.bold,
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        MyAppFunctions.showErrorOrWarningDialog(
                            isError: false,
                            context: context,
                            fct: wishlistProvider.clearLocalWishlist,
                            title: "Clear Wishlist");
                      },
                      icon: const Icon(
                        IconlyBold.delete,
                        color: Colors.red,
                      ))
                ],
              ),
              body: DynamicHeightGridView(
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                builder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProductWidget(
                      productId: wishlistProvider.getWishlistItems.values
                          .toList()[index]
                          .productId,
                    ),
                  );
                },
                itemCount: wishlistProvider.getWishlistItems.length,
                crossAxisCount: 2,
              ),
            ),
    );
  }
}
