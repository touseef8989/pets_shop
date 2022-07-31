import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pets_shop/screens/user_screens/user-accessories/user_detail_accessories.dart.dart';
import 'package:sizer/sizer.dart';

class AllAccessories extends StatelessWidget {
  // // const EquipmentDetailScreen({Key? key}) : super(key: key);
  // String? id;
  // EquipmentDetailScreen({this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Equipments"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('equipments').snapshots(),
          // initialData: initialData,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final d = snapshot.data!.docs[index];

                return Container(
                  constraints: BoxConstraints(minHeight: 100, minWidth: 100),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AccessoriesDetailScreen(
                                id: d['id'],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                snapshot.data!.docs[index]['imageUrls'][0],
                                fit: BoxFit.cover,
                                height: 18.h,
                                width: 48.w,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        d['equipmentName'],
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            );
            // return Container(
            //   child: child,
            // );
          },
        ),
      ),
    );
  }
}
