import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/main_screen.dart';
import 'package:shop_app/screens/single_cart_item.dart';

import '../constants/constants_colors.dart';
import '../constants/routes.dart';
import '../constants/toast.dart';
import '../provider/app_provider.dart';
import '../widgets/primary_button.dart';
import 'cart_item_checkout.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kcontentColor,
        centerTitle: true,
        title: const Text(
          "My Cart",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        leadingWidth: 56,
        leading: Container(
          margin: EdgeInsets.only(left: 20),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Container(
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                },
                icon: const Icon(
                  Ionicons.chevron_back,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ),
      body: appProvider.getCartProductList.isEmpty
          ? const Center(
              child: Text(
                "Empty",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: appProvider.getCartProductList.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (ctx, index) {
                return SingleCartItem(
                  singleProduct: appProvider.getCartProductList[index],
                );
              }),
      bottomNavigationBar: SizedBox(
        height: 140,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$${appProvider.totalPrice().toString()}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
              PrimaryButton(
                title: "Checkout",
                onPressed: () {
                  appProvider.clearBuyProduct();
                  appProvider.addBuyProductCartList();
                  appProvider.clearCart();

                  if (appProvider.getBuyProductList.isEmpty) {
                    showMessage("Cart is empty");
                  } else {
                    Routes.instance.push(
                        widget: const CartItemCheckout(), context: context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
