import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pets_shop/screens/Admin/admin_login.dart';
import 'package:pets_shop/screens/bottom_screens/bottom_page.dart';
import 'package:pets_shop/screens/seller/saller_login.dart';
import 'package:pets_shop/services/share_preff.dart';
import 'package:sizer/sizer.dart';

import 'checking_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MyPrefferenc.init();

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
          title: 'fish_app',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blue,
              backgroundColor: Colors.white,
              scaffoldBackgroundColor: Colors.white),
          home: CheckingScreen(),
          routes: {
            SallerLoginScreen.id: (context) => const SallerLoginScreen(),
            AdminLoginScreen.id: (context) => const AdminLoginScreen(),
            BottomPage.id: (context) => const BottomPage(),
          }),
    );
  }
}

