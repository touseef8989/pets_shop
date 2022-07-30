import 'package:pets_shop/screens/Admin/admin_home_screen.dart';
import 'package:pets_shop/utils/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../widgets/ecobutton.dart';
import '../../../widgets/ecotextfield.dart';

class AdminLoginScreen extends StatefulWidget {
  static const String id = "adminlogin";

  const AdminLoginScreen({Key? key}) : super(key: key);
  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  final formkey = GlobalKey<FormState>();
  bool formStateLoading = false;
  final String username = "admin";
  final String Password = "12345";

  submit(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      if (emailC.text == username && passwordC.text == Password) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => AdminHomeScreen()));
      }

      setState(() {
        formStateLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // ignore: sized_box_for_whitespace
        child: Container(
          width: double.infinity,
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: const Text(
                    "Admin Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Color.fromARGB(255, 247, 169, 60),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Image.asset(
              //   "assests/c_images/admin-login.png",
              //   height: 150,
              // ),
              Container(
                width: 130.0,
                height: 130.0,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Color.fromARGB(255, 250, 201, 131),
                      width: 10.0,
                      style: BorderStyle.solid),
                  image: new DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(
                      "https://i0.wp.com/www.codeplastic.com/wp-content/uploads/2017/07/github-mark.png?resize=800%2C500",
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Column(
                children: [
                  Form(
                    key: formkey,
                    child: Column(
                      children: [
                        EcoTextField(
                            icons: Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 247, 169, 60)
                            ),
                            controller: emailC,
                            hinttext: "user name...",
                            validate: (v) {
                              //   if (v!.isEmpty) {
                              //     return "email is badly formated";
                              //   }
                              //   return null;
                              // },
                            }),
                        EcoTextField(
                          icons: Icon(
                            Icons.remove_red_eye,
                            color: Color.fromARGB(255, 247, 169, 60)
                          ),
                          controller: passwordC,
                          hinttext: "Password...",
                          validate: (v) {
                            if (v!.isEmpty) {
                              return "user name should not be empty";
                            }
                            return null;
                          },
                        ),
                        EcoButton(
                          isLoginButton: true,
                          title: "LogIn",
                          isLoading: formStateLoading,
                          onpress: () {
                            submit(context);
                          },
                        ),
                      ],
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
