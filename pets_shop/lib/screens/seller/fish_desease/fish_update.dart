import 'package:pets_shop/utils/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/ecobutton.dart';
import '../../../../widgets/ecotextfield.dart';
import '../../../models/medicine_model.dart';

class UpdateDeseaseScreen extends StatefulWidget {
  String? id;
  MedicineModel? desease;
  UpdateDeseaseScreen({Key? key, this.id, this.desease}) : super(key: key);
  @override
  State<UpdateDeseaseScreen> createState() => _UpdateDeseaseScreenState();
}

class _UpdateDeseaseScreenState extends State<UpdateDeseaseScreen> {
  TextEditingController diseaseTitle = TextEditingController();
  TextEditingController diseaseSymtomps = TextEditingController();
  TextEditingController diseaseTreatment = TextEditingController();
  @override
  void initState() {
    diseaseTitle.text = widget.desease!.medicineTitle!;
    diseaseSymtomps.text = widget.desease!.medicineSymtomps!;
    diseaseTreatment.text = widget.desease!.medicineTreatment!;
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
                    "Enter Disease Here...",
                    style: EcoStyle.boldstyle,
                  ),
                  EcoTextField(
                    maxlines: 1,
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
                    maxlines: 2,
                    hinttext: "Enter diseases Symptoms...",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    maxlines: 5,
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
    await MedicineModel.updateMedicine(
      widget.id!,
      MedicineModel(
        medicineTitle: diseaseTitle.text,
        medicineTreatment: diseaseTreatment.text,
        medicineSymtomps: diseaseSymtomps.text,
        sellerId: FirebaseAuth.instance.currentUser!.uid,
      ),
    ).whenComplete(() {
      setState(() {
        isSaving = false;
        // clearField();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Succesfully Added")));
      });
    });
  }

  clearField() {
    setState(() {
      diseaseTitle.clear();
    });
  }
}
