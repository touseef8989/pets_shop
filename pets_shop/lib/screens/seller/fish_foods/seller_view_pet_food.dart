import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pets_shop/screens/seller/fish_foods/food_update.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final currentId = FirebaseAuth.instance.currentUser!.uid;

class SellerViewPetFood extends StatelessWidget {
  const SellerViewPetFood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 247, 169, 60),
        title: Text("ALL FISH FOOD"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("food")
            .where('sellerId', isEqualTo: currentId)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null) {
            return const Center(child: Text("No Data Exists"));
          }
          var data = snapshot.data!.docs;
          return ListView.builder(
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: ListTile(
                            title: Text(
                              data[index]["title"],
                              style: const TextStyle(color: Colors.black),
                            ),
                            trailing: Container(
                              width: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection("food")
                                          .doc(data[index].id)
                                          .delete();
                                    },
                                    icon: const Icon(Icons.delete_forever),
                                    color: Colors.black,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return FoodUpdateScreen(
                                          id: data[index].id,
                                          title: data[index]['title'],
                                          detail: data[index]['detail'],
                                          sellerId: data[index]['sellerId'],
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
              });
        },
      ),
    );
  }
}
