import 'dart:math';
import 'package:pets_shop/screens/Admin/admin_view_Seller_record.dart';
import 'package:pets_shop/screens/Admin/admin_view_buyer.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class AdminVieeUsersBox extends StatefulWidget {
  String? userid;

  AdminVieeUsersBox({this.userid});

  @override
  State<AdminVieeUsersBox> createState() => _AdminVieeUsersBoxState();
}

class _AdminVieeUsersBoxState extends State<AdminVieeUsersBox> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 71, 207, 241),
          centerTitle: true,
          title: const Text(
            "View Users",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => AdminViewBuyer()));
                      },
                      child: Container(
                        constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.width * 0.4,
                            minWidth: MediaQuery.of(context).size.width * 0.4),
                        decoration: BoxDecoration(
                          color: Colors.primaries[Random().nextInt(16)]
                              .withOpacity(0.4),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Buyer-Record",
                              style: TextStyle(fontSize: 20),
                            ),
                            // Text("Total  $totalDoctors"),
                          ],
                        )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => AdminViewSeller()));
                      },
                      child: Container(
                        constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.width * 0.4,
                            minWidth: MediaQuery.of(context).size.width * 0.4),
                        decoration: BoxDecoration(
                          color: Colors.primaries[Random().nextInt(16)]
                              .withOpacity(0.4),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Seller-Record",
                              style: TextStyle(fontSize: 20),
                            ),
                            // Text("Total $totalPatients"),
                          ],
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
