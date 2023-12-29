import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../constants/constants_colors.dart';
import '../helpers/firebase_firestore_helper/firebase_firestore_helper.dart';
import '../models/order.dart';
import 'main_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kcontentColor,
        centerTitle: true,
        title: const Text(
          "Your Orders",
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
      body: StreamBuilder(
        stream: Stream.fromFuture(
          FirebaseFirestoreHelper.instance.getUserOrder(),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.isEmpty ||
              snapshot.data == null ||
              !snapshot.hasData) {
            return const Center(
              child: Text(
                "No Order Found",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              padding: const EdgeInsets.all(12.0),
              itemBuilder: (context, index) {
                OrderModel orderModel = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    collapsedShape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2.3)),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2.3)),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          color: kscaffoldColor,
                          child: Image.network(
                            orderModel.products[0].image,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orderModel.products[0].title,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              orderModel.products.length > 1
                                  ? SizedBox.fromSize()
                                  : Column(
                                      children: [
                                        Text(
                                          "Quantity: ${orderModel.products[0].qty.toString()}",
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12.0,
                                        ),
                                      ],
                                    ),
                              Text(
                                "Total Price: \$${orderModel.totalPrice.toString()}",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                "Order Status: ${orderModel.status}",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    children: orderModel.products.length > 1
                        ? [
                            const Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                "Details",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Divider(color: Theme.of(context).primaryColor),
                            ...orderModel.products.map((singleProduct) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 12.0, top: 6.0),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 80,
                                          color: kscaffoldColor,
                                          child: Image.network(
                                            singleProduct.image,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                singleProduct.title,
                                                style: const TextStyle(
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 12.0,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "Quantity: ${singleProduct.qty.toString()}",
                                                    style: const TextStyle(
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 12.0,
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "Price: \$${singleProduct.price.toString()}",
                                                style: const TextStyle(
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                        color: Theme.of(context).primaryColor),
                                  ],
                                ),
                              );
                            }).toList()
                          ]
                        : [],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
