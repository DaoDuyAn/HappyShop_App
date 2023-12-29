import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/category_screen.dart';

import '../constants/routes.dart';
import '../helpers/firebase_firestore_helper/firebase_firestore_helper.dart';
import '../models/category.dart';
import '../provider/app_provider.dart';

class Categories extends StatefulWidget {
  const Categories({
    super.key,
  });

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<Category> categoriesList = [];

  bool isLoading = false;

  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    super.initState();
    getCategoryList();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestoreHelper.instance.updateTokenFromFirebase();
    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            )
          : ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Routes.instance.push(
                          widget: CategoryView(category: categoriesList[index]),
                          context: context,
                        );
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              categoriesList[index].image,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      categoriesList[index].title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 20),
              itemCount: categoriesList.length,
            ),
    );
  }
}
