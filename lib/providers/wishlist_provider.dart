import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopsmart_users/models/cart_model.dart';
import 'package:shopsmart_users/models/wishlist_model.dart';
import 'package:shopsmart_users/providers/products_provider.dart';
import 'package:shopsmart_users/screens/auth/login.dart';
import 'package:uuid/uuid.dart';

import '../services/my_app_functions.dart';

class WishlistProvider with ChangeNotifier {
  final Map<String, WishlistModel> _wishlistItems = {};
  Map<String, WishlistModel> get getWishlistItems {
    return _wishlistItems;
  }

  final usersDb = FirebaseFirestore.instance.collection("users");
  final auth = FirebaseAuth.instance;
  Future<void> addWishlisttofirebase(
      {required String productId, required BuildContext context}) async {
    final User? user = auth.currentUser;
    if (user == null) {
      MyAppFunctions.showErrorOrWarningDialog(
          context: context,
          fct: () {
            Navigator.pushNamed(context, LoginScreen.routName);
          },
          title: "Please Login First");
      return;
    }
    try {
      final userid = user.uid;
      final wishlistId = Uuid().v4();
      await usersDb.doc(userid).update({
        'userwish': FieldValue.arrayUnion([
          {
            'productId': productId,
            'wishlistId': wishlistId,
          }
        ])
      });
      await fetchWishlistItems();

      Fluttertoast.showToast(msg: "Item has been added to cart");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchWishlistItems() async {
    final User? user = auth.currentUser;
    if (user == null) {
      _wishlistItems.clear();
      return;
    }
    try {
      final userid = user.uid;
      final userDoc = await usersDb.doc(userid).get();
      final cartDataMap = userDoc.data();
      if (cartDataMap == null || !cartDataMap.containsKey('userwish')) {
        return;
      }
      final leng = userDoc.get('userwish').length;
      for (int index = 0; index < leng; index++) {
        _wishlistItems.putIfAbsent(
            userDoc.get('userwish')[index]['productId'],
            () => WishlistModel(
                wishlistId: userDoc.get('userwish')[index]['wishlistId'] ??
                    userDoc.get('userwish')[index]['cartId'] ??
                    Uuid().v4(),
                productId: userDoc.get('userwish')[index]['productId']));
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> removeWishlistItemfromfirebase({
    required String wishlistId,
    required String productId,
  }) async {
    final User? user = auth.currentUser;
    try {
      await usersDb.doc(user!.uid).update({
        'userwish': FieldValue.arrayRemove([
          {
            'productId': productId,
            'wishlistId': wishlistId,
          }
        ])
      });
      _wishlistItems.remove(productId);
      Fluttertoast.showToast(msg: "Item has been removed from wishlist");
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> clearWishlistFromfirebase() async {
    final User? user = auth.currentUser;
    try {
      await usersDb.doc(user!.uid).update({'userwish': []});

      _wishlistItems.clear();
      Fluttertoast.showToast(msg: "Wishlist has been cleared");
    } catch (e) {
      rethrow;
    }
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
