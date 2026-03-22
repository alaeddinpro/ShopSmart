import 'package:flutter/material.dart';

class ProductsModel with ChangeNotifier {
  final String productId,
      productTitle,
      productPrice,
      productCategory,
      productDescription,
      productImage,
      productQuantity;

  ProductsModel(
      {required this.productCategory,
      required this.productDescription,
      required this.productImage,
      required this.productQuantity,
      required this.productId,
      required this.productTitle,
      required this.productPrice});
}
