import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pets_shop/widgets/ecobutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../models/cartModel.dart';
import '../../../models/accessories_model.dart';
import '../../../widgets/header.dart';

// import '../widgets/header.dart';

class AccessoriesDetailScreen extends StatefulWidget {
  final String? id;
  const AccessoriesDetailScreen({Key? key, this.id}) : super(key: key);

  @override
  State<AccessoriesDetailScreen> createState() => _AccessoriesDetailScreenState();
}

class _AccessoriesDetailScreenState extends State<AccessoriesDetailScreen> {
  List<Accessories> allProducts = [];
  int count = 1;
  var newPrice = 0;
  bool isLoading = false;
  String? sellderId;

  getDate() async {
    await FirebaseFirestore.instance
        .collection("accessories")
        .get()
        .then((QuerySnapshot? snapshot) {
      snapshot!.docs
          .where((element) => element["id"] == widget.id)
          .forEach((e) {
        if (e.exists) {
          for (var item in e["imageUrls"]) {
            if (item.isNotEmpty) {
              setState(() {
                allProducts.add(
                  Accessories(
                    id: e["id"],
                    detail: e["detail"],
                    accessoriesName: e["accessoriesName"],
                    imageUrls: e["imageUrls"],
                    price: e['price'],
                    sellerId: e['sellerId'],
                  ),
                );
              });
            }
          }
        }
        newPrice = allProducts.first.price!;
        print("okkk $newPrice");
      });
    });
    // print(allProducts[0].discountPrice);
  }

  addToFavrourite() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('favourite');
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .add({"pid": allProducts.first.id});
  }

  removeToFavrourite(String id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('favourite');
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .doc(id)
        .delete();
  }

  @override
  void initState() {
    getDate();
    print(widget.id);
    super.initState();
  }

  bool isfvrt = false;

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // print(allProducts.first.sellerId);
    print(widget.id);

    return allProducts.isEmpty
        ? Scaffold(body: const Center(child: CircularProgressIndicator()))
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
                child: Header(
                  title: "${allProducts.first.accessoriesName}",
                ),
                preferredSize: Size.fromHeight(5.h)),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(
                    allProducts[0].imageUrls![selectedIndex],
                    height: 30.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ...List.generate(
                          allProducts[0].imageUrls!.length,
                          (index) => InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 12.h,
                                width: 12.w,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: Image.network(
                                  allProducts[0].imageUrls![index],
                                  height: 9.h,
                                  width: 9.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 7.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 71, 207, 241),
                        borderRadius: BorderRadius.circular(1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text("${allProducts.first.price} PKR",
                                style: const TextStyle(color: Colors.white))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('favourite')
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .collection('items')
                          .where('pid', isEqualTo: allProducts.first.id)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.data == null) {
                          return Text("");
                        }
                        return IconButton(
                            onPressed: () {
                              snapshot.data!.docs.length == 0
                                  ? addToFavrourite()
                                  : removeToFavrourite(
                                      snapshot.data!.docs.first.id);
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: snapshot.data!.docs.length == 0
                                  ? Color.fromARGB(255, 124, 122, 122)
                                      .withOpacity(0.3)
                                  : Colors.red,
                            ));
                      }),
                  Container(
                    constraints: BoxConstraints(
                      minWidth: double.infinity,
                      minHeight: 30.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        allProducts.first.detail!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text(
                  //       "NOTE :  Discount of ${allProducts.first.discountprice} PKR will be applied when you order more then three items of this product"),
                  // ),
                  Container(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (count > 1) {
                                count--;

                                newPrice = count * allProducts.first.price!;
                              }
                            });
                          },
                          icon: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.withOpacity(0.4)),
                              child: const Center(
                                  child: Icon(Icons.exposure_minus_1))),
                        ),
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.4)),
                          child: Center(
                            child: Text(
                              "$count",
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                count++;

                                newPrice = count * allProducts.first.price!;
                              });
                            },
                            icon: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey.withOpacity(0.4)),
                                child: const Center(
                                    child: Icon(Icons.exposure_plus_1))),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 7.h,
                            width: 35.w,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 71, 207, 241),
                              borderRadius: BorderRadius.circular(1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Text("${newPrice} PKR",
                                      style: const TextStyle(
                                          color: Colors.white))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  EcoButton(
                    // isLoading: true,
                    onpress: () {
                      setState(() {
                        isLoading = false;
                      });

                      Cart.addtoCart(
                        Cart(
                            id: allProducts.first.id,
                            userId: FirebaseAuth.instance.currentUser!.uid,
                            name: allProducts.first.accessoriesName,
                            quantity: count,
                            price: newPrice,
                            sellerId: allProducts.first.sellerId,
                            image: allProducts.first.imageUrls!.first),
                      ).whenComplete(() {
                        setState(() {
                          isLoading = true;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor:
                                  Color.fromARGB(255, 71, 207, 241),
                              content: Text("Add to cart Successfully"),
                            ),
                          );
                        });
                      });
                    },
                    isLoginButton: true,
                    title: "Add to Cart",
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            ),
          );
  }
}
