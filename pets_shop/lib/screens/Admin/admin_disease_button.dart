// import 'package:pets_shop/screens/saller/Admin/admin_add_disease_field.dart';
import 'package:pets_shop/screens/seller/fish_desease/add_disease_screen.dart';
import 'package:pets_shop/widgets/ecobutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import 'admin_upload_images.dart';

class AdminDiseaseScreen extends StatefulWidget {
  @override
  State<AdminDiseaseScreen> createState() => _AdminDiseaseScreenState();
}

class _AdminDiseaseScreenState extends State<AdminDiseaseScreen> {
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        title: const Text("ADMIN"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // EcoButton(
          //   onpress: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => AdminAddDiseaseFieldScreen()));
          //   },
          //   title: "Fish Diseaese",
          // ),
          EcoButton(
            onpress: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminUploadImage()));
            },
            title: "Upload Images",
          ),
        ],
      ),
    );
  }
}
