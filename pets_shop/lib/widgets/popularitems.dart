import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../models/productmodel.dart';

class PopularItems extends StatelessWidget {
  const PopularItems({
    Key? key,
    required this.allProducts,
  }) : super(key: key);

  final List<Products> allProducts;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: allProducts
            .where((element) => element.isPopular == true)
            .map((e) => Container(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(0.7),
                          child: Image.network(
                            e.imageUrls!.first,
                            height: 80,
                            width: 80,
                          ),
                        ),
                      ),
                      Expanded(child: Text(e.productName!)),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
