import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/ui/widgets/panel_close_widget.dart';

import '../colors_widget.dart';
import '../lists_widget.dart';

class ColorsPanelWidget extends StatefulWidget {
  final double height;
  final double width;
  final void Function() onTapClose;
  final List<String> lists;
  final List<Color> colors;
  final void Function() onAddNewListPressed;

  const ColorsPanelWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.onTapClose,
    required this.lists,
    required this.colors,
    required this.onAddNewListPressed,
  }) : super(key: key);

  @override
  State<ColorsPanelWidget> createState() => _ColorsPanelWidgetState();
}

class _ColorsPanelWidgetState extends State<ColorsPanelWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: widget.width * 0.04, right: widget.width * 0.04),
      child: Column(
        children: [
          PanelCloseWidget(
            alignment: Alignment.topRight,
            onTapClose: widget.onTapClose,
            image: AppIcons.closeButton,
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
            height: 0.01 * widget.height,
          ),
          ColorsWidget(
            width: widget.width,
          ),
          SizedBox(
            height: 0.03 * widget.height,
          ),
          ListsWidget(
            height: widget.height,
            lists: widget.lists,
            onAddNewListPressed: widget.onAddNewListPressed,
          ),
        ],
      ),
    );
  }
}
