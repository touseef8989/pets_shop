import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pets_shop/product_detail_screen.dart';
import 'package:pets_shop/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/productmodel.dart';

class ProductScreen extends StatefulWidget {
  String? catagory;
  ProductScreen({this.catagory});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Products> allProducts = [];
  TextEditingController searchC = TextEditingController();

  getData() {
    FirebaseFirestore.instance
        .collection("products")
        .get()
        .then((QuerySnapshot? snapshot) {
      if (widget.catagory == null) {
        snapshot!.docs.forEach((e) {
          if (e.exists) {
            // for (var item in e["imageUrls"]) {
            //   if (item.isNotEmpty) {
            setState(() {
              allProducts.add(
                Products(
                  id: e["id"],
                  productName: e["productName"],
                  imageUrls: e["imageUrls"],
                ),
              );
            });
          }
        }
            //   }
            // }
            );
      } else {
        snapshot!.docs
            .where((element) => element["catagory"] == widget.catagory)
            .forEach((e) {
          if (e.exists) {
            setState(() {
              allProducts.add(
                Products(
                  id: e["id"],
                  productName: e["productName"],
                  imageUrls: e["imageUrls"],
                ),
              );
            });
          }
        });
      }
    });
  }

  List<Products> totalItems = [];

  @override
  void initState() {
    getData();
    Future.delayed(const Duration(seconds: 1), () {
      totalItems.addAll(allProducts);
    });
    super.initState();
  }

  filterData(String query) {
    List<Products> dummySearched = [];
    dummySearched.addAll(allProducts);
    if (query.isNotEmpty) {
      List<Products> dummyData = [];
      dummyData.forEach((element) {
        if (element.productName!.toLowerCase().contains(query.toLowerCase())) {
          dummyData.add(element);
        }
      });
      setState(() {
        allProducts.clear();
        allProducts.addAll(dummyData);
      });
      return;
    } else {
      setState(() {
        allProducts.clear();
        allProducts.addAll(totalItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            child: Header(
              title: "${widget.catagory ?? "ALL PRODUCTS"}",
            ),
            preferredSize: Size.fromHeight(5.h)),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: searchC,
                onChanged: (v) {
                  filterData(searchC.text);
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Your Favorite Items..."),
              ),
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: allProducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ProductDetailScreen(id: allProducts[index].id),
                          ),
                        );
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Image.network(
                              allProducts[index].imageUrls?.first,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            Text(allProducts[index].productName!)
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ));
  }
}
