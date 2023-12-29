

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../constants/toast.dart';
import '../../models/category.dart';
import '../../models/order.dart';
import '../../models/product.dart';
import '../../models/user.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<Category>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").get();

      List<Category> categoriesList =
          querySnapshot.docs.map((e) => Category.fromJson(e.data())).toList();

      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<Product>> getBestProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup("products").get();

      List<Product> productList =
          querySnapshot.docs.map((e) => Product.fromJson(e.data())).toList();

      return productList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<Product>> getCategoryViewProduct(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("categories")
              .doc(id)
              .collection("products")
              .get();

      List<Product> productModelList =
          querySnapshot.docs.map((e) => Product.fromJson(e.data())).toList();

      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<UserModel> getUserInformation() async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
    await _firebaseFirestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    return UserModel.fromJson(querySnapshot.data()!);
  }

  Future<bool> uploadOrderedProductFirebase(
      List<Product> list, BuildContext context, String payment) async {
    try {
      showLoaderDialog(context);

      double totalPrice = 0.0;
      for (var element in list) {
        totalPrice += element.price * element.qty!;
      }

      // Format totalPrice as a String with 2 decimal places
      String formattedTotalPrice = totalPrice.toStringAsFixed(2);

      DocumentReference documentReference = _firebaseFirestore
          .collection("usersOrders")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("orders")
          .doc();

      DocumentReference admin = _firebaseFirestore.collection("orders").doc();

      admin.set({
        "products": list.map((e) => e.toJson()),
        "status": "Pending",
        "totalPrice": formattedTotalPrice,
        "payment": payment,
        "orderId": admin.id,
      });

      documentReference.set({
        "products": list.map((e) => e.toJson()),
        "status": "Pending",
        "totalPrice": formattedTotalPrice,
        "payment": payment,
        "orderId": documentReference.id,
      });

      Navigator.of(context, rootNavigator: true).pop();
      showMessage("Ordered Successfully");

      return true;
    } catch (e) {
      showMessage(e.toString());
      Navigator.of(context, rootNavigator: true).pop();

      return false;
    }
  }

  //Get Order User
  Future<List<OrderModel>> getUserOrder() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _firebaseFirestore
          .collection("usersOrders")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("orders")
          .get();

      List<OrderModel> orderList = querySnapshot.docs
          .map((element) => OrderModel.fromJson(element.data()))
          .toList();

      return orderList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  void updateTokenFromFirebase() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await _firebaseFirestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "notificationToken": token,
      });
    }
  }

}
