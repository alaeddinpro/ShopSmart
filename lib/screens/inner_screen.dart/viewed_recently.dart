import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/viewed_provider.dart';
import 'package:shopsmart_users/screens/cart/bottom_checkout.dart';
import 'package:shopsmart_users/screens/cart/cart_widget.dart';
import 'package:shopsmart_users/services/assets_manger.dart';
import 'package:shopsmart_users/widgets/products/product_widget.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

import '../../widgets/empty_bag.dart';

class ViewedRecently extends StatelessWidget {
  const ViewedRecently({super.key});
  static const routName = "/ViewedRecentlyScreen";

  @override
  Widget build(BuildContext context) {
    final viewedProvider = Provider.of<ViewedProvider>(context);
    return Scaffold(
      body: viewedProvider.getViewedItems.isEmpty
          ? EmptyBag(
              imagePath: AssetsManager.orderbag,
              title: "No viewed product yet!",
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
                      "Viewed Recently (${viewedProvider.getViewedItems.length})",
                  size: 24,
                  weight: FontWeight.bold,
                ),
              ),
              body: DynamicHeightGridView(
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                builder: (context, index) {
                  return ProductWidget(
                    productId: viewedProvider.getViewedItems.values
                        .toList()[index]
                        .productId,
                  );
                },
                itemCount: viewedProvider.getViewedItems.length,
                crossAxisCount: 2,
              ),
            ),
    );
  }
}
