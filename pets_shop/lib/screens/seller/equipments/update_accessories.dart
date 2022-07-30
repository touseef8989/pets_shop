import 'dart:io';
import 'package:pets_shop/widgets/ecobutton.dart';
import 'package:pets_shop/widgets/ecotextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

import '../../../models/equipment_model.dart';

class UpdateEquipments extends StatefulWidget {
  String? id;
  Accessories? equipment;
  UpdateEquipments({Key? key, this.id, this.equipment}) : super(key: key);

  @override
  State<UpdateEquipments> createState() => _UpdateEquipmentsState();
}

class _UpdateEquipmentsState extends State<UpdateEquipments> {
  User? auth = FirebaseAuth.instance.currentUser;
  // TextEditingController catagoryc = TextEditingController();
  TextEditingController accessoriesNameC = TextEditingController();
  // TextEditingController idc = TextEditingController();
  TextEditingController detailC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  // TextEditingController discountpricec = TextEditingController();
  // TextEditingController serailpricec = TextEditingController();

  // bool onSale = false;
  // bool Popular = false;
  // bool Favourit = false;
  // String? selectedvalue;
  bool isSaving = false;
  bool isupLoading = false;
  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List<dynamic> imageurls = [];
  var uuid = Uuid();
  @override
  void initState() {
    // selectedValue = widget.products!.catagory!;
    accessoriesNameC.text = widget.equipment!.accessoriesName!;
    detailC.text = widget.equipment!.detail!;
    priceC.text = widget.equipment!.price!.toString();
    // discountpriceC.text = widget.products!.discountprice!.toString();
    // serialCodeC.text = widget.products!.serialCode!;
    // brandC.text = widget.products!.brand!;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 247, 169, 60),
          title: const Text(
            "UPDATE ACCESSORIES",
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                child: Column(
                  children: [
                    EcoTextField(
                      controller: accessoriesNameC,
                      hinttext: "Enter the accessories name...",
                      validate: (v) {
                        if (v!.isEmpty) {
                          return "should not be empty";
                        }
                        return null;
                      },
                    ),
                    EcoTextField(
                      controller: detailC,
                      hinttext: "Enter the accessories details...",
                      validate: (v) {
                        if (v!.isEmpty) {
                          return "should not be empty";
                        }
                        return null;
                      },
                    ),
                    EcoTextField(
                      controller: priceC,
                      hinttext: "Enter the accessories price...",
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
                          itemCount: widget.equipment!.imageUrls!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)),
                                    child: Image.network(
                                      widget.equipment!.imageUrls![index],
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.equipment!.imageUrls!
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
      ),
    );
  }

  save() async {
    setState(() {
      isSaving = true;
    });
    await uploadImage();
    await Accessories.updateProducts(
        widget.id!,
        Accessories(
          id: widget.id,
          accessoriesName: accessoriesNameC.text,
          detail: detailC.text,
          price: int.parse(priceC.text),
          // discountPrice: int.parse(discountpriceC.text),
          // serialCode: serialCodeC.text,
          // brand: brandC.text,
          imageUrls: imageurls,
        )).whenComplete(() {
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
      accessoriesNameC.clear();
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
        print(images);
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
    imageurls.addAll(widget.equipment!.imageUrls!);
  }
}
