import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminViewBuyer extends StatefulWidget {
  const AdminViewBuyer({Key? key}) : super(key: key);

  @override
  State<AdminViewBuyer> createState() => _AdminViewBuyerState();
}

class _AdminViewBuyerState extends State<AdminViewBuyer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 71, 207, 241),
          title: Text("Buyer Record"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('user')
                .where('type', isEqualTo: 'buyer')
                .snapshots(),
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
                                  "Buyer : ${res['name']}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Buyer-email : ${res['email']}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                // Text(
                                //   "child email : ${res['child_email']}",
                                //   style: TextStyle(fontWeight: FontWeight.bold),
                                // ),
                                // Text(
                                //   "phone : ${res['phone']}",
                                //   style: TextStyle(fontWeight: FontWeight.bold),
                                // ),
                                // Text(
                                //   "email ${res['email']}",
                                //   style: TextStyle(fontWeight: FontWeight.bold),
                                // ),
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
