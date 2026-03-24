import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/screens/cart/bottom_checkout.dart';
import 'package:shopsmart_users/screens/cart/cart_widget.dart';
import 'package:shopsmart_users/services/assets_manger.dart';
import 'package:shopsmart_users/services/my_app_functions.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/empty_bag.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  final bool isBagEmpty = false;
  @override
  Widget build(BuildContext context) {
    // final productsProvider = Provider.of<ProductsProvider>(context);

    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: cartProvider.getCartItems.isEmpty
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
                  label: "Cart (${cartProvider.getCartItems.length})",
                  size: 24,
                  weight: FontWeight.bold,
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        MyAppFunctions.showErrorOrWarningDialog(
                            isError: false,
                            context: context,
                            fct: cartProvider.clearLocalCart,
                            title: "Clear Cart");
                      },
                      icon: const Icon(
                        IconlyBold.delete,
                        color: Colors.red,
                      ))
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartProvider.getCartItems.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: cartProvider.getCartItems.values
                                .toList()[index],
                            child: CartWidget());
                      },
                    ),
                  ),
                  SizedBox(height: kBottomNavigationBarHeight),
                ],
              ),
              bottomNavigationBar: Cartbottomsheetwidget(),
            ),
    );
  }
}
