import 'package:cloud_firestore/cloud_firestore.dart';

class MedicineModel {
  String? medicineTitle;
  String? medicineTreatment;
  String? medicineSymtomps;
  String? sellerId;
  MedicineModel({
    this.medicineTitle,
    this.medicineTreatment,
    this.medicineSymtomps,
    this.sellerId,
  });

  static Future<void> addProducts(MedicineModel products) async {
    CollectionReference db = FirebaseFirestore.instance.collection("medicine");
    Map<String, dynamic> data = {
      "medicineTitle": products.medicineTitle,
      "medicineSymtomps": products.medicineSymtomps,
      "medicineTreatment": products.medicineTreatment,
      'sllerId': products.sellerId,
    };
    await db.add(data);
  }

  static Future<void> deleteMedicine(String id) async {
    CollectionReference db = FirebaseFirestore.instance.collection("medicine");
    await db.doc(id).delete();
  }

  static Future<void> updateMedicine(String id, MedicineModel products) async {
    CollectionReference db = FirebaseFirestore.instance.collection("medicine");
    Map<String, dynamic> data = {
      "medicineTitle": products.medicineTitle,
      "medicineSymtomps": products.medicineSymtomps,
      "medicineTreatment": products.medicineTreatment,
      'sllerId': products.sellerId,
    };
    await db.doc(id).update(data);
  }
}
