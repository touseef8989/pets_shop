import 'package:pets_shop/screens/seller/saller_login.dart';
import 'package:pets_shop/utils/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({Key? key}) : super(key: key);
  Future<FirebaseApp> intialize = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: intialize,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (BuildContext context, AsyncSnapshot streamSnapshot) {
                  if (streamSnapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("${streamSnapshot.error}"),
                      ),
                    );
                  }
                  if (streamSnapshot.connectionState ==
                      ConnectionState.active) {
                    User? user = streamSnapshot.data;
                    //print(user!.email);

                    if (user == null) {
                      return SallerLoginScreen();
                      // } else {
                      //   // return const BottomPage();
                    }
                  }
                  return Scaffold(
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "CHECKING AUTHENTICATION",
                            textAlign: TextAlign.center,
                            style: EcoStyle.boldstyle,
                          ),
                          CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  );
                });
          }

          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "INTIALIZATION",
                    style: EcoStyle.boldstyle,
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        });
  }
}
