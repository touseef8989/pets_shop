import 'package:cloud_firestore/cloud_firestore.dart';

class adminImages {
  List<dynamic>? imageUrls;
  adminImages({
    this.imageUrls,
  });

  get brand => null;
  static Future<void> addProducts(adminImages products) async {
    CollectionReference db =
        FirebaseFirestore.instance.collection("adminImages");
    Map<String, dynamic> data = {
      "imageUrls": products.imageUrls,
    };
    await db.add(data);
  }

  static Future<void> updateProducts(
      String id, adminImages updateProducts) async {
    CollectionReference db =
        FirebaseFirestore.instance.collection("adminImages");

    Map<String, dynamic> data = {
      "imageUrls": updateProducts.imageUrls,
    };
    await db.doc(id).update(data);
  }

  static Future<void> deleteProduct(String id) async {
    CollectionReference db =
        FirebaseFirestore.instance.collection("adminImages");

    await db.doc(id).delete();
  }
}
