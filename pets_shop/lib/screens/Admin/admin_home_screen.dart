import 'package:pets_shop/screens/Admin/admin_show_accessories.dart';
import 'package:pets_shop/screens/Admin/admin_show_peet_medecine.dart';
import 'package:pets_shop/screens/Admin/admin_view_users_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../checking_screen.dart';
import '../../utils/style.dart';
import '../../widgets/ecobutton.dart';
import 'admin_show_cart_data.dart';
import 'admin_view_orders.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(child: Text("Admin Functions")),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Get.to(CheckingScreen());
                  // MyPrefferenc.saveEmail("");
                },
                title: Text('LOG OUT'),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 247, 169, 60),
          title: const Text(
            'Welcome-Admin',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Chose one thing",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Color.fromARGB(255, 247, 169, 60),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            EcoButton(
              title: "Admin View Users",
              onpress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminVieeUsersBox()));
              },
            ),
            EcoButton(
              title: "Cart-Items",
              onpress: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminShowCart()));
              },
            ),
            // EcoButton(
            //   title: "Favorite Items",
            //   onpress: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => AdminViewFavouirteitems()));
            //   },
            // ),

            EcoButton(
              title: "TOTAL ACTIVE ORDERS",
              onpress: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminViewOrders()));
              },
            ),
            EcoButton(
              title: "Show_Accessories",
              onpress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Adminshowaccessories()));
              },
            ),
            EcoButton(
              title: "Show-Peet-Medicine",
              onpress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminShowPeetMedicine()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
