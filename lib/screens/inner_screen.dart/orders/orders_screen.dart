import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopsmart_users/screens/cart/bottom_checkout.dart';
import 'package:shopsmart_users/screens/cart/cart_widget.dart';
import 'package:shopsmart_users/screens/inner_screen.dart/orders/order_widget.dart';
import 'package:shopsmart_users/services/assets_manger.dart';
import 'package:shopsmart_users/widgets/empty_bag.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});
  static const routName = "/OrdersScreen";

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool isEmptyOrders = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isEmptyOrders
          ? EmptyBag(
              imagePath: AssetsManager.orderbag,
              title: "No orders yet",
              subtitle: "Looks like you haven't placed any orders yet",
              buttonText: "Shop Now",
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsetsGeometry.symmetric(horizontal: 2, vertical: 6),
                  child: OrderWidget(),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              itemCount: 15),
    );
  }
}
