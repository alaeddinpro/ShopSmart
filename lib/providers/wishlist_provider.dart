import 'package:flutter/material.dart';
import 'package:shopsmart_users/models/cart_model.dart';
import 'package:shopsmart_users/models/wishlist_model.dart';
import 'package:shopsmart_users/providers/products_provider.dart';
import 'package:uuid/uuid.dart';

class WishlistProvider with ChangeNotifier {
  final Map<String, WishlistModel> _wishlistItems = {};
  Map<String, WishlistModel> get getWishlistItems {
    return _wishlistItems;
  }

  void addOrRemoveFromWishlist({required String productId}) {
    if (isProductinWishlist(productId: productId)) {
      removeWishlistItem(productId: productId);
    } else {
      _wishlistItems.putIfAbsent(
        productId,
        () => WishlistModel(wishlistId: Uuid().v4(), productId: productId),
      );
    }
    notifyListeners();
  }

  bool isProductinWishlist({required String productId}) {
    return _wishlistItems.containsKey(productId);
  }

  void clearLocalWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }

  void removeWishlistItem({required String productId}) {
    _wishlistItems.remove(productId);
    notifyListeners();
  }
}
