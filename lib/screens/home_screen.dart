import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants_colors.dart';
import '../helpers/firebase_firestore_helper/firebase_firestore_helper.dart';
import '../models/product.dart';
import '../provider/app_provider.dart';
import '../widgets/categories.dart';
import '../widgets/home_appbar.dart';
import '../widgets/home_slider.dart';
import '../widgets/product_card.dart';
import '../widgets/search_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> productList = [];

  bool isLoading = false;
  int currentSlide = 0;

  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();

    super.initState();
    getProductList();
  }

  void getProductList() async {
    setState(() {
      isLoading = true;
    });

    FirebaseFirestoreHelper.instance.updateTokenFromFirebase();
    productList = await FirebaseFirestoreHelper.instance.getBestProducts();
    productList.shuffle(); // Random kết quả hiển thị

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kscaffoldColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeAppBar(),
                const SizedBox(height: 20),
                const SearchField(),
                const SizedBox(height: 20),
                HomeSlider(
                    onChange: (value) {
                      setState(() {
                        currentSlide = value;
                      });
                    },
                    currentSlide: currentSlide,
                    imagePaths: [
                      "assets/images/slider_4.jpg",
                      "assets/images/slider_2.png",
                      "assets/images/slider_3.png",
                      "assets/images/slider.jpg",
                    ]),
                const SizedBox(height: 20),
                const Categories(),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Special For You",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: productList[index]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
