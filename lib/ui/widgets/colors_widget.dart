import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/ui/widgets/single_color_widget.dart';

class ColorsWidget extends StatefulWidget {
  final void Function() onColorTap;
  final void Function() onColorSecTap;
  final AlignmentGeometry alignment;
  final List<Widget> colors;
  final double width;

  const ColorsWidget(
      {Key? key,
      required this.onColorTap,
      required this.alignment,
      required this.onColorSecTap,
      required this.width,
      required this.colors})
      : super(key: key);

  @override
  State<ColorsWidget> createState() => _ColorsWidgetState();
}

class _ColorsWidgetState extends State<ColorsWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: EdgeInsets.only(right: widget.width * 0.15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleColorWidget(
              color: lightBlueColor,
              onColorTap: widget.onColorTap,
              alignment: widget.alignment,
              onColorSecTap: widget.onColorSecTap,
            ),
            SingleColorWidget(
              color: yellowColor,
              onColorTap: widget.onColorTap,
              alignment: widget.alignment,
              onColorSecTap: widget.onColorSecTap,
            ),
            SingleColorWidget(
              color: blueColor,
              onColorTap: widget.onColorTap,
              alignment: widget.alignment,
              onColorSecTap: widget.onColorSecTap,
            ),
            SingleColorWidget(
              color: greenColor,
              onColorTap: widget.onColorTap,
              alignment: widget.alignment,
              onColorSecTap: widget.onColorSecTap,
            ),
            SingleColorWidget(
              color: purpleColor,
              onColorTap: widget.onColorTap,
              alignment: widget.alignment,
              onColorSecTap: widget.onColorSecTap,
            ),
            SingleColorWidget(
              color: redColor,
              onColorTap: widget.onColorTap,
              alignment: widget.alignment,
              onColorSecTap: widget.onColorSecTap,
            ),
            SingleColorWidget(
              color: orangeColor,
              onColorTap: widget.onColorTap,
              alignment: widget.alignment,
              onColorSecTap: widget.onColorSecTap,
            ),
            SingleColorWidget(
              color: pinkColor,
              onColorTap: widget.onColorTap,
              alignment: widget.alignment,
              onColorSecTap: widget.onColorSecTap,
            ),
          ],
        ),
      ),
    );
  }
}
