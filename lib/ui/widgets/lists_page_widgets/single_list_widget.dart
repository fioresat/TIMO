import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';

import 'add_button_widget.dart';

class SingleListWidget extends StatefulWidget {
  final double height;
  final double width;
  final void Function() onOptionsTap;
  final void Function() onListTap;
  final void Function() onAddButtonTap;
  final bool isTapped;
  String title;

  SingleListWidget({
    Key? key,
    required this.height,
    required this.onOptionsTap,
    required this.title,
    required this.isTapped,
    required this.onListTap,
    required this.onAddButtonTap,
    required this.width,
  }) : super(key: key);

  @override
  State<SingleListWidget> createState() => _SingleListWidgetState();
}

class _SingleListWidgetState extends State<SingleListWidget> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    return widget.title.isNotEmpty
        ? InkWell(
            onTap: widget.onListTap,
            child: Column(
              children: [
                Container(
                  height: widget.height * 0.20,
                  decoration: BoxDecoration(
                    color: lightBlueColor,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 10,
                        top: 10,
                        child: InkWell(
                          onTap: widget.onOptionsTap,
                          child: Image.asset(
                            AppIcons.options,
                            scale: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Row(
                    children: [
                      Image.asset(
                        AppIcons.userPoint,
                        scale: 3,
                        color:
                            widget.isTapped ? Colors.black : Colors.transparent,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: TextField(
                          maxLines: 1,
                          style: const TextStyle(
                            color: darkColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                          textAlign: TextAlign.center,
                          controller: controller,
                          cursorColor: darkColor,
                          cursorHeight: 18,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : AddButtonWidget(
            onAddButtonTap: () {
              widget.onAddButtonTap();
            },
            width: widget.width,
            height: widget.height,
          );
  }
}
