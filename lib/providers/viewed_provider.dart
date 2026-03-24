import 'package:flutter/material.dart';
import 'package:shopsmart_users/models/cart_model.dart';
import 'package:shopsmart_users/models/wishlist_model.dart';
import 'package:shopsmart_users/providers/products_provider.dart';
import 'package:uuid/uuid.dart';

import '../models/viewed_products.dart';

class ViewedProvider with ChangeNotifier {
  final Map<String, ViewedProductsModel> _viewedItems = {};
  Map<String, ViewedProductsModel> get getViewedItems {
    return _viewedItems;
  }

  void addviewedProduct({required String productId}) {
    _viewedItems.putIfAbsent(
      productId,
      () => ViewedProductsModel(
          viewedProductId: Uuid().v4(), productId: productId),
    );

    notifyListeners();
  }
}
