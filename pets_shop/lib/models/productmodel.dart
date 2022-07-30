import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  String? catagory;
  String? id;
  String? productName;
  String? detail;
  int? price;
  var serialCode;
  String? sellerId;
  // int? discountprice;
  List<dynamic>? imageUrls;
  bool? isOnSale;
  bool? isPopular;
  bool? isFavourit;
  Products({
    this.catagory,
    this.id,
    this.sellerId,
    this.productName,
    this.detail,
    this.price,
    // this.discountprice,
    this.imageUrls,
    this.isOnSale,
    this.isPopular,
    this.isFavourit,
    this.serialCode,
    // discountPrice,
  });

  get brand => null;
  static Future<void> addProducts(Products products) async {
    CollectionReference db = FirebaseFirestore.instance.collection("products");
    Map<String, dynamic> data = {
      "catagory": products.catagory,
      "productName": products.productName,
      "sellerId": products.sellerId,
      "id": products.id,
      "detail": products.detail,
      "price": products.price,
      // "discountprice": products.discountprice,
      "imageUrls": products.imageUrls,
      "isOnSale": products.isOnSale,
      "isPopular": products.isPopular,
      "isFavourit": products.isFavourit,
      "serialCode": products.serialCode,
    };
    await db.add(data);
  }

  static Future<void> updateProducts(String id, Products updateProducts) async {
    CollectionReference db = FirebaseFirestore.instance.collection("products");

    Map<String, dynamic> data = {
      "catagory": updateProducts.catagory,
      "productName": updateProducts.productName,
      "id": updateProducts.id,
      "detail": updateProducts.detail,
      "price": updateProducts.price,
      "serialCode": updateProducts.serialCode,
      // "discountprice": updateProducts.discountprice,
      "imageUrls": updateProducts.imageUrls,
      "isOnSale": updateProducts.isOnSale,
      "isPopular": updateProducts.isPopular,
      "isFavourit": updateProducts.isFavourit,
    };
    await db.doc(id).update(data);
  }

  static Future<void> deleteProduct(String id) async {
    CollectionReference db = FirebaseFirestore.instance.collection("products");

    await db.doc(id).delete();
  }
}
