import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminViewOrders extends StatefulWidget {
  const AdminViewOrders({Key? key}) : super(key: key);

  @override
  State<AdminViewOrders> createState() => _AdminViewOrdersState();
}

class _AdminViewOrdersState extends State<AdminViewOrders> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 247, 169, 60),
          title: Text("View Orders"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('checkout').snapshots(),
            // initialData: initialData,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('loading...'));
              }
              return Container(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final res = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: Color.fromARGB(255, 165, 222, 245))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${res['name']}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                //   children: [
                                //     IconButton(
                                //       splashColor: Colors.red,
                                //       onPressed: () {},
                                //       icon: Icon(
                                //         Icons.delete,
                                //         color: Colors.red,
                                //       ),
                                //     )
                                //   ],
                                // ),
                                Divider(
                                  color: Colors.blue,
                                ),
                                Text(
                                  "Buyer-Name : ${res['name']}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Buyer-Phone : ${res['phone']}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Buyer-Address : ${res['address']}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Buyer-City : ${res['city']}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Buyer-Houe-number ${res['house']}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Buyer-Street ${res['street']}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Buyer-Town ${res['town']}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
