import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pets_shop/screens/seller/fish_diseaes.dart';
import 'package:pets_shop/screens/user_screens/equipments/all_equipment.dart';
import 'package:pets_shop/widgets/catagory_home_boxes.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/productmodel.dart';
import '../../product_detail_screen.dart';
import '../seller/show_fish_food.dart';

List catagories = [
  "Cat",
  "Dog",
  "Duck",
  "Fish",
  "Horse",
  "Parrot",
  "Peigon",
  "Rabbit",

];

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List images = [
    "https://agrilifetoday.tamu.edu/wp-content/uploads/2020/07/AdobeStock_84016419.jpeg",
    "https://stylesatlife.com/wp-content/uploads/2020/11/parrot-varieties.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmHMisodH1Tl90kAR0MkoR-kcs2wUzAzAndA&usqp=CAU",
    "https://thumbs.dreamstime.com/b/fantail-pigeon-beautiful-dancing-joy-117872615.jpg"
  ];

  List<Products> allProducts = [];
  List im = [];
  getImages() {
    FirebaseFirestore.instance
        .collection("adminImages")
        .get()
        .then((QuerySnapshot? snapshot) {
      snapshot!.docs.forEach((e) {
        setState(() {
          im = e['imageUrls'];
        });
        // print(e['imageUrls']);
      });
      // print(snapshot!.docs.first.data().['imageUrls']);
    });
  }

  getData() {
    FirebaseFirestore.instance
        .collection("products")
        .get()
        .then((QuerySnapshot? snapshot) {
      snapshot!.docs.forEach((e) {
        if (e.exists) {
          setState(() {
            allProducts.add(
              Products(
                catagory: e["catagory"],
                productName: e["productName"],
                id: e['id'],
                detail: e["detail"],
                price: e["price"],
                serialCode: e["serialCode"],
                imageUrls: e["imageUrls"],
                isOnSale: e["isOnSale"],
                isPopular: e["isPopular"],
                isFavourit: e["isFavourit"],
              ),
            );
          });
        }
      });
    });
  }

  @override
  void initState() {
    getData();
    getImages();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color.fromARGB(255, 71, 207, 241),
      //   actions: [
      //     IconButton(
      //         onPressed: () async {
      //           await FirebaseAuth.instance.signOut();
      //           Get.to(CheckingScreen());
      //         },
      //         icon: const Icon(Icons.logout)),
      //   ],
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                  child: RichText(
                      text: TextSpan(children: [
                TextSpan(
                    text: "Pet ",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Color.fromARGB(255, 241, 170, 71),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold)),
                TextSpan(
                    text: "Shop",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold))
              ]))),
              const CatagoryHomeBoxes(),
              // im.length == 0
              //     ?
              CarouselSlider(
                  items: images
                      .map((e) => Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    e,
                                    //fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 160,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: LinearGradient(colors: [
                                        Colors.blueAccent.withOpacity(0.3),
                                        Colors.redAccent.withOpacity(0.3),
                                      ])),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 20,
                                child: Container(
                                  color: Colors.black.withOpacity(0.4),
                                  child: const Text(
                                    "Pets",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ))
                      .toList(),
                  options: CarouselOptions(
                    height: 180,
                    autoPlay: true,
                  )),

              const Text(
                "POPULAR ITEMS",
                style: TextStyle(fontSize: 25),
              ),
              allProducts.isEmpty
                  ? const CircularProgressIndicator()
                  : PopularItems(allProducts: allProducts),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllAccessories(),
                        ));
                  },
                  child: Container(
                    height: 10.h,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: const Text(
                          "PURCHASE EQUIPMENTS",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FishDiseasese()));
                      },
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width * 0.42,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 241, 170, 71),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: (Text(
                            "Fish Diseases",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    InkWell(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FishFood()));
                        },
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width * 0.45,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 71, 207, 241),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                            child: (Text(
                              "Fish Food",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopularItems extends StatelessWidget {
  const PopularItems({
    Key? key,
    required this.allProducts,
  }) : super(key: key);

  final List<Products> allProducts;

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 15.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: allProducts
            .where((element) => element.isPopular == true)
            .map((e) => Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductDetailScreen(id: e.id),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  e.imageUrls![0],
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(child: Text(e.productName!)),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
