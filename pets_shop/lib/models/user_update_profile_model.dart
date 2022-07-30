import 'package:cloud_firestore/cloud_firestore.dart';

class userProfile {
  String? name;
  String? email;
  int? salerAddress;
  int? phonenumber;
  userProfile({
    this.name,
    this.email,
    this.salerAddress,
    this.phonenumber,
    discountPrice,
  });
  get brand => null;
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

  static Future<void> deleteProduct(String id) async {
    CollectionReference db = FirebaseFirestore.instance.collection("products");

    await db.doc(id).delete();
  }
}
