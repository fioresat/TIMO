import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:todo_app_main_screen/ui/widgets/panel_close_widget.dart';
import 'black_button_widget.dart';
import 'lists_widget.dart';

class ListsPanelWidget extends StatefulWidget {
  final List<Widget> lists;
  final double height;
  final double width;
  final void Function() onTapClose;
  final void Function() onAddNewListPressed;

  const ListsPanelWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.lists,
    required this.onTapClose,
    required this.onAddNewListPressed,
  }) : super(key: key);

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
          PanelCloseWidget(
            onTapClose: widget.onTapClose,
            height: widget.height,
          ),
          ListsWidget(
            height: widget.height,
            lists: widget.lists,
            onAddNewListPressed: widget.onAddNewListPressed,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: BlackButtonWidget(
              onPressed: () {},
              width: widget.width - 50,
              borderRadius: const BorderRadius.all(
                Radius.elliptical(12, 12),
              ),
              child: const Text(
                TestStrings.move,
                style: TextStyle(color: backgroundColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
