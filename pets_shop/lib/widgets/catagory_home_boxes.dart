import 'package:pets_shop/screens/bottom_screens/home_screen.dart';
import 'package:pets_shop/screens/bottom_screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../models/catagory_model.dart';

class CatagoryHomeBoxes extends StatelessWidget {
  const CatagoryHomeBoxes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
            catagories.length,
            (index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (v) => ProductScreen(
                                  catagory: catagoriez[index].title!)));
                    },
                    child: Container(
                      height: 15.h,
                      width: 25.w,
                      child: Container(
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                        )),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                  "${catagoriez[index].image}",
                                )),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black)),
                      ),
                    ),
                  ),
                  Text(
                    catagoriez[index].title!,
                    style: const TextStyle(color: Colors.black, fontSize: 9),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
