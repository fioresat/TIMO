import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:todo_app_main_screen/ui/widgets/black_button_widget.dart';

class MoveToWidget extends StatefulWidget {
  final List<Widget> lists;
  final ScrollController controller;
  final PanelController panelController;
  final double height;
  final double width;
  final void Function() onTap;

  const MoveToWidget({
    Key? key,
    required this.lists,
    required this.controller,
    required this.panelController,
    required this.height,
    required this.onTap,
    required this.width,
  }) : super(key: key);

  @override
  State<MoveToWidget> createState() => _MoveToWidgetState();
}

class _MoveToWidgetState extends State<MoveToWidget> {
  @override
  Widget build(BuildContext context) {
    List<Widget> lists = widget.lists;
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
                child: Image.asset(
                    AppIcons.closeButtonDarker,
                    scale: 3),
              ),
            ),
          ),
          Text(
            'Lists',
            style: TextStyle(
              fontSize: 0.03 * widget.height,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 0.1 * widget.height,
            child: ListView.builder(
                itemCount: lists.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        lists[index],
                        Image.asset(
                          AppIcons.check,
                          scale: 3,
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 0.01 * widget.height),
            child: Text(
              TestStrings.addNewList,
              style: TextStyle(
                fontSize: 0.018 * widget.height,
                color: Colors.grey,
              ),
            ),
          ),
          BlackButtonWidget(
            onPressed: () {},
            width: widget.width - 50,
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
