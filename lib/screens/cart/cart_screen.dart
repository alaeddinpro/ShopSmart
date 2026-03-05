import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopsmart_users/screens/cart/bottom_checkout.dart';
import 'package:shopsmart_users/screens/cart/cart_widget.dart';
import 'package:shopsmart_users/services/assets_manger.dart';
import 'package:shopsmart_users/widgets/appnametextwidget.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

import '../../widgets/empty_bag.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  final bool isBagEmpty = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isBagEmpty
          ? EmptyBag(
              imagePath: AssetsManager.shoppingbasket,
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
                  label: "Cart",
                  size: 24,
                  weight: FontWeight.bold,
                ),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        IconlyLight.delete,
                        color: Colors.red,
                      ))
                ],
              ),
              body: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CartWidget();
                },
              ),
              bottomNavigationBar: Cartbottomsheetwidget(),
            ),
    );
  }
}
