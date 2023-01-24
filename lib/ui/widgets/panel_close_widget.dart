import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';

class PanelCloseWidget extends StatelessWidget {
  final void Function() onTapClose;
  final double height;

  const PanelCloseWidget({Key? key, required this.onTapClose, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: InkWell(
        onTap: onTapClose,
        child: Padding(
          padding: EdgeInsets.only(top: 0.02 * height),
          child: Image.asset(AppIcons.closeButton, scale: 3),
        ),
      ),
    );
  }
}
