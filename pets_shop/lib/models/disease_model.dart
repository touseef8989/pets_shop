import 'package:cloud_firestore/cloud_firestore.dart';

class DiseaseModel {
  String? diseaseTitle;
  String? diseaseTreatment;
  String? diseaseSymtomps;
  String? sellerId;
  DiseaseModel({
    this.diseaseTitle,
    this.diseaseTreatment,
    this.diseaseSymtomps,
    this.sellerId,
  });

  static Future<void> addProducts(DiseaseModel products) async {
    CollectionReference db = FirebaseFirestore.instance.collection("desease");
    Map<String, dynamic> data = {
      "diseaseTitle": products.diseaseTitle,
      "diseaseSymtomps": products.diseaseSymtomps,
      "diseaseTreatment": products.diseaseTreatment,
      'sllerId': products.sellerId,
    };
    await db.add(data);
  }

  static Future<void> deleteDesease(String id) async {
    CollectionReference db = FirebaseFirestore.instance.collection("desease");
    await db.doc(id).delete();
  }

  static Future<void> updateDesease(String id, DiseaseModel products) async {
    CollectionReference db = FirebaseFirestore.instance.collection("desease");
    Map<String, dynamic> data = {
      "diseaseTitle": products.diseaseTitle,
      "diseaseSymtomps": products.diseaseSymtomps,
      "diseaseTreatment": products.diseaseTreatment,
      'sllerId': products.sellerId,
    };
    await db.doc(id).update(data);
  }
}
