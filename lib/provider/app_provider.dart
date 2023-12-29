import 'package:flutter/material.dart';

import '../helpers/firebase_firestore_helper/firebase_firestore_helper.dart';
import '../models/product.dart';
import '../models/user.dart';

class AppProvider with ChangeNotifier {
  // Cart Work
  final List<Product> _cartProductList = [];
  final List<Product> _buyProductList = [];

  UserModel? _userModel;
  UserModel get getUserInformation => _userModel!;

  void addCartProduct(Product product) {
    _cartProductList.add(product);
    notifyListeners();
  }

  void removeCartProduct(Product product) {
    _cartProductList.remove(product);
    notifyListeners();
  }

  List<Product> get getCartProductList => _cartProductList;

  // Favourite
  final List<Product> _favouriteProductList = [];

  void addFavouriteProduct(Product product) {
    _favouriteProductList.add(product);
    notifyListeners();
  }

  void removeFavouriteProduct(Product product) {
    _favouriteProductList.remove(product);
    notifyListeners();
  }

  List<Product> get getFavouriteProductList => _favouriteProductList;

  // User Information
  void getUserInfoFirebase() async {
    _userModel = await FirebaseFirestoreHelper.instance.getUserInformation();
    notifyListeners();
  }

  // TOTAL PRICE
  double totalPrice() {
    double totalPrice = 0.0;
    for (var element in _cartProductList) {
      totalPrice += element.price * element.qty!;
    }
    return totalPrice;
  }

  double totalPriceBuyProductList() {
    double totalPrice = 0.0;
    for (var element in _buyProductList) {
      totalPrice += element.price * element.qty!;
    }
    return totalPrice;
  }

  void updateQty(Product productModel, int qty) {
    int index = _cartProductList.indexOf(productModel);
    _cartProductList[index].qty = qty;
    notifyListeners();
  }

  // BUY Product
  void addBuyProduct(Product model) {
    _buyProductList.add(model);
    notifyListeners();
  }

  void addBuyProductCartList() {
    _buyProductList.addAll(_cartProductList);
    notifyListeners();
  }

  void clearCart() {
    _cartProductList.clear();
    notifyListeners();
  }

  void clearBuyProduct() {
    _buyProductList.clear();
    notifyListeners();
  }

  List<Product> get getBuyProductList => _buyProductList;
}
