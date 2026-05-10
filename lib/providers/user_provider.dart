import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopsmart_users/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? userModel;
  UserModel? get getUserModel => userModel;
  Future<UserModel?> fetchUserModel() async {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      return null;
    }
    String uid = user.uid;
    try {
      final userdoc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      final userdocdata = userdoc.data() as Map<String, dynamic>;
      userModel = UserModel(
          userId: userdoc.get("userId"),
          userName: userdoc.get("userName"),
          userImage: userdoc.get("userImage"),
          userEmail: userdoc.get("userEmail"),
          createdAt: userdoc.get("createdAt"),
          userCart: userdocdata.containsKey("userCart")
              ? userdoc.get("userCart")
              : [],
          userwish: userdocdata.containsKey("userWish")
              ? userdoc.get("userWish")
              : []);
      return userModel;
    } on FirebaseException catch (e) {
      throw Exception(e.message.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
