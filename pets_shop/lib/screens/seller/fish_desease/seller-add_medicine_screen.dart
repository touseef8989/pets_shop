import 'package:pets_shop/utils/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/ecobutton.dart';
import '../../../../widgets/ecotextfield.dart';
import '../../../models/medicine_model.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({Key? key}) : super(key: key);
  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController medicineTitle = TextEditingController();
  TextEditingController medicineSymtomps = TextEditingController();
  TextEditingController medicineTreatment = TextEditingController();

  bool isSaving = false;

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:  Color.fromARGB(255, 247, 169, 60),
        ),
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
                      "Enter Medicine Here...",
                        style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color.fromARGB(255, 247, 169, 60),
                  ),
                    ),
                    EcoTextField(
                      maxlines: 1,
                      controller: medicineTitle,
                      hinttext: "Enter the Medicine title...",
                      validate: (v) {
                        if (v!.isEmpty) {
                          return "should not be empty";
                        }
                        return null;
                      },
                    ),
                    EcoTextField(
                      controller: medicineSymtomps,
                      maxlines: 2,
                      hinttext: "Enter Medicine Symptoms...",
                      validate: (v) {
                        if (v!.isEmpty) {
                          return "should not be empty";
                        }
                        return null;
                      },
                    ),
                    EcoTextField(
                      maxlines: 5,
                      controller: medicineTreatment,
                      hinttext: "Enter Medicine treatment...",
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
      ),
    );
  }

  save() async {
    setState(() {
      isSaving = true;
    });
    await MedicineModel.addProducts(
      MedicineModel(
        medicineTitle: medicineTitle.text,
        medicineTreatment: medicineTreatment.text,
        medicineSymtomps: medicineSymtomps.text,
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
      medicineTitle.clear();
    });
  }
}
