import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';

import 'colors_widget.dart';
import 'lists_widget.dart';

class ColorsPanelWidget extends StatefulWidget {
  final double height;
  final double width;
  final void Function() onTap;
  final void Function() onColorTap;
  final void Function() onColorSecTap;
  final List<Widget> lists;
  final AlignmentGeometry alignment;

  const ColorsPanelWidget(
      {Key? key,
      required this.height,
      required this.width,
      required this.onTap,
      required this.lists, required this.onColorTap, required this.alignment, required this.onColorSecTap})
      : super(key: key);

  @override
  State<ColorsPanelWidget> createState() => _ColorsPanelWidgetState();
}

class _ColorsPanelWidgetState extends State<ColorsPanelWidget> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: widget.width * 0.04, right: widget.width * 0.04),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: widget.onTap,
              child: Padding(
                padding: EdgeInsets.only(top: 0.02 * widget.height),
                child: Image.asset(AppIcons.closeButton, scale: 3),
              ),
            ),
          ),
          SizedBox(
            height: 0.01 * widget.height,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Color',
              style: TextStyle(
                fontSize: 0.03 * widget.height,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 0.03 * widget.height,
          ),
          ColorsWidget(
            onColorTap: widget.onColorTap,
           alignment: widget.alignment, onColorSecTap: widget.onColorSecTap, width: widget.width,
          ),
          SizedBox(
            height: 0.01 * widget.height,
          ),
          ListsWidget(height: widget.height, lists: widget.lists)
        ],
      ),
    );
  }
}
