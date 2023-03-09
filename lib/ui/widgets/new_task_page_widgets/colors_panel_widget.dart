import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/ui/widgets/panel_close_widget.dart';

import '../colors_widget.dart';
import '../lists_widget.dart';

class ColorsPanelWidget extends StatefulWidget {
  final double height;
  final double width;
  final void Function() onTapClose;
  final List<ListModel> lists;
  final List<Color> colors;
  final void Function() onAddNewListPressed;
  int selectedIndex;

  ColorsPanelWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.onTapClose,
    required this.lists,
    required this.colors,
    required this.onAddNewListPressed,
    this.selectedIndex = -1,
  }) : super(key: key);

  @override
  State<ColorsPanelWidget> createState() => _ColorsPanelWidgetState();
}

class _ColorsPanelWidgetState extends State<ColorsPanelWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: backgroundColor,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: widget.width * 0.05,
          right: widget.width * 0.05,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: widget.height * 0.002,
              ),
              child: PanelCloseWidget(
                alignment: Alignment.topRight,
                onTapClose: widget.onTapClose,
                image: AppIcons.closeButton,
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
              height: 0.01 * widget.height,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: ColorsWidget(
                selectedTaskColorIndex: widget.selectedIndex,
                width: widget.width,
              ),
            ),
            SizedBox(
              height: 0.04 * widget.height,
            ),
            ListsWidget(
              height: widget.height,
              lists: widget.lists,
              onAddNewListPressed: widget.onAddNewListPressed,
            ),
            const SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}
