import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../constants/constants_colors.dart';
import '../../models/product.dart';
import '../../provider/app_provider.dart';

class ProductInfo extends StatefulWidget {
  final Product product;
  const ProductInfo({super.key, required this.product});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TITLE <3
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.product.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.product.isFavourite =
                  !widget.product.isFavourite;
                });

                if (widget.product.isFavourite) {
                  appProvider.addFavouriteProduct(widget.product);
                } else {
                  appProvider
                      .removeFavouriteProduct(widget.product);
                }
              },
              icon: Icon(appProvider.getFavouriteProductList
                  .contains(widget.product)
                  ? Icons.favorite
                  : Icons.favorite_border),
              color: widget.product.isFavourite
                  ? Colors.red
                  : Colors.black,
            ),
          ],
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // PRICE <3
                Text(
                  "\$${widget.product.price}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                // RATING <3
                Row(
                  children: [
                    // STAR <3
                    Container(
                      width: 50,
                      height: 20,
                      decoration: BoxDecoration(
                        color: kprimaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 2),
                          Transform.translate(
                            offset: Offset(0, -1.6),
                            child: Icon(
                              Ionicons.star,
                              size: 13,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            widget.product.rate.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    // REVIEW <3
                    const Text(
                      "(320 Reviews)",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
