import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/firebase_services.dart';
import '../../services/share_preff.dart';
import '../../utils/style.dart';
import '../../widgets/ecobutton.dart';
import '../../widgets/ecotextfield.dart';
import 'saller_login.dart';

class SallerSignup extends StatefulWidget {
  @override
  State<SallerSignup> createState() => _SallerSignupState();
}

class _SallerSignupState extends State<SallerSignup> {
  FirebaseAuth auth = FirebaseAuth.instance;
  // const SallerSignup({Key? key}) : super(key: key);
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController retypepasswordC = TextEditingController();
  TextEditingController salerAddressC = TextEditingController();
  TextEditingController salerbussinessnamec = TextEditingController();
  TextEditingController phoneNumberC = TextEditingController();
  FocusNode? passwordfocus;
  FocusNode? retypepasswordfocus;
  final formkey = GlobalKey<FormState>();

  bool ispassword = true;
  bool isretypepassword = true;
  bool formStateLoading = false;
  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
    retypepasswordC.dispose();
    super.dispose();
  }

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
      if (passwordC.text == retypepasswordC.text) {
        String? accountstatus = await FirebaseServices.createAccountSallerPanel(
                emailC.text, passwordC.text)
            .whenComplete(() {
          FirebaseFirestore.instance.collection("user").doc().set({
            "name": nameC.text,
            "email": emailC.text,
            "password": passwordC.text,
            "salerAddress": salerAddressC.text,
            // "Businnessname": salerbussinessnamec.text,
            "phonenumber": phoneNumberC.text,
            'sellerId': FirebaseAuth.instance.currentUser!.uid,
          });
        });

        // FirebaseFirestore.instance.collection('checkout').doc().set({
        //   "name": nameC.text,
        //   "address": salerAddressC.text,
        // });
        MyPrefferenc.saveEmail(emailC.text);

        if (accountstatus != null) {
          ecoDialogue(accountstatus);
          setState(() {
            formStateLoading = false;
          });
        } else {
          Navigator.pop(context);
        }

        Navigator.push(
            context, MaterialPageRoute(builder: (_) => SallerLoginScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 40),
                const Text(
                  "SIGNUP AS SELLER",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color.fromARGB(255, 247, 169, 60),
                  ),
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
                SizedBox(height: 20),
                Column(
                  children: [
                    SingleChildScrollView(
                      child: Form(
                          key: formkey,
                          child: Column(
                            children: [
                              EcoTextField(
                                check: true,
                                validate: (v) {
                                  if (v!.isEmpty) {
                                    return "name is badly formated";
                                  }
                                  return null;
                                },
                                inputAction: TextInputAction.next,
                                isPassword: false,
                                controller: nameC,
                                
                                hinttext: "Name...",
                                icons: const Icon(Icons.person,color: Color.fromARGB(255, 247, 169, 60),),
                              ),
                              EcoTextField(
                                check: true,
                                validate: (v) {
                                  if (v!.isEmpty) {
                                    return "email is badly formated";
                                  }
                                  return null;
                                },
                                inputAction: TextInputAction.next,
                                controller: emailC,
                                hinttext: "Email...",
                                icons: const Icon(Icons.email,color: Color.fromARGB(255, 247, 169, 60),),
                              ),
                              EcoTextField(
                                maxlines: 1,
                                validate: (v) {
                                  if (v!.isEmpty) {
                                    return "password should not be empty";
                                  }
                                  return null;
                                },
                                focusNode: passwordfocus,
                                inputAction: TextInputAction.next,
                                isPassword: ispassword,
                                controller: passwordC,
                                hinttext: "Password...",
                                icons: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      ispassword = !ispassword;
                                    });
                                  },
                                  icon: ispassword
                                      ? const Icon(Icons.visibility,color: Color.fromARGB(255, 247, 169, 60),)
                                      : const Icon(Icons.visibility_off,color: Color.fromARGB(255, 247, 169, 60),),
                                ),
                              ),
                              EcoTextField(
                                maxlines: 1,
                                isPassword: isretypepassword,
                                controller: retypepasswordC,
                                validate: (v) {
                                  if (v!.isEmpty) {
                                    return "password should not be empty";
                                  }
                                  return null;
                                },
                                hinttext: "Retype Password...",
                                icons: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isretypepassword = !isretypepassword;
                                    });
                                  },
                                  icon: isretypepassword
                                      ? const Icon(Icons.visibility,color: Color.fromARGB(255, 247, 169, 60),)
                                      : const Icon(Icons.visibility_off,color: Color.fromARGB(255, 247, 169, 60),),
                                ),
                              ),
                              EcoTextField(
                                controller: salerAddressC,
                                validate: (v) {
                                  if (v!.isEmpty) {
                                    return "saler Address";
                                  }
                                  return null;
                                },
                                hinttext: "saler Address...",
                                icons: IconButton(
                                    onPressed: () {
                                      setState(() {});
                                    },
                                    icon: isretypepassword
                                        ? const Icon(Icons.home,color: Color.fromARGB(255, 247, 169, 60),)
                                        : const Icon(Icons.home,color: Color.fromARGB(255, 247, 169, 60),)
                                    // : const Icon(Icons.visibility_off),
                                    ),
                              ),
                              // EcoTextField(
                              //   isPassowrd: isretypepassword,
                              //   controller: salerbussinessnamec,
                              //   validate: (v) {
                              //     if (v!.isEmpty) {
                              //       return "saler bussiness..";
                              //     }
                              //     return null;
                              //   },
                              //   hinttext: "saler bussiness..",
                              //   icons: IconButton(
                              //     onPressed: () {
                              //       setState(() {});
                              //     },
                              //     icon: isretypepassword
                              //         ? const Icon(Icons.business)
                              //         : const Icon(Icons.business),
                              //   ),
                              // ),

                              EcoTextField(
                                controller: phoneNumberC,
                                validate: (v) {
                                  if (v!.isEmpty) {
                                    return "Phone Number";
                                  }
                                  return null;
                                },
                                hinttext: "Phone Number...",
                                icons: IconButton(
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  icon: isretypepassword
                                      ? const Icon(Icons.phone,color: Color.fromARGB(255, 247, 169, 60),)
                                      : const Icon(Icons.phone,color: Color.fromARGB(255, 247, 169, 60),),
                                ),
                              ),
                              EcoButton(
                                title: "SIGNUP",
                                isLoginButton: true,
                                onpress: () {
                                  submit();
                                },
                                isLoading: formStateLoading,
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
                // const SizedBox(height: 50),
                EcoButton(
                  title: "BACK TO LOGIN",
                  onpress: () {
                    Navigator.pop(context);
                  },
                  isLoginButton: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
