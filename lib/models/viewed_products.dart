import 'package:flutter/material.dart';

class ViewedProductsModel with ChangeNotifier {
  final String viewedProductId, productId;

  ViewedProductsModel({required this.viewedProductId, required this.productId});
}
