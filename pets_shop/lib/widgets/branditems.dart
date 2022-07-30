import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../models/productmodel.dart';

class BrandItems extends StatelessWidget {
  const BrandItems({
    Key? key,
    required this.allProducts,
  }) : super(key: key);

  final List<Products> allProducts;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.h,
      constraints: const BoxConstraints(
        minWidth: 50,
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: allProducts
            .map((e) => Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 50,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.primaries[Random().nextInt(6)],
                          borderRadius: BorderRadius.circular(10)),
                      // child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Text(
                      //       e.brand![0],
                      //       style: EcoStyle.boldstyle.copyWith(
                      //           color: Colors.white,
                      //           fontStyle: FontStyle.italic),
                      //     ),
                      //     ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
