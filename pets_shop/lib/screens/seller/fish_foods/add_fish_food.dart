import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:pets_shop/screens/seler/fish_desease/all_desease_screen.dart';
import 'package:pets_shop/utils/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/ecobutton.dart';
import '../../../../widgets/ecotextfield.dart';
import 'all_fish_food.dart';
// import '../../saller/fish_desease/all_desease_screen.dart';
// import '../../saller/fish_desease/all_desease_screen.dart';

class AddFishFood extends StatefulWidget {
  const AddFishFood({Key? key}) : super(key: key);
  @override
  State<AddFishFood> createState() => _AddFishFoodState();
}

class _AddFishFoodState extends State<AddFishFood> {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController foodTitleC = TextEditingController();
  TextEditingController foodDetailC = TextEditingController();

  bool isSaving = false;
  final formkey = GlobalKey<FormState>();
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD FISH FOOD"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ListView(
            children: [
              const SizedBox(
                height: 50,
              ),
              Form(
                key: formkey,
                child: Column(
                  children: [
                    const Text(
                      "Enter Fish Food...",
                      style: EcoStyle.boldstyle,
                    ),
                    EcoTextField(
                      controller: foodTitleC,
                      hinttext: "Enter the food title...",
                      validate: (v) {
                        if (v!.isEmpty) {
                          return "should not be empty";
                        }
                        return null;
                      },
                    ),
                    EcoTextField(
                      controller: foodDetailC,
                      hinttext: "Enter detail...",
                      validate: (v) {
                        if (v!.isEmpty) {
                          return "should not be empty";
                        }
                        return null;
                      },
                    ),
                    EcoButton(
                      title: "Save",
                      isLoading: isSaving,
                      isLoginButton: true,
                      onpress: () {
                        save();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  save() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        isSaving = true;
      });
      await FirebaseFirestore.instance.collection('food').add({
        "title": foodTitleC.text,
        "detail": foodDetailC.text,
        "sellerId": currentId
      }).whenComplete(() {
        setState(() {
          isSaving = false;
          clearField();
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Succesfully Added")));
        });
      });
    }
  }

  clearField() {
    setState(() {
      foodTitleC.clear();
      foodDetailC.clear();
    });
  }
}
