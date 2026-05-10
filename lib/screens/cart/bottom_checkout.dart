import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

import '../../providers/cart_provider.dart';
import '../../providers/products_provider.dart';

class Cartbottomsheetwidget extends StatelessWidget {
  const Cartbottomsheetwidget({super.key, required this.function});
  final Function function;
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: SizedBox(
          height: kBottomNavigationBarHeight + 10,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubtitleText(
                      label:
                          "Total(${cartProvider.getCartItems.length} products/${cartProvider.getQuantity()} items)"),
                  SubtitleText(
                    label:
                        "${cartProvider.getTotalPrice(productsProvider: productsProvider).toStringAsFixed(2)}\$",
                    color: Colors.blue,
                    weight: FontWeight.bold,
                  )
                ],
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  await function();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text("Checkout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
