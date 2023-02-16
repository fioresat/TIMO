import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:todo_app_main_screen/ui/widgets/panel_close_widget.dart';
import 'black_button_widget.dart';
import 'lists_widget.dart';

class ListsPanelWidget extends StatefulWidget {
  final List<String> lists;
  final double height;
  final double width;
  final void Function() onTapClose;
  final void Function() onAddNewListPressed;
  final void Function() onButtonPressed;

  const ListsPanelWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.lists,
    required this.onTapClose,
    required this.onAddNewListPressed,
    required this.onButtonPressed,
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
            image: AppIcons.closeButton,
          ),
          ListsWidget(
            height: widget.height,
            lists: widget.lists,
            onAddNewListPressed: widget.onAddNewListPressed,
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 0.04 * widget.height,
            ),
            child: BlackButtonWidget(
              onPressed: widget.onButtonPressed,
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
