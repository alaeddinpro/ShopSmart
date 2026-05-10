import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import 'package:shopsmart_users/models/cart_model.dart';
import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/providers/products_provider.dart';
import 'package:shopsmart_users/screens/cart/quantity_btm_widget.dart';
import 'package:shopsmart_users/widgets/products/heart_btn.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final getCurrentProduct = productsProvider.findById(cartModel.productId);
    Size size = MediaQuery.of(context).size;
    return getCurrentProduct == null
        ? SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FancyShimmerImage(
                    imageUrl: getCurrentProduct.productImage,
                    height: size.height * 0.15,
                    width: size.width * 0.3,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.02,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: SubtitleText(
                              label: getCurrentProduct.productTitle,
                              size: 16,
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  cartProvider.removeCartItemfromfirebase(
                                      cartId: cartModel.cartId,
                                      productId: cartModel.productId,
                                      quantity: cartModel.quantity);
                                },
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                ),
                              ),
                              HeartBtn(productId: getCurrentProduct.productId),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SubtitleText(
                            label: '${getCurrentProduct.productPrice}\$',
                            color: Colors.blue,
                          ),
                          Spacer(),
                          OutlinedButton.icon(
                            onPressed: () {
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                context: context,
                                builder: (context) {
                                  return QuantityBtmSheetWidget(
                                    cartModel: cartModel,
                                  );
                                },
                              );
                            },
                            icon: Icon(IconlyLight.arrowDown2),
                            label: Text("Qty: ${cartModel.quantity}"),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.black),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
