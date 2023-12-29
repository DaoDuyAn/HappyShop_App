import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../constants/constants_colors.dart';
import '../models/product.dart';
import '../screens/product_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductScreen(singleProduct: product),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: kscaffoldColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                // IMAGE <3
                Image.asset(
                  product.image,
                  width: 120,
                  height: 120,
                ),
                SizedBox(
                  height: 20,
                ),
                // TITLE <3
                Text(
                  product.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // PRICE AND COLORS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "\$${product.price}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          // FAVORITE <3
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: kprimaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: const Icon(
                  Ionicons.heart_outline,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
