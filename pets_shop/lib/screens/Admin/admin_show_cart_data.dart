import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminShowCart extends StatefulWidget {
  const AdminShowCart({Key? key}) : super(key: key);

  @override
  State<AdminShowCart> createState() => _AdminShowCartState();
}

class _AdminShowCartState extends State<AdminShowCart> {
  CollectionReference db = FirebaseFirestore.instance.collection("cart");
  delete(String id, BuildContext context) {
    db.doc(id).delete().then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("successfuly deleted"))),
        );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 247, 169, 60),
          title: Text("View Carts"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('cart').snapshots(),
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
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Product name:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            "${res['productName']}",
                                            style: TextStyle(),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Product Quantity:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            "${res['quantnity']}",
                                            style: TextStyle(),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Product Price:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            "${res['price']}",
                                            style: TextStyle(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // InkWell(
                              //   onTap: () {
                              //     delete(res.id, context);
                              //   },
                              //   child: const Padding(
                              //     padding: EdgeInsets.all(3.0),
                              //     child: CircleAvatar(
                              //       radius: 10,
                              //       backgroundColor: Colors.red,
                              //       child: Icon(
                              //         Icons.delete,
                              //         size: 15,
                              //         color: Colors.white,
                              //       ),
                              //     ),
                              //   ),
                              // ),
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
        ),
      ),
    );
  }
}
