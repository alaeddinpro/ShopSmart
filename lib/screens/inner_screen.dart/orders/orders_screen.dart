import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/order_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
        body: FutureBuilder(
            future: orderProvider.fetchOrders(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return EmptyBag(
                    imagePath: AssetsManager.orderbag,
                    title: "No orders has been placed yet",
                    subtitle: "",
                    buttonText: "Shop now");
              }
              return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                      child: OrderWidget(
                        orderModel: orderProvider.getOrder[index],
                      ));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              );
            }));
  }
}
