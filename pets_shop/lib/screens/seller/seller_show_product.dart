import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pets_shop/screens/seller/update_complete_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/productmodel.dart';

class UpdateProductScreen extends StatelessWidget {
  const UpdateProductScreen({Key? key}) : super(key: key);
  static const String id = "updateproduct";

  @override
  Widget build(BuildContext context) {
    // print(FirebaseAuth.instance.currentUser!.uid);
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
      ),
      body: Center(
        child: Column(
          children: [
            // const Text(
            //   "ALL PRODUCT",
            //   style: EcoStyle.boldstyle,
            // ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("products")
                    .where('sellerId',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data == null) {
                    return const Center(child: Text("No Data Exists"));
                  }
                  var data = snapshot.data!.docs;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                                // color: Colors.black,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: ListTile(
                                      title: Text(
                                        data[index]["productName"],
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      trailing: Container(
                                        width: 100,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                Products.deleteProduct(
                                                    data[index].id);
                                              },
                                              icon: const Icon(
                                                  Icons.delete_forever),
                                              color: Colors.black,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (_) {
                                                  return UpdateCompleteScreen(
                                                    id: data[index].id,
                                                    products: Products(
                                                      catagory: data[index]
                                                          ["catagory"],
                                                      id: id,
                                                      productName: data[index]
                                                          ["productName"],
                                                      detail: data[index]
                                                          ["detail"],
                                                      price: data[index]
                                                          ["price"],

                                                      // serialCode: data[index]
                                                      // ["serialCode"],
                                                      // brand: data[index]
                                                      // ["brand"],
                                                      imageUrls: data[index]
                                                          ["imageUrls"],
                                                      isOnSale: data[index]
                                                          ["isOnSale"],
                                                      isPopular: data[index]
                                                          ["isPopular"],
                                                      isFavourit: data[index]
                                                          ["isFavourit"],
                                                    ),
                                                  );
                                                }));
                                              },
                                              icon: const Icon(Icons.edit),
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          );
                        }),
                  );
                })
          ],
        ),
      ),
    );
  }
}
