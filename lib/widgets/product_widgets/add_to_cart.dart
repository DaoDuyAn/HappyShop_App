import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../constants/constants_colors.dart';
import '../../constants/routes.dart';
import '../../constants/toast.dart';
import '../../models/product.dart';
import '../../provider/app_provider.dart';

class AddToCart extends StatefulWidget {
  final Product singleProduct;

  final Function() onAdd;
  final Function() onRemove;

  const AddToCart(
      {super.key,
      required this.currentNumber,
      required this.onAdd,
      required this.onRemove,
      required this.singleProduct});

  final int currentNumber;

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.black,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: widget.onRemove,
                    iconSize: 18,
                    icon: const Icon(
                      Ionicons.remove_outline,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.currentNumber.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: widget.onAdd,
                    iconSize: 18,
                    icon: const Icon(
                      Ionicons.add_outline,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // ADD TO CART <3
            InkWell(
              onTap: () {
                Product product =
                    widget.singleProduct.copyWith(qty: widget.currentNumber);
                appProvider.addCartProduct(product);
                showMessage("Added to Cart");
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: kprimaryColor,
                  borderRadius: BorderRadius.circular(60),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
