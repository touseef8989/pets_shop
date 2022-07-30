import 'dart:io';
import 'package:pets_shop/models/equipment_model.dart';
import 'package:pets_shop/widgets/ecobutton.dart';
import 'package:pets_shop/widgets/ecotextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';


// import '../../services/firebase_services.dart';

class AddAccessories extends StatefulWidget {
  static const String id = "sellerAddAccessories";
  const AddAccessories({Key? key}) : super(key: key);

  @override
  State<AddAccessories> createState() => _AddAccessoriesState();
}

class _AddAccessoriesState extends State<AddAccessories> {
  User? auth = FirebaseAuth.instance.currentUser;
  TextEditingController equipmentNameC = TextEditingController();
  TextEditingController detailC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  bool isSaving = false;
  bool isupLoading = false;
  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List<String> imageurls = [];
  var uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 247, 169, 60),
        title: Text(
          "ADD ACCESSORIES",
        ),
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              children: [
                EcoTextField(
                  controller: equipmentNameC,
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
                EcoButton(
                  title: 'Pick Image',
                  isLoginButton: true,
                  onpress: () {
                    pickImage();
                  },
                ),
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
    );
  }

  save() async {
    setState(() {
      isSaving = true;
    });
    await uploadImage();
    await Accessories.addProducts(Accessories(
      id: uuid.v4(),
      sellerId: FirebaseAuth.instance.currentUser!.uid,
      accessoriesName: equipmentNameC.text,
      detail: detailC.text,
      price: int.parse(priceC.text),
      imageUrls: imageurls,
    )).whenComplete(() {
      setState(() {
        isSaving = false;
        imageurls.clear();
        images.clear();
        clearField();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Succesfully Added"),
          ),
        );
      });
    });
  }

  clearField() {
    setState(() {
      // ectedValue = "";
      equipmentNameC.clear();
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
