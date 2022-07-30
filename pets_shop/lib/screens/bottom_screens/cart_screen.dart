import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pets_shop/widgets/header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/cartModel.dart';

// import '../saller/checkout_screen/seller_order_screen.dart';

class CartScreen extends StatelessWidget {
  CollectionReference db = FirebaseFirestore.instance.collection("cart");
  delete(String id, BuildContext context) {
    db.doc(id).delete().then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("successfuly deleted"))),
        );
  }

  List data = [];

  getUsers() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('cart')
        .get()
        .then((value) {});
  }

  List<Cart> allProducts = [];
  int count = 1;
  var newPrice = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.h),
          child: Header(
            title: "CART ITEMS",
          )),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("cart")
            .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return Container(
            padding: const EdgeInsets.all(0.0),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final res = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(
                              0.4,
                            ),
                            blurRadius: 3,
                            spreadRadius: 3,
                            offset: Offset(3, 3),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Image.network(
                            res['image'],
                            height: 90,
                            width: 90,
                            fit: BoxFit.cover,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: const Text(
                                          "Product name:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${res['productName']}",
                                          style: TextStyle(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Product Quantity:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${res['quantnity']}",
                                        style: TextStyle(),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Product Price:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${res['price']}",
                                        style: TextStyle(),
                                      ),
                                    ],
                                  ),

                                  // Row(
                                  //   children: [
                                  //     Row(
                                  //       children: [
                                  //         const Text("Qty:"),
                                  //         Container(
                                  //           color: Colors.black,
                                  //           alignment: Alignment.center,
                                  //           constraints: const BoxConstraints(
                                  //               minWidth: 30,
                                  //               minHeight: 20,
                                  //               maxWidth: 30,
                                  //               maxHeight: 20),
                                  //           child: Text(
                                  //             "${res['quantnity']}",
                                  //             style: const TextStyle(
                                  //               color: Colors.white,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     const SizedBox(
                                  //       width: 5,
                                  //     ),
                                  //     Row(
                                  //       children: [
                                  //         const Text("price:"),
                                  //         Text(
                                  //           "${res['price']}",
                                  //           style: const TextStyle(),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              delete(res.id, context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.red,
                                child: Icon(
                                  Icons.delete,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
