import 'dart:io';
import 'package:pets_shop/models/admin_images_model.dart';
import 'package:pets_shop/utils/style.dart';
import 'package:pets_shop/widgets/ecobutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/firebase_services.dart';

class AdminUploadImage extends StatefulWidget {
  static const String id = "saleraddproduct";
  const AdminUploadImage({Key? key}) : super(key: key);

  @override
  State<AdminUploadImage> createState() => _AdminUploadImageState();
}

class _AdminUploadImageState extends State<AdminUploadImage> {
  User? auth = FirebaseAuth.instance.currentUser;

  String? selectedvalue;
  bool isSaving = false;
  bool isupLoading = false;
  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List<String> imageurls = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 71, 207, 241),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseServices.signOut();
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "ADD SLIDER IMAGES",
                    style: EcoStyle.boldstyle,
                  ),
                ),
                EcoButton(
                  title: 'Pick Image',
                  isLoginButton: true,
                  onpress: () {
                    pickImage();
                  },
                ),
                EcoButton(
                  title: "upload image",
                  isLoginButton: true,
                  // isLoading: isupLoading,
                  onpress: () {
                    uploadImage();
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
    await adminImages
        .addProducts(adminImages(
      imageUrls: imageurls,
    ))
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
  }

  clearField() {
    setState(() {});
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
