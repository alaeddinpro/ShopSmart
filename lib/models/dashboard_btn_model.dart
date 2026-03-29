import 'package:flutter/material.dart';
import 'package:shopsmart_admin/screens/edit_upload_product.dart';
import 'package:shopsmart_admin/screens/inner_screen/orders/orders_screen.dart';
import 'package:shopsmart_admin/screens/search_screen.dart';

import '../services/assets_manager.dart';

class DashboardBtnModel {
  final String title;
  final String image;
  final Function onTap;

  DashboardBtnModel({
    required this.title,
    required this.image,
    required this.onTap,
  });
  static List<DashboardBtnModel> getDashboardBtnList(BuildContext context) {
    return [
      DashboardBtnModel(
        title: "Add a new Product",
        image: AssetsManager.cloud,
        onTap: () {
          Navigator.pushNamed(context, EditUploadProductScreen.routeName);
        },
      ),
      DashboardBtnModel(
        title: "View All Products",
        image: AssetsManager.shoppingCart,
        onTap: () {
          Navigator.pushNamed(context, SearchScreen.routeName);
        },
      ),
      DashboardBtnModel(
        title: "View All Orders",
        image: AssetsManager.order,
        onTap: () {
          Navigator.pushNamed(context, OrdersScreenFree.routeName);
        },
      ),
    ];
  }
}
