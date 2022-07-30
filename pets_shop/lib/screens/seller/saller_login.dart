import 'package:pets_shop/screens/bottom_screens/home_screen.dart';
import 'package:pets_shop/screens/seller/seller_home_screen.dart';
import 'package:pets_shop/utils/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/firebase_services.dart';
import '../../services/share_preff.dart';
import '../../widgets/ecobutton.dart';
import '../../widgets/ecotextfield.dart';
import 'saller_signup.dart';

class SallerLoginScreen extends StatefulWidget {
  static const String id = "SallerLoginScreen";

  const SallerLoginScreen({Key? key}) : super(key: key);
  @override
  State<SallerLoginScreen> createState() => _SallerLoginScreenState();
}

class _SallerLoginScreenState extends State<SallerLoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  Future<void> ecoDialogue(String error) async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(error),
            actions: [
              EcoButton(
                title: 'CLOSE',
                onpress: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  submit() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        formStateLoading = true;
      });
      String? accountstatus = await FirebaseServices.signInAccountSallerLogin(
          emailC.text, passwordC.text);
      //print(accountstatus);
      if (accountstatus != null) {
        ecoDialogue(accountstatus);
        setState(() {
          formStateLoading = false;
        });
      } else {
        MyPrefferenc.saveEmail(emailC.text);

        Navigator.push(
            context, MaterialPageRoute(builder: (_) => SallerHomeScreen()));
      }
    }
  }

  final formkey = GlobalKey<FormState>();
  bool formStateLoading = false;
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
                child: const Text(
                  "Saller Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color.fromARGB(255, 247, 169, 60),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 130.0,
                height: 130.0,
                decoration: new BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Color.fromARGB(255, 250, 201, 131),
                      width: 10.0,
                      style: BorderStyle.solid),
                  image: new DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSj31mBmDAhdYsuiQvb9FUSTaX4mLJ2hFonOA&usqp=CAU"),
                  ),
                ),
              ),
              Column(
                children: [
                  Form(
                    key: formkey,
                    child: Column(
                      children: [
                        EcoTextField(
                            controller: emailC,
                            icons: Icon(
                              Icons.mail,
                              color: Color.fromARGB(255, 247, 169, 60),
                            ),
                            hinttext: "Email...",
                            validate: (v) {
                              if (v!.isEmpty) {
                                return "email is badly formated";
                              }
                              return null;
                              // },
                            }),
                        EcoTextField(
                          isPassword: true,
                          controller: passwordC,
                          icons: Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 247, 169, 60),
                          ),
                          maxlines: 1,
                          hinttext: "Password...",
                          validate: (v) {
                            if (v!.isEmpty) {
                              return "email is badly formated";
                            }
                            return null;
                          },
                        ),
                        EcoButton(
                          title: "LOGIN",
                          isLoading: formStateLoading,
                          isLoginButton: true,
                          onpress: () {
                            submit();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              EcoButton(
                title: "CREATE NEW ACCOUNT",
                onpress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SallerSignup(),
                    ),
                  );
                },
                isLoginButton: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
