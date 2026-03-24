import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/wishlist_provider.dart';

import '../../models/products_model..dart';

class HeartBtn extends StatefulWidget {
  const HeartBtn(
      {super.key,
      this.backgroundcolor = Colors.transparent,
      this.sizeicon = 20,
      required this.productId});
  final Color backgroundcolor;
  final double sizeicon;
  final String productId;
  @override
  State<HeartBtn> createState() => _HeartBtnState();
}

class _HeartBtnState extends State<HeartBtn> {
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return Container(
        decoration: BoxDecoration(
            color: widget.backgroundcolor, shape: BoxShape.circle),
        child: IconButton(
            style: IconButton.styleFrom(elevation: 10),
            onPressed: () {
              wishlistProvider.addOrRemoveFromWishlist(
                  productId: widget.productId);
            },
            icon: Icon(
              wishlistProvider.isProductinWishlist(productId: widget.productId)
                  ? IconlyBold.heart
                  : IconlyLight.heart,
              color: wishlistProvider.isProductinWishlist(
                      productId: widget.productId)
                  ? Colors.red
                  : Colors.black,
              size: widget.sizeicon,
            )));
  }
}
