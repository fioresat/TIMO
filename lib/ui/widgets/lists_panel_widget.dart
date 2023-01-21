import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/consts/strings.dart';
import 'black_button_widget.dart';
import 'lists_widget.dart';

class ListsPanelWidget extends StatefulWidget {
  final List<Widget> lists;
  final double height;
  final double width;
  final void Function() onTap;
  final ScrollController controller;
  final PanelController panelController;

  const ListsPanelWidget(
      {Key? key,
      required this.height,
      required this.width,
      required this.lists,
      required this.onTap,
      required this.controller,
      required this.panelController,})
      : super(key: key);

  @override
  State<ListsPanelWidget> createState() => _ListsPanelWidgetState();
}

class _ListsPanelWidgetState extends State<ListsPanelWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          ListsWidget(
            height: widget.height,
            lists: widget.lists,

          ),
          BlackButtonWidget(
            onPressed: () {},
            width: widget.width - 50,
            borderRadius: BorderRadius.all(Radius.elliptical(12, 12)),
            child: const Text(
              TestStrings.move,
              style: TextStyle(color: backgroundColor),
            ),
          ),
        ],
      ),
    );
  }
}
