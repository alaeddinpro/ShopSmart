import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderModel with ChangeNotifier {
  final String oid;
  final String userId;
  final String productId;
  final String userName;
  final String quantity;
  final String price;
  final String imageUrl;
  final Timestamp orderDate;

  OrderModel({
    required this.oid,
    required this.userId,
    required this.userName,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.imageUrl,
    required this.orderDate,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      oid: map['orderId'],
      userId: map['userId'],
      productId: map['productId'],
      userName: map['userName'],
      quantity: map['quantity'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      orderDate: map['orderDate'],
    );
  }
}
