import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';

class PanelCloseWidget extends StatelessWidget {
  final void Function() onTapClose;
  final String image;

  const PanelCloseWidget({
    Key? key,
    required this.onTapClose,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.topRight,
      child: ExpandTapWidget(
        onTap: onTapClose,
        tapPadding: const EdgeInsets.all(50.0),
        child: Padding(
          padding: EdgeInsets.only(top: 0.02 * heightScreen),
          child: Image.asset(image, scale: 3),
        ),
      ),
    );
  }
}
