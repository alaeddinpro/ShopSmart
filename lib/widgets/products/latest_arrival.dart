import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/consts/app_constants.dart';
import 'package:shopsmart_users/models/products_model..dart';
import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/providers/viewed_provider.dart';
import 'package:shopsmart_users/screens/inner_screen.dart/product_details.dart';
import 'package:shopsmart_users/services/my_app_functions.dart';
import 'package:shopsmart_users/widgets/products/heart_btn.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

class LatestArrival extends StatelessWidget {
  const LatestArrival({super.key});

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductsModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final viewedProvider = Provider.of<ViewedProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          viewedProvider.addviewedProduct(productId: productModel.productId);
          Navigator.pushNamed(context, ProductDetails.routName,
              arguments: productModel.productId);
        },
        child: SizedBox(
          width: size.width * 0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  imageUrl: productModel.productImage,
                  height: size.height * 0.12,
                  width: size.width * 0.20,
                ),
              ),
              SizedBox(width: 8),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    SubtitleText(
                      label: productModel.productTitle,
                      weight: FontWeight.w600,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          HeartBtn(productId: productModel.productId),
                          IconButton(
                            color: Colors.blueAccent,
                            onPressed: () async {
                              if (cartProvider.isProductinCart(
                                  productId: productModel.productId)) {
                                return;
                              }
                              try {
                                await cartProvider.addCartItemtofirebase(
                                    productId: productModel.productId,
                                    quantity: 1,
                                    context: context);
                              } catch (e) {
                                MyAppFunctions.showErrorOrWarningDialog(
                                    context: context,
                                    fct: () {},
                                    title: e.toString());
                              }
                            },
                            icon: Icon(
                              cartProvider.isProductinCart(
                                      productId: productModel.productId)
                                  ? Icons.check
                                  : Icons.add_shopping_cart_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FittedBox(
                      child: SubtitleText(
                        label: "${productModel.productPrice}\$",
                        weight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
