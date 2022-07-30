import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  String? id;
  String? userId;
  String? name;
  int? quantity;
  int? price;
  String? image;
  String? sellerId;
  Cart({
     this.id,
     this.name,
     this.userId,
     this.quantity,
     this.price,
     this.image,
     this.sellerId,
  });

  static Future<void> addtoCart(Cart cart) async {
    CollectionReference db = FirebaseFirestore.instance.collection("cart");
    Map<String, dynamic> data = {
      "id": cart.id,
      "productName": cart.name,
      "userId": cart.userId,
      "image": cart.image,
      "quantnity": cart.quantity,
      "price": cart.price,
      "sellerId": cart.sellerId,
    };
    await db.add(data);
  }

  static Future<void> getdata() async {
    var d = await FirebaseFirestore.instance.collection("cart").doc().get();
  }
}
