import 'package:pets_shop/checking_screen.dart';
import 'package:pets_shop/screens/seller/equipments/add_accessories.dart';
import 'package:pets_shop/screens/seller/fish_foods/add_fish_food.dart';
import 'package:pets_shop/screens/seller/fish_desease/add_disease_screen.dart';
import 'package:pets_shop/screens/seller/checkout_screen/seller_order_screen.dart';
import 'package:pets_shop/screens/seller/fish_desease/all_desease_screen.dart';
import 'package:pets_shop/screens/seller/fish_foods/all_fish_food.dart';
import 'package:pets_shop/screens/seller/seller_add_product.dart';
import 'package:pets_shop/screens/seller/seller_show_product.dart';
import 'package:pets_shop/screens/seller/fish_foods/add_fish_food.dart';
import 'package:pets_shop/services/share_preff.dart';
import 'package:pets_shop/utils/style.dart';
import 'package:pets_shop/widgets/ecobutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'equipments/all_accessories.dart';

class SallerHomeScreen extends StatelessWidget {
  const SallerHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(child: Text("drawer header")),
              ListTile(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Get.to(CheckingScreen());
                  MyPrefferenc.saveEmail("");
                },
                title: Text('LOG OUT'),
              ),
            ],
          ),
        ),
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 247, 169, 60),
          title: Text('seller home screen'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "PRODUCTS",
                   style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color.fromARGB(255, 247, 169, 60),
                  ),
              ),
              EcoButton(
                title: "ADD PRODUCT",
                onpress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SallerAddProduct()));
                },
              ),
              EcoButton(
                title: "ALL PRODUCT",
                onpress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateProductScreen()));
                },
              ),
              const Text(
                "Accessories",
                   style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color.fromARGB(255, 247, 169, 60),
                  ),
              ),
              EcoButton(
                title: "ADD ACCESSORIES",
                onpress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddAccessories()));
                },
              ),
              EcoButton(
                title: "ALL ACCESSORIES",
                onpress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AllEquipments()));
                },
              ),
              const Text(
                "MEDICINE",
                   style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color.fromARGB(255, 247, 169, 60),
                  ),
              ),
              EcoButton(
                title: "ADD PETS MEDICINE",
                onpress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddDeseaseScreen()));
                },
              ),
              EcoButton(
                title: "ALL PETS MEDICINE",
                onpress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllFishDeseaseScreen()));
                },
              ),
              const Text(
                "FOODS",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color.fromARGB(255, 247, 169, 60),
                  ),
              ),
              EcoButton(
                title: "ADD PETS FOOD",
                onpress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddFishFood()));
                },
              ),
              EcoButton(
                title: "ALL PETS FOOD",
                onpress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AllFishFood()));
                },
              ),
              const Text(
                "ORDERS",
                   style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color.fromARGB(255, 247, 169, 60),
                  ),
              ),
              EcoButton(
                title: "ORDERS",
                onpress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SellerOrders()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
