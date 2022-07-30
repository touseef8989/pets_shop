import 'dart:io';
import 'package:pets_shop/screens/bottom_screens/home_screen.dart';
import 'package:pets_shop/widgets/ecobutton.dart';
import 'package:pets_shop/widgets/ecotextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../models/productmodel.dart';

class SallerAddProduct extends StatefulWidget {
  static const String id = "saleraddproduct";
  const SallerAddProduct({Key? key}) : super(key: key);

  @override
  State<SallerAddProduct> createState() => _SallerAddProductState();
}

class _SallerAddProductState extends State<SallerAddProduct> {
  User? auth = FirebaseAuth.instance.currentUser;
  TextEditingController catagoryc = TextEditingController();
  TextEditingController productnamec = TextEditingController();
  TextEditingController idc = TextEditingController();
  TextEditingController detailc = TextEditingController();
  TextEditingController pricec = TextEditingController();
  // TextEditingController discountpricec = TextEditingController();
  TextEditingController serailpricec = TextEditingController();

  bool onSale = false;
  bool Popular = false;
  bool Favourit = false;
  String? selectedvalue;
  bool isSaving = false;
  bool isupLoading = false;
  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List<String> imageurls = [];
  var uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 247, 169, 60),
          title: Text(
            "ADD PRODUCT",
          ),
          // backgroundColor: Color.fromARGB(255, 71, 207, 241),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         FirebaseServices.signOut();
          //       },
          //       icon: const Icon(Icons.logout)),
          // ],
        ),
        body: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  // const Padding(
                  //   padding: EdgeInsets.all(20.0),
                  //   child: Text(
                  //     "ADD PRODUCT",
                  //     style: EcoStyle.boldstyle,
                  //   ),
                  // ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.5)),
                    child: DropdownButtonFormField(
                        hint: const Text("Choose Category..."),
                         icon: const Icon(
                      Icons.category,
                      color: Color.fromARGB(255, 247, 169, 60),
                    ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return "CataGory must be select";
                          }
                          return null;
                        },
                        items: catagories
                            .map((e) => DropdownMenuItem<String>(
                                value: e, child: Text(e)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedvalue = value.toString();
                          });
                        }),
                  ),
                  EcoTextField(
                    controller: productnamec,
                    icons: const Icon(
                      Icons.production_quantity_limits,
                      color: Color.fromARGB(255, 247, 169, 60),
                    ),
                    hinttext: "Enter the product name...",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    controller: detailc,
                     icons: const Icon(
                      Icons.note_add,
                      color: Color.fromARGB(255, 247, 169, 60),
                    ),
                    hinttext: "Enter the product details...",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    controller: pricec,
                     icons: const Icon(
                      Icons.price_change,
                      color: Color.fromARGB(255, 247, 169, 60),
                    ),
                    hinttext: "Enter the product price...",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoButton(
                    title: 'Pick Image',
                    isLoginButton: true,
                    onpress: () {
                      pickImage();
                    },
                  ),
                  // EcoButton(
                  //   title: "upload image",
                  //   isLoginButton: true,
                  //   // isLoading: isupLoading,
                  //   onpress: () {
                  //     uploadImage();
                  //   },
                  // ),
                  Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: images.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: Image.file(
                                File(images[index].path),
                                // height: 400,
                                // width: 400,
                                // fit: BoxFit.cover,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    images.removeAt(index);
                                  });
                                },
                                icon: const Icon(Icons.cancel_outlined))
                          ],
                        );
                      },
                    ),
                  ),

                  SwitchListTile(
                      title: const Text("Is this product on sale"),
                      value: onSale,
                      onChanged: (v) {
                        setState(() {
                          onSale = !onSale;
                        });
                      }),
                  SwitchListTile(
                      title: const Text("Is this product popular"),
                      value: Popular,
                      onChanged: (v) {
                        setState(() {
                          Popular = !Popular;
                        });
                      }),
                  EcoButton(
                    title: "Save",
                    isLoading: isSaving,
                    isLoginButton: true,
                    onpress: () {
                      save();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  save() async {
    setState(() {
      isSaving = true;
    });
    await uploadImage();
    await Products.addProducts(Products(
            catagory: selectedvalue,
            id: uuid.v4(),
            sellerId: FirebaseAuth.instance.currentUser!.uid,
            // id: FirebaseAuth.instance.currentUser!.uid,
            productName: productnamec.text,
            detail: detailc.text,
            price: int.parse(pricec.text),
            // discountPrice: int.parse(discountpricec.text),
            imageUrls: imageurls,
            isOnSale: onSale,
            isPopular: Popular,
            isFavourit: Favourit))
        .whenComplete(() {
      setState(() {
        isSaving = false;
        imageurls.clear();
        images.clear();
        clearField();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("SuccesFully Added")));
      });
    });
    // await FirebaseFirestore.instance
    //     .collection("products")
    //     .add({"images": imageurls}).whenComplete(() {
    //   setState(() {
    //     isSaving = false;
    //     images.clear();
    //     imageurls.clear();
    //   });
    // });
  }

  clearField() {
    setState(() {
      // ectedValue = "";
      productnamec.clear();
      // detailC.clear();
      // priceC.clear();
      // discountpriceC.clear();
      // serialCodeC.clear();
      // brandC.clear();
      // isOnSale = false;
      // isFavourit = false;
      // isPopular = false;
    });
  }

  pickImage() async {
    final List<XFile>? pickImage = await imagePicker.pickMultiImage();
    if (pickImage != null) {
      setState(() {
        images.addAll(pickImage);
      });
    } else {
      print("no image found");
    }
  }

  Future postImage(XFile? imageFile) async {
    setState(() {
      isupLoading = true;
    });
    String urls;
    Reference ref = FirebaseStorage.instance.ref().child(imageFile!.name);

    await ref.putData(
      await imageFile.readAsBytes(),
      SettableMetadata(contentType: "image/jpeg"),
    );
    urls = await ref.getDownloadURL();
    setState(() {
      isupLoading = false;
    });
    return urls;
  }

  uploadImage() async {
    for (var image in images) {
      await postImage(image)
          .then((downLoadUrls) => imageurls.add(downLoadUrls));
    }
  }
}
