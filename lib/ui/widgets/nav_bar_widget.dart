import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/consts/strings.dart';

class NavBarWidget extends StatelessWidget {
  final double height;
  final double width;
  final void Function() onPressed;
  final Color titleColor;
  final Color buttonColor;

  const NavBarWidget({
    Key? key,
    required this.height,
    required this.onPressed, required this.width, required this.titleColor, required this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.01 * height,),
        child: InkWell(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              color: buttonColor,
              border: Border.all(
                color: darkColor,
                width: 2.0,
                style: BorderStyle.solid,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 0.004 * height,
                horizontal:  0.033 * width,
              ),
              child: Text(
                TestStrings.lists,
                style: TextStyle(color: titleColor, fontSize: 14),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
