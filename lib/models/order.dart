import 'package:shop_app/models/product.dart';

class OrderModel {
  String payment;
  String status;
  List<Product> products;
  double totalPrice;
  String orderId;

  OrderModel({
    required this.totalPrice,
    required this.orderId,
    required this.payment,
    required this.products,
    required this.status,
  });



  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productMap = json["products"];
    return OrderModel(
        orderId: json["orderId"],
        products: productMap.map((e) => Product.fromJson(e)).toList(),
        totalPrice:  double.parse(json["totalPrice"].toString()),
        status: json["status"],
        payment: json["payment"]);
  }
}