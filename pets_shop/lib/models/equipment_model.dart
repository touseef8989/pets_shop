import 'package:cloud_firestore/cloud_firestore.dart';

class Accessories {
  String? id;
  String? accessoriesName;
  String? detail;
  int? price;
  String? sellerId;
  // int? discountprice;
  List<dynamic>? imageUrls;
  Accessories({
    this.id,
    this.sellerId,
    this.accessoriesName,
    this.detail,
    this.price,
    this.imageUrls,
  });

  get brand => null;
  static Future<void> addProducts(Accessories accessories) async {
    CollectionReference db =
        FirebaseFirestore.instance.collection("accessories");
    Map<String, dynamic> data = {
      "accessoriesName": accessories.accessoriesName,
      "sellerId": accessories.sellerId,
      "id": accessories.id,
      "detail": accessories.detail,
      "price": accessories.price,
      "imageUrls": accessories.imageUrls,
    };
    await db.add(data);
  }

  static Future<void> updateProducts(
      String id, Accessories updateAccessories) async {
    CollectionReference db =
        FirebaseFirestore.instance.collection("accessories");

    Map<String, dynamic> data = {
      "accessoriesName": updateAccessories.accessoriesName,
      "id": updateAccessories.id,
      "detail": updateAccessories.detail,
      "price": updateAccessories.price,
      "imageUrls": updateAccessories.imageUrls,
    };
    await db.doc(id).update(data);
  }

  static Future<void> deleteProduct(String id) async {
    CollectionReference db =
        FirebaseFirestore.instance.collection("accessories");

    await db.doc(id).delete();
  }
}
