import 'package:pets_shop/screens/seller/saller_login.dart';
import 'package:pets_shop/widgets/ecobutton.dart';
import 'package:flutter/material.dart';

import '../Admin/admin_login.dart';
import '../user_screens/user_login.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                "https://is4-ssl.mzstatic.com/image/thumb/Purple20/v4/82/07/b4/8207b46c-463e-516e-dcbc-ad58dfa002dd/source/512x512bb.jpg",
                
              ),
            ),
          ),
          child: ListView(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Title(
                    color: Colors.blue,
                    child: Text(
                      "Login With your account",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color.fromARGB(255, 247, 169, 60),
                      ),
                    ),
                  ),
                ),
              ),
              // CircleAvatar(

              //   backgroundImage:
              //       const AssetImage('assests/c_images/admin-login.png'),
              //   radius: 50,
              // ),
              Container(
                width: 130.0,
                height: 130.0,
                decoration: new BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Color.fromARGB(255, 190, 248, 252),
                      width: 10.0,
                      style: BorderStyle.solid),
                  image: new DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSj31mBmDAhdYsuiQvb9FUSTaX4mLJ2hFonOA&usqp=CAU"),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              EcoButton(
                title: "Login As Admin",
                onpress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => AdminLoginScreen()));
                },
              ),
              EcoButton(
                title: "Login As User",
                onpress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => UserLoginScreen()));
                },
              ),
              EcoButton(
                title: "Login As Seller",
                onpress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SallerLoginScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
