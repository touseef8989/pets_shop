import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminShowequipments extends StatefulWidget {
  const AdminShowequipments({Key? key}) : super(key: key);

  @override
  State<AdminShowequipments> createState() => _AdminShowequipmentsState();
}

class _AdminShowequipmentsState extends State<AdminShowequipments> {
  // CollectionReference db = FirebaseFirestore.instance
  //     .collection("user")
  //     .where("type", isEqualTo: "seller") as CollectionReference<Object?>;
  // delete(String id, BuildContext context) {
  //   db.doc(id).delete().then(
  //         (value) => ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(content: Text("successfuly deleted"))),
  //       );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 71, 207, 241),
          title: Text("Show_Equipments"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('equipments').snapshots(),
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
                                    "${res['equipmentName']}",
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
                                //       onPressed: () {
                                //         // delete(res.id, context);
                                //       },
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
                                  "Names : ${res['equipmentName']}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Detail : ${res['detail']}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Price : ${res['price']}",
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
