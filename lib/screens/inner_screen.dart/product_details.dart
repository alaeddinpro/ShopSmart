import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/consts/app_constants.dart';
import 'package:shopsmart_users/models/products_model..dart';
import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/providers/products_provider.dart';
import 'package:shopsmart_users/widgets/appnametextwidget.dart';
import 'package:shopsmart_users/widgets/products/heart_btn.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

class ProductDetails extends StatefulWidget {
  static const routName = "/ProductdetailsScreen";
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final productsModelProvider = Provider.of<ProductsModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);
    String? productId = ModalRoute.of(context)!.settings.arguments as String?;
    final getCurrentProduct = productsProvider.findById(productId!);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
            )),
        title: AppNameTextWidget(),
      ),
      body: getCurrentProduct == null
          ? SizedBox.shrink()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FancyShimmerImage(
                      imageUrl: getCurrentProduct.productImage,
                      height: size.height * 0.38,
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            getCurrentProduct.productTitle,
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        SubtitleText(
                          label: getCurrentProduct.productPrice,
                          weight: FontWeight.w700,
                          size: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HeartBtn(
                            backgroundcolor: Colors.blue.shade200,
                            productId: getCurrentProduct.productId,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          SizedBox(
                            height: kBottomNavigationBarHeight - 10,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () {
                                if (cartProvider.isProductinCart(
                                    productId: getCurrentProduct.productId)) {
                                  return;
                                }

                                cartProvider.addProductToCart(
                                    productId: getCurrentProduct.productId);
                              },
                              label: Text(
                                cartProvider.isProductinCart(
                                        productId: getCurrentProduct.productId)
                                    ? "Item it added"
                                    : "Item added to cart",
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: Icon(
                                cartProvider.isProductinCart(
                                        productId: getCurrentProduct.productId)
                                    ? Icons.done_all
                                    : Icons.add_shopping_cart_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubtitleText(
                          label: "About this item",
                          size: 18,
                          weight: FontWeight.bold,
                        ),
                        SubtitleText(label: getCurrentProduct.productCategory)
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      getCurrentProduct.productDescription,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
