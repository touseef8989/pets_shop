import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pets_shop/utils/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/ecobutton.dart';
import '../../../../widgets/ecotextfield.dart';

class FoodUpdateScreen extends StatefulWidget {
  String? id;
  String? title;
  String? detail;
  String? sellerId;

  FoodUpdateScreen({Key? key, this.id, this.title, this.detail, this.sellerId})
      : super(key: key);
  @override
  State<FoodUpdateScreen> createState() => _FoodUpdateScreenState();
}

class _FoodUpdateScreenState extends State<FoodUpdateScreen> {
  TextEditingController foodTitle = TextEditingController();
  TextEditingController foodDetail = TextEditingController();
  @override
  void initState() {
    foodTitle.text = widget.title!;
    foodDetail.text = widget.detail!;

    // diseaseTitle.text = widget.desease!.diseaseTitle!;

    super.initState();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  bool isSaving = false;

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ListView(
            children: [
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  const Text(
                    "Update Food Here...",
                    style: EcoStyle.boldstyle,
                  ),
                  EcoTextField(
                    maxlines: 1,
                    controller: foodTitle,
                    hinttext: "Enter the food title...",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    controller: foodDetail,
                    maxlines: 2,
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
            ],
          ),
        ),
      ),
    );
  }

  save() async {
    setState(() {
      isSaving = true;
    });
    await FirebaseFirestore.instance.collection('food').doc(widget.id).update({
      "title": foodTitle.text,
      "detail": foodDetail.text,
      "sellerId": widget.sellerId,
    }).whenComplete(() {
      setState(() {
        isSaving = false;
        // clearField();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Succesfully updated")));
      });
    });
  }
}
