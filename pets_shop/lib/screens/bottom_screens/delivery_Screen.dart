import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pets_shop/screens/bottom_screens/bottom_page.dart';
import 'package:pets_shop/widgets/ecobutton.dart';
import 'package:pets_shop/widgets/ecotextfield.dart';
import 'package:pets_shop/widgets/header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({Key? key}) : super(key: key);

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  int totalPrice = 0;
  getCart() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('cart')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          totalPrice = totalPrice + element['price'] as int;
        });
        print(element['price']);
      });
    });
  }

  TextEditingController nameC = TextEditingController();
  TextEditingController streetC = TextEditingController();
  TextEditingController houseC = TextEditingController();
  TextEditingController townC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController phoneC = TextEditingController();

  final formkey = GlobalKey<FormState>();

  String? id;
  getName() async {
    await FirebaseFirestore.instance
        .collection('user')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      nameC.text = value.docs.first['name'];
      id = value.docs.first.id;
    });
  }

//  String name = "";
  List<dynamic> productNames = [];
  List<dynamic> sellderIds = [];

  int price = 0;

  int quant = 0;

  getcart() async {
    await FirebaseFirestore.instance
        .collection('cart')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((QuerySnapshot? snapshot) {
      snapshot!.docs.forEach((e) {
        setState(() {
          print(e['productName']);
          // productNames = e['productName'];
          // for (var element in e['productName']) {
          //   productNames = element;
          // }
          productNames.add(e['productName']);
          sellderIds.add(e['sellerId']);
        });
        // print(e['imageUrls']);
      });
      // value.docs.forEach((element) {
      //   setState(() {
      //     print(element['productName']);
      //     // totalPrice = totalPrice + element['price'] as int;
      //   });
      //   print(element['price']);
      // });
    });
  }

  @override
  void initState() {
    getCart();
    // nameC.text=
    getcart();
    getName();
    super.initState();
  }

  checkout() async {
    CollectionReference db = FirebaseFirestore.instance.collection('checkout');
    Map m = {};

    db.add({
      'name': nameC.text,
      'phone': phoneC.text,
      'city': cityC.text,
      'town': townC.text,
      'house': houseC.text,
      'street': streetC.text,
      'address': cityC.text,
      'pname': productNames,
      "sellderId": sellderIds,
      'pquantity': quant,
    }).whenComplete(() {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Congratulations',
        btnOkColor: Colors.blue,
        desc: 'Your Order Placed Successfully',
        btnOkOnPress: () {
          Get.to(BottomPage());
        },
      )..show().then((value) {
          var u = FirebaseAuth.instance.currentUser!.uid;
          Stream<QuerySnapshot> productRef = FirebaseFirestore.instance
              .collection("cart")
              .where("userId", isEqualTo: u)
              .snapshots();
          productRef.forEach((field) {
            field.docs.asMap().forEach((index, data) {
              setState(() {
                for (QueryDocumentSnapshot snapshot in field.docs) {
                  snapshot.reference.delete();
                }
              });

              print(m);
            });
          });
        });
    });
  }

  // getCartData() async {
  //   await FirebaseFirestore.instance
  //       .collection("cart")
  //       .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .get()
  //       .then((value) {

  //       });
  // }

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser!.uid);
    // getCart();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.h),
          child: Header(
            title: "ORDER CART ITEMS",
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 241, 170, 71),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      Text(
                        'total price to be pay : ',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text('$totalPrice'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text('Enter your delivery address for shipping'),
              Column(
                children: [
                  EcoTextField(
                    controller: nameC,
                    enable: false,
                  ),
                  EcoTextField(
                    controller: phoneC,
                    hinttext: "enter phone no.",
                    icons: Icon(
                      Icons.phone,
                      color: Color.fromARGB(255, 247, 169, 60),
                    ),
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "can not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    controller: houseC,
                    icons: Icon(
                      Icons.location_on,
                      color: Color.fromARGB(255, 247, 169, 60),
                    ),
                    hinttext: "enter house no.",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "can not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    controller: streetC,
                    icons: Icon(
                      Icons.home,
                      color: Color.fromARGB(255, 247, 169, 60),
                    ),
                    hinttext: "enter street no.",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "can not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    controller: townC,
                    icons: Icon(
                      Icons.streetview_outlined,
                      color: Color.fromARGB(255, 247, 169, 60),
                    ),
                    hinttext: "enter town name",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "can not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    controller: cityC,
                    icons: Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 247, 169, 60),
                    ),
                    hinttext: "enter city name",
                    
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "can not be empty";
                      }
                      return null;
                    },
                  ),
                  Center(
                      child: EcoButton(
                    title: "confirm delivery",
                    onpress: () {
                      checkout();
                    },
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


          // StreamBuilder(
          //   stream: FirebaseFirestore.instance.collection('products').snapshots(),
          //   builder:
          //       (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //     if (!snapshot.hasData) {
          //       return CircularProgressIndicator();
          //     }
          //     if (snapshot.data == null) {
          //       return Center(child: Text("No Favourite Items Found"));
          //     }
          //     List<QueryDocumentSnapshot<Object?>> fp = snapshot.data!.docs
          //         .where((element) => ids.contains(element["id"]))
          //         .toList();
          //     return ListView.builder(
          //       itemCount: fp.length,
          //       itemBuilder: (BuildContext context, int index) {
          //         return Padding(
          //           padding:
          //               EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.7.h),
          //           child: InkWell(
          //             onTap: () {
          //               Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (_) => ProductDetailScreen(
          //                             id: fp[index]['id'],
          //                           )));
          //             },
          //             child: Card(
          //                 elevation: 10.0,
          //                 shape: RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(20)),
          //                 color: Colors.black,
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(8.0),
          //                   child: ListTile(
          //                     title: Text(fp[index]['productName'],
          //                         style: TextStyle(
          //                           color: Colors.white,
          //                         )),
          //                     trailing: IconButton(
          //                         onPressed: () {},
          //                         icon: Icon(
          //                           Icons.navigate_next_outlined,
          //                           color: Colors.white,
          //                         )),
          //                   ),
          //                 )),
          //           ),
          //         );
          //       },
          //     );
          //   },
          // ),
