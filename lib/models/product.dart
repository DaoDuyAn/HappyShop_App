import 'package:flutter/material.dart';

import 'dart:convert';

Product productModelFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String id;
  String title;
  String description;
  String image;
  double price;
  double rate;
  String category;
  bool isFavourite;
  int? qty;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.price,
      required this.rate,
      required this.category,
      required this.isFavourite,
      this.qty});

  // Map<String, dynamic> toMap() {
  //   return {
  //     'title': title,
  //     'description': description,
  //     'image': image,
  //     'price': price,
  //     'category': category,
  //     'rate': rate,
  //   };
  // }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        category: json["category"],
        isFavourite: false,
        qty: json["qty"],
        price: double.parse(json["price"].toString()),
        rate: double.parse(json["rate"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "category": category,
        "description": description,
        "isFavourite": isFavourite,
        "price": price,
        "qty": qty,
        "rate": rate,
      };

  Product copyWith({
    int? qty,
  }) =>
      Product(
        id: id,
        title: title,
        description: description,
        image: image,
        category: category,
        isFavourite: isFavourite,
        qty: qty ?? this.qty,
        price: price,
        rate: rate,
      );
}

// final List<Product> products = [
//   Product(
//     id: "1",
//     title: "Wireless Headphones",
//     description:
//         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
//     image: "assets/images/wireless.png",
//     category: "Headphones",
//     price: 120,
//     rate: 4.8,
//     isFavourite: false
//   ),
//   Product(
//     id: "2",
//     title: "Woman Sweter",
//     description:
//         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
//     image: "assets/images/sweet.png",
//     category: "Woman Fashion",
//     price: 120,
//     rate: 4.8,
//     isFavourite: false
//   ),
//   Product(
//     id: "3",
//     title: "Smart Watch",
//     description:
//         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
//     image: "assets/images/miband.jpg",
//     category: "Watch",
//     price: 55,
//     rate: 4.8,
//     isFavourite: false
//   ),
// ];
