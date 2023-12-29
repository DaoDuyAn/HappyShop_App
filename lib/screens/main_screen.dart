import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';

import '../constants/constants_colors.dart';
import 'account_screen.dart';
import 'cart_screen.dart';
import 'home_screen.dart';
import 'order_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTab = 2;

  List screens = const [
    Scaffold(),
    OrderScreen(),
    HomeScreen(),
    CartScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentTab = 2;
          });
        },
        shape: const CircleBorder(),
        backgroundColor: kprimaryColor,
        child: const Icon(
          Iconsax.home,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 20, // độ đổ bóng
        height: 70,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,

        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => setState(() {
                currentTab = 0;
              }),
              icon: Icon(
                Ionicons.grid_outline,
                color: currentTab == 0 ? kprimaryColor : Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: () => setState(() {
                currentTab = 1;
              }),
              icon: Icon(
                Icons.shopping_bag_outlined,
                size: 26,
                color: currentTab == 1 ? kprimaryColor : Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: () => setState(() {
                currentTab = 3;
              }),
              icon: Icon(
                Ionicons.cart_outline,
                color: currentTab == 3 ? kprimaryColor : Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: () => setState(() {
                currentTab = 4;
              }),
              icon: Icon(
                Ionicons.person_outline,
                color: currentTab == 4 ? kprimaryColor : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
      body: screens[currentTab],
    );
  }
}
