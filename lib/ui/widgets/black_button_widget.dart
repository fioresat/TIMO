import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/colors.dart';

class BlackButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;
  final double width;
  final double height;
  final BorderRadiusGeometry? borderRadius;

  const BlackButtonWidget(
      {required this.child,
      required this.onPressed,
      required this.width,
      super.key,
      required this.borderRadius, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration:  BoxDecoration(
        color: textColor,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
