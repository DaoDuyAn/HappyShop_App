import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/firebase_firestore_helper/firebase_firestore_helper.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class CategoryView extends StatefulWidget {
  final Category category;

  const CategoryView({super.key, required this.category});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<Product> productList = [];

  bool isLoading = false;

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });

    productList = await FirebaseFirestoreHelper.instance
        .getCategoryViewProduct(widget.category.id);
    productList.shuffle();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          const BackButton(),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.category.title,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: productList.length,
                        itemBuilder: (context, index) {
                          return ProductCard(product: productList[index]);
                        },
                      ),
                    ),
                  ]),
            ),
    );
  }
}
