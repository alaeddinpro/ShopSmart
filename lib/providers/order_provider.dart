import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shopsmart_users/models/order_model.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> orders = [];

  List<OrderModel> get getOrder => orders;
  Future<List<OrderModel>> fetchOrders() async {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    final uid = user!.uid;
    try {
      await FirebaseFirestore.instance
          .collection("orders")
          .where("userId", isEqualTo: uid)
          .get()
          .then((ordersnapshot) {
        orders.clear();
        for (var element in ordersnapshot.docs) {
          orders.insert(
              0,
              OrderModel(
                  oid: element.get('orderId'),
                  userId: element.get('userId'),
                  userName: element.get('userName'),
                  productId: element.get('productId'),
                  quantity: element.get('quantity').toString(),
                  price: element.get('price').toString(),
                  imageUrl: element.get('imageUrl'),
                  orderDate: element.get('orderDate')));
        }
      });
      return orders;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
