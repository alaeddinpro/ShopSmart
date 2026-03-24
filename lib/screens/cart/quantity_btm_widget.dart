import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/models/cart_model.dart';
import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

class QuantityBtmSheetWidget extends StatelessWidget {
  const QuantityBtmSheetWidget({super.key, required this.cartModel});
  final CartModel cartModel;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          height: 5,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
              // physics: NeverScrollableScrollPhysics(),
              // shrinkWrap: true,
              itemCount: 20,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    cartProvider.updateQty(
                        productId: cartModel.productId, quantity: index + 1);
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SubtitleText(label: "${index + 1}"),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
