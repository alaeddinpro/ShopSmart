import 'package:flutter/material.dart';

class WishlistModel with ChangeNotifier {
  final String wishlistId, productId;

  WishlistModel({required this.wishlistId, required this.productId});
}
