import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SellerOrders extends StatefulWidget {
  const SellerOrders({Key? key}) : super(key: key);

  @override
  State<SellerOrders> createState() => _SellerOrdersState();
}

class _SellerOrdersState extends State<SellerOrders> {
  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser!.uid);
    return Scaffold(
      appBar: AppBar(
        title: Text("ALL ORDERS TO DELIVER"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('checkout')
            .where('sellderId',
                arrayContains: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              List products = snapshot.data!.docs[index]['pname'];
              final d = snapshot.data!.docs[index];
              final address = d['street'] +
                  " " +
                  d['house'] +
                  " " +
                  d['town'] +
                  " " +
                  d['city'];
              return Card(
                  // color: Colors.black,
                  child: Column(
                children: [
                  Text("products"),
                  Row(
                      children: products
                          .map((e) => Text(
                                e,
                                style: TextStyle(fontSize: 30),
                              ))
                          .toList()),
                  Text("from"),
                  Text(d['name']),
                  Text("Address : "),
                  Text(address),
                ],
              ));
            },
          );
        },
      ),
    );
  }
}
