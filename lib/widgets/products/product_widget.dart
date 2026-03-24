import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/consts/app_constants.dart';
import 'package:shopsmart_users/models/products_model..dart';
import 'package:shopsmart_users/providers/viewed_provider.dart';
import 'package:shopsmart_users/screens/inner_screen.dart/product_details.dart';
import 'package:shopsmart_users/widgets/products/heart_btn.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

import '../../providers/cart_provider.dart';
import '../../providers/products_provider.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key, required this.productId});
  final String productId;
  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final getCurrentProduct = productsProvider.findById(widget.productId);
    final cartProvider = Provider.of<CartProvider>(context);
    final viewedProvider = Provider.of<ViewedProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return getCurrentProduct == null
        ? SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                viewedProvider.addviewedProduct(
                    productId: getCurrentProduct.productId);

                Navigator.pushNamed(context, ProductDetails.routName,
                    arguments: getCurrentProduct.productId);
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: FancyShimmerImage(
                      imageUrl: getCurrentProduct.productImage,
                      height: size.height * 0.22,
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: SubtitleText(
                          label: getCurrentProduct.productTitle,
                          maxLines: 2,
                        ),
                      ),
                      Flexible(
                          child: HeartBtn(
                        productId: getCurrentProduct.productId,
                      ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubtitleText(
                        label: getCurrentProduct.productPrice,
                        weight: FontWeight.w600,
                      ),
                      Material(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: InkWell(
                            onTap: () {
                              if (cartProvider.isProductinCart(
                                  productId: getCurrentProduct.productId)) {
                                return;
                              }

                              cartProvider.addProductToCart(
                                  productId: getCurrentProduct.productId);
                            },
                            splashColor: Colors.blueAccent,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Icon(
                                cartProvider.isProductinCart(
                                        productId: getCurrentProduct.productId)
                                    ? Icons.check
                                    : Icons.add_shopping_cart_outlined,
                                color: Colors.white,
                              ),
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  )
                ],
              ),
            ),
          );
  }
}
