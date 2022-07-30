// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class AdminViewFavouirteitems extends StatefulWidget {
//   const AdminViewFavouirteitems({Key? key}) : super(key: key);

//   @override
//   State<AdminViewFavouirteitems> createState() =>
//       _AdminViewFavouirteitemsState();
// }

// class _AdminViewFavouirteitemsState extends State<AdminViewFavouirteitems> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           backgroundColor: Color.fromARGB(255, 248, 133, 172),
//           title: Text("User Record"),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection('favourite')
//                 .where('items', isEqualTo: 'pid')
//                 .snapshots(),
//             // initialData: initialData,
//             builder:
//                 (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (!snapshot.hasData) {
//                 return Center(child: Text('loading...'));
//               }
//               return Container(
//                 child: ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     final res = snapshot.data!.docs[index];
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(6),
//                               border: Border.all(
//                                   color: Color.fromARGB(255, 241, 174, 196))),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Align(
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                       "${res['pid']}",
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold),
//                                     )),
//                               ],
//                             ),
//                           )),
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
