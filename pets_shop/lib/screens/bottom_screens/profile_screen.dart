import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pets_shop/checking_screen.dart';
import 'package:pets_shop/widgets/header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../models/user_update_profile_model.dart';
import '../../widgets/ecobutton.dart';
import '../../widgets/ecotextfield.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static Future<void> updateProducts(
      String id, userProfile updateProducts) async {
    CollectionReference db = FirebaseFirestore.instance.collection("Saller");

    Map<String, dynamic> data = {
      "productName": updateProducts.name,
      "detail": updateProducts.email,
      "price": updateProducts.salerAddress,
      "discountprice": updateProducts.phonenumber,
    };
    await db.doc(id).update(data);
  }

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameC = TextEditingController();
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

  @override
  void initState() {
    getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(7.h),
            child: Header(
              title: "PROFILE",
            )),
        body: Column(
          children: [
            EcoTextField(
              controller: nameC,
              hinttext: "update name",
            ),
            EcoButton(
              title: "UPDATE",
              onpress: () {
                FirebaseFirestore.instance
                    .collection('user')
                    .doc(id)
                    .update({"name": nameC.text}).whenComplete(() {
                  Get.snackbar(
                    "",
                    "UPDATED",
                  );
                });
              },
            ),
            EcoButton(
              isLoginButton: true,
              title: "LOGOUT",
              onpress: () {
                FirebaseAuth.instance.signOut().whenComplete(() {
                  Future.delayed(Duration(seconds: 2), () {
                    Get.to(CheckingScreen());
                  });
                });
              },
            ),
          ],
        ));
  }
}
