import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopsmart_users/models/cart_model.dart';
import 'package:shopsmart_users/providers/products_provider.dart';
import 'package:shopsmart_users/services/my_app_functions.dart';
import 'package:uuid/uuid.dart';

import '../screens/auth/login.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _cartItems = {};
  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  final usersDb = FirebaseFirestore.instance.collection("users");
  final auth = FirebaseAuth.instance;
  Future<void> addCartItemtofirebase(
      {required String productId,
      required int quantity,
      required BuildContext context}) async {
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
      final cartId = Uuid().v4();
      await usersDb.doc(userid).update({
        'userCart': FieldValue.arrayUnion([
          {
            'productId': productId,
            'productQuantity': quantity,
            'cartId': cartId,
          }
        ])
      });
      await fetchCartItems();

      Fluttertoast.showToast(msg: "Item has been added to cart");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchCartItems() async {
    final User? user = auth.currentUser;
    if (user == null) {
      _cartItems.clear();
      return;
    }
    try {
      final userid = user.uid;
      final userDoc = await usersDb.doc(userid).get();
      final cartDataMap = userDoc.data();
      if (cartDataMap == null || !cartDataMap.containsKey('userCart')) {
        return;
      }
      final leng = userDoc.get('userCart').length;
      for (int index = 0; index < leng; index++) {
        _cartItems.putIfAbsent(
            userDoc.get('userCart')[index]['productId'],
            () => CartModel(
                cartId: userDoc.get('userCart')[index]['cartId'],
                productId: userDoc.get('userCart')[index]['productId'],
                quantity: userDoc.get('userCart')[index]['productQuantity']));
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> removeCartItemfromfirebase({
    required String cartId,
    required String productId,
    required int quantity,
  }) async {
    final User? user = auth.currentUser;
    try {
      await usersDb.doc(user!.uid).update({
        'userCart': FieldValue.arrayRemove([
          {
            'productId': productId,
            'productQuantity': quantity,
            'cartId': cartId,
          }
        ])
      });
      _cartItems.remove(productId);
      Fluttertoast.showToast(msg: "Item has been removed from cart");
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> clearCartFromfirebase() async {
    final User? user = auth.currentUser;
    try {
      await usersDb.doc(user!.uid).update({'userCart': []});

      _cartItems.clear();
      Fluttertoast.showToast(msg: "Cart has been cleared");
    } catch (e) {
      rethrow;
    }
  }

  void addProductToCart({required String productId}) {
    _cartItems.putIfAbsent(
      productId,
      () => CartModel(cartId: Uuid().v4(), productId: productId, quantity: 1),
    );
    notifyListeners();
  }

  void updateQty({required String productId, required int quantity}) {
    _cartItems.update(
      productId,
      (cartItem) => CartModel(
          cartId: cartItem.cartId, productId: productId, quantity: quantity),
    );
    notifyListeners();
  }

  bool isProductinCart({required String productId}) {
    return _cartItems.containsKey(productId);
  }

  double getTotalPrice({required ProductsProvider productsProvider}) {
    double total = 0.0;

    _cartItems.forEach(
      (key, value) {
        final getCurrentProduct = productsProvider.findById(value.productId);
        if (getCurrentProduct == null) total += 0;
        total += double.parse(getCurrentProduct!.productPrice) * value.quantity;
      },
    );
    return total;
  }

  int getQuantity() {
    int total = 0;
    _cartItems.forEach((key, value) {
      total += value.quantity;
    });
    return total;
  }

  void clearLocalCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void removeCartItem({required String productId}) {
    _cartItems.remove(productId);
    notifyListeners();
  }
}
