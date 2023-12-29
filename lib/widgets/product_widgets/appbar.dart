import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../constants/routes.dart';
import '../../screens/cart_screen.dart';

class ProductAppBar extends StatelessWidget {
  const ProductAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(15),
            ),
            icon: const Icon(Ionicons.chevron_back),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Routes.instance
                  .push(widget: const CartScreen(), context: context);
            },
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(15),
            ),
            icon: const Icon(Icons.shopping_cart),
          ),


        ],
      ),
    );
  }
}
