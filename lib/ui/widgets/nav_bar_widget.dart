import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/colors.dart';

class NavBarWidget extends StatelessWidget {
  final double height;
  final void Function() onPressed;

  const NavBarWidget({
    Key? key,
    required this.height,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.01 * height),
        child: InkWell(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: darkColor,
                width: 2.0,
                style: BorderStyle.solid,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 10,
              ),
              child: Text(
                'lists',
                style: TextStyle(color: textColor, fontSize: 14),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
