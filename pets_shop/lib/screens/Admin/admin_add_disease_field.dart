import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/disease_model.dart';
import '../../utils/style.dart';
import '../../widgets/ecobutton.dart';
import '../../widgets/ecotextfield.dart';

class AdminAddDiseaseFieldScreen extends StatefulWidget {
  const AdminAddDiseaseFieldScreen({Key? key}) : super(key: key);
  @override
  State<AdminAddDiseaseFieldScreen> createState() =>
      _AdminAddDiseaseFieldScreenState();
}

class _AdminAddDiseaseFieldScreenState
    extends State<AdminAddDiseaseFieldScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController diseaseTitle = TextEditingController();
  TextEditingController diseaseSymtomps = TextEditingController();
  TextEditingController diseaseTreatment = TextEditingController();

  bool isSaving = false;

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "Enter Disease Here...",
                    style: EcoStyle.boldstyle,
                  ),
                  EcoTextField(
                    controller: diseaseTitle,
                    hinttext: "Enter the Disease title...",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    controller: diseaseSymtomps,
                    hinttext: "Enter diseases Symptoms...",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    controller: diseaseTreatment,
                    hinttext: "Enter disease treatment...",
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
    await DiseaseModel.addProducts(
      DiseaseModel(
        diseaseTitle: diseaseTitle.text,
        diseaseTreatment: diseaseTreatment.text,
        diseaseSymtomps: diseaseSymtomps.text,
      ),
    ).whenComplete(() {
      setState(() {
        isSaving = false;
        clearField();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("SuccesFully Added")));
      });
    });
  }

  clearField() {
    setState(() {
      diseaseTitle.clear();
    });
  }
}
