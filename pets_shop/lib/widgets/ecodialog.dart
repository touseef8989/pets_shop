import 'package:pets_shop/widgets/ecobutton.dart';
import 'package:flutter/material.dart';

class EcoDialog extends StatelessWidget {
  final String? title;
  const EcoDialog({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title!),
      actions: [
        EcoButton(
          title: "Close",
          onpress: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
