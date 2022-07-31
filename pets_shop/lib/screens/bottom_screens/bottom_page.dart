import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:pets_shop/screens/bottom_screens/cart_screen.dart';
import 'package:pets_shop/screens/bottom_screens/favorite_screen.dart';
import 'package:pets_shop/screens/bottom_screens/home_screen.dart';
import 'package:pets_shop/screens/bottom_screens/delivery_Screen.dart';
import 'package:pets_shop/screens/bottom_screens/product_screen.dart';
import 'package:pets_shop/screens/bottom_screens/profile_screen.dart';
import 'package:pets_shop/utils/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BottomPage extends StatefulWidget {
  static const String id = "bottompage";

  const BottomPage({Key? key}) : super(key: key);

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int length = 0;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  void cartItemLength() {
    FirebaseFirestore.instance
        .collection("cart")
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snap) {
      if (snap.docs.isNotEmpty) {
        setState(() {
          length = snap.docs.length;
        });
      } else {
        length = 0;
      }
    });
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return HomeScreen();
      case 1:
        return ProductScreen();
      case 2:
        return CartScreen();
      case 3:
        return FavouriteScreen();
      case 4:
        return ProfileScreen();
      case 5:
        return DeliveryPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    cartItemLength();
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60,
        items: <Widget>[
          Icon(Icons.home, size: 20.sp, color: Colors.white),
          Icon(Icons.shop, size: 20.sp, color: Colors.white),
          Stack(
            children: [
              Icon(Icons.add_shopping_cart, size: 20.sp, color: Colors.white),
              Positioned(
                  top: 1,
                  right: 1,
                  child: length == 0
                      ? Container()
                      : Stack(
                          children: [
                            const Icon(
                              Icons.brightness_1,
                              size: 20,
                             color: Color.fromARGB(255, 247, 169, 60),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "$length",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ))
            ],
          ),

          Icon(Icons.favorite_rounded, size: 20.sp, color: Colors.white),
          Icon(Icons.person, size: 20.sp, color: Colors.white),
          Icon(Icons.delivery_dining, size: 20.sp, color: Colors.white),

          // Icon(Icons.perm_identity, size: 30),
        ],
        color: AppColors.LIGHT_BLACK,
        buttonBackgroundColor: Color.fromARGB(255, 241, 170, 71),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 500),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: _getPage(_page),
        ),
      ),
    );
    // return CupertinoTabScaffold(
    //     tabBar: CupertinoTabBar(items: [
    //       const BottomNavigationBarItem(icon: Icon(Icons.home)),
    //       const BottomNavigationBarItem(icon: Icon(Icons.shop)),
    //       BottomNavigationBarItem(
    //         icon:
    //         Stack(
    //           children: [
    //             const Icon(Icons.add_shopping_cart),
    //             Positioned(
    //                 top: 1,
    //                 right: 1,
    //                 child: length == 0
    //                     ? Container()
    //                     : Stack(
    //                         children: [
    //                           const Icon(
    //                             Icons.brightness_1,
    //                             size: 20,
    //                             color: Colors.green,
    //                           ),
    //                           Positioned.fill(
    //                             child: Align(
    //                               alignment: Alignment.center,
    //                               child: Text(
    //                                 "$length",
    //                                 style: const TextStyle(
    //                                   color: Colors.white,
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                         ],
    //                       ))
    //           ],
    //         ),

    //       ),
    //       const BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded)),
    //       const BottomNavigationBarItem(icon: Icon(Icons.person)),
    //       const BottomNavigationBarItem(icon: Icon(Icons.delivery_dining)),
    //     ]),
    //     tabBuilder: (context, index) {
    //       switch (index) {
    //         case 0:
    //           return CupertinoTabView(builder: ((context) {
    //             return CupertinoPageScaffold(child: HomeScreen());
    //           }));

    //         case 1:
    //           return CupertinoTabView(builder: ((context) {
    //             return CupertinoPageScaffold(child: ProductScreen());
    //           }));

    //         case 2:
    //           return CupertinoTabView(builder: ((context) {
    //             return CupertinoPageScaffold(child: CartScreen());
    //           }));

    //         case 3:
    //           return CupertinoTabView(builder: ((context) {
    //             return CupertinoPageScaffold(child: FavouriteScreen());
    //           }));

    //         case 4:
    //           return CupertinoTabView(
    //             builder: ((context) {
    //               return const CupertinoPageScaffold(child: ProfileScreen());
    //             }),
    //           );
    //         case 5:
    //           return CupertinoTabView(builder: (context) {
    //             return CupertinoPageScaffold(child: DeliveryPage());
    //           });

    //         default:
    //       }
    //       return HomeScreen();
    //     });
  }
}
