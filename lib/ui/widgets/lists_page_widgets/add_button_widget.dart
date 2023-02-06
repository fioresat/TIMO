import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';

class AddButtonWidget extends StatelessWidget {
  final Function() onAddButtonTap;
  final double width;
  final double height;

  const AddButtonWidget({
    Key? key,
    required this.onAddButtonTap,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onAddButtonTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height * 0.20,
            width: width * 0.35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              border: Border.all(
                color: lightBorderColor,
                width: 2,
              ),
            ),
            child: Image.asset(
              AppIcons.plus,
              scale: 2.5,
            ),
          ),
          Container(),
        ],
      ),
    );
  }
}
