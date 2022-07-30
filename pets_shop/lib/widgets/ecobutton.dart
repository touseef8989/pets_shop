import 'package:flutter/material.dart';

class EcoButton extends StatelessWidget {
  String? title;
  bool? isLoginButton;
  VoidCallback? onpress;
  final bool? isLoading;
  EcoButton({
    this.title,
    this.isLoginButton = false,
    this.onpress,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        height: 55,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
        decoration: BoxDecoration(
            color: isLoginButton == false
                ? Colors.white
                : Color.fromARGB(255, 241, 170, 71),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isLoginButton == false
                  ? Color.fromARGB(255, 241, 170, 71)
                  : Color.fromARGB(255, 241, 170, 71)
            )),
        child: Center(
          child: Stack(
            children: [
              Visibility(
                visible: isLoading! ? false : true,
                child: Center(
                  child: Text(
                    title ?? "Button",
                    style: TextStyle(
                        color: isLoginButton == false
                            ? Colors.black
                            : Colors.white,
                        fontSize: 16),
                  ),
                ),
              ),
              Visibility(
                visible: isLoading!,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
