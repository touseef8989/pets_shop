import 'dart:io';

import 'package:pets_shop/screens/bottom_screens/home_screen.dart';
import 'package:pets_shop/utils/style.dart';
import 'package:pets_shop/widgets/ecobutton.dart';
import 'package:pets_shop/widgets/ecotextfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

import '../../models/productmodel.dart';

class UpdateCompleteScreen extends StatefulWidget {
  String? id;
  Products? products;
  UpdateCompleteScreen({Key? key, this.id, this.products}) : super(key: key);

  @override
  State<UpdateCompleteScreen> createState() => _UpdateCompleteScreenState();
}

class _UpdateCompleteScreenState extends State<UpdateCompleteScreen> {
  TextEditingController catagoryC = TextEditingController();
  TextEditingController productNameC = TextEditingController();
  TextEditingController idC = TextEditingController();
  TextEditingController detailC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  // TextEditingController discountpriceC = TextEditingController();
  // TextEditingController serialCodeC = TextEditingController();
  // TextEditingController brandC = TextEditingController();

  bool isOnSale = false;
  bool isPopular = false;
  bool isFavourit = false;
  String? selectedValue;
  bool isSaving = false;
  bool isupLoading = false;
  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List<dynamic> imageurls = [];
  var uuid = const Uuid();
  @override
  void initState() {
    selectedValue = widget.products!.catagory!;
    productNameC.text = widget.products!.productName!;
    detailC.text = widget.products!.detail!;
    priceC.text = widget.products!.price!.toString();
    // discountpriceC.text = widget.products!.discountprice!.toString();
    // serialCodeC.text = widget.products!.serialCode!;
    // brandC.text = widget.products!.brand!;
    isOnSale = widget.products!.isOnSale!;
    isPopular = widget.products!.isPopular!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "UPDATE PRODUCT",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              child: Column(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.5)),
                    child: DropdownButtonFormField(
                        hint: const Text("Choose Product..."),
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
                            selectedValue = value.toString();
                          });
                        }),
                  ),
                  EcoTextField(
                    controller: productNameC,
                    hinttext: "Enter the product name...",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    controller: detailC,
                    hinttext: "Enter the product details...",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    controller: priceC,
                    hinttext: "Enter the product price...",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.h),
                    child: Container(
                      height: 25.h,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10)),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemCount: widget.products!.imageUrls!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  child: Image.network(
                                    widget.products!.imageUrls![index],
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.products!.imageUrls!
                                          .removeAt(index);
                                    });
                                  },
                                  icon: const Icon(Icons.cancel_outlined))
                            ],
                          );
                        },
                      ),
                    ),
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
                  //   isLoading: isupLoading,
                  //   onpress: () {
                  //     uploadImage();
                  //   },
                  // ),
                  Container(
                    height: 45.h,
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
                      value: isOnSale,
                      onChanged: (v) {
                        setState(() {
                          isOnSale = !isOnSale;
                        });
                      }),
                  SwitchListTile(
                      title: const Text("Is this product popular"),
                      value: isPopular,
                      onChanged: (v) {
                        setState(() {
                          isPopular = !isPopular;
                        });
                      }),
                  EcoButton(
                    title: "Updates",
                    isLoading: isSaving,
                    isLoginButton: true,
                    onpress: () {
                      save();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  save() async {
    setState(() {
      isSaving = true;
    });
    await uploadImage();
    await Products.updateProducts(
            widget.id!,
            Products(
                catagory: selectedValue,
                id: widget.id,
                productName: productNameC.text,
                detail: detailC.text,
                price: int.parse(priceC.text),
                // discountPrice: int.parse(discountpriceC.text),
                // serialCode: serialCodeC.text,
                // brand: brandC.text,
                imageUrls: imageurls,
                isOnSale: isOnSale,
                isPopular: isPopular,
                isFavourit: isFavourit))
        .whenComplete(() {
      setState(() {
        isSaving = false;
        // imageurls.clear();
        // images.clear();
        // clearField();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("SuccesFully Updated")));
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
      // selectedValue = "";
      productNameC.clear();
      //detailC.clear();
      // priceC.clear();
      // discountpriceC.clear();
      // serialCodeC.clear();
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
    if (kIsWeb) {
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
  }

  uploadImage() async {
    for (var image in images) {
      await postImage(image)
          .then((downLoadUrls) => imageurls.add(downLoadUrls));
    }
    imageurls.addAll(widget.products!.imageUrls!);
  }
}
