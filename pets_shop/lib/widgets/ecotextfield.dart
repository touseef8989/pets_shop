import 'package:flutter/material.dart';

class EcoTextField extends StatelessWidget {
  String? hinttext;
  TextEditingController? controller;
  String? Function(String?)? validate;
  int? maxlines;
  bool isPassword;
  bool check;
  Widget? icons;
  bool? enable;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;
  EcoTextField({
    this.hinttext,
    this.controller,
    this.enable = true,
    this.validate,
    this.maxlines,
    this.isPassword = false,
    this.check = false,
    this.icons,
    this.inputAction,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.5)),
      child: TextFormField(
        enabled: enable == true ? true : enable,
        maxLines: maxlines == null ? 1 : maxlines,
        focusNode: focusNode,
        textInputAction: inputAction,
        controller: controller,
        validator: validate,
        obscureText: isPassword == false ? false : isPassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: hinttext ?? "Hint text......",
          suffixIcon: icons,
          contentPadding: EdgeInsets.all(10),
        ),
      ),
    );
  }
}
