import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/colors.dart';

class BlackButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;
  final double width;

  const BlackButtonWidget(
      {required this.child,
      required this.onPressed,
      required this.width,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: const BoxDecoration(
        color: textColor,
        borderRadius: BorderRadius.all(Radius.elliptical(12, 12)),
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
