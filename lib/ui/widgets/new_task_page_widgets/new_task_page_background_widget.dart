import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:todo_app_main_screen/ui/widgets/panel_close_widget.dart';

import '../black_button_widget.dart';

class NewTaskPageBackgroundWidget extends StatefulWidget {
  final TextEditingController controller;
  final double height;
  final double width;
  final void Function() onBlackButtonPressed;
  final void Function() onReminderTap;
  final void Function() onListsTap;

  const NewTaskPageBackgroundWidget(
      {Key? key,
      required this.controller,
      required this.height,
      required this.width,
      required this.onBlackButtonPressed,
      required this.onReminderTap,
      required this.onListsTap})
      : super(key: key);

  @override
  State<NewTaskPageBackgroundWidget> createState() =>
      _NewTaskPageBackgroundWidgetState();
}

class _NewTaskPageBackgroundWidgetState
    extends State<NewTaskPageBackgroundWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: widget.height * 0.017,
          top: widget.height * 0.048,
          left: 25,
          right: 25),
      child: Column(
        children: [
          PanelCloseWidget(
            alignment: Alignment.topRight,
            onTapClose: Navigator.of(context).pop,
            image: AppIcons.close,
          ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: widget.controller,
              style: const TextStyle(
                fontSize: 26,
              ),
              decoration: const InputDecoration(
                hintText: TestStrings.hintText,
                hintStyle: TextStyle(
                  color: hintTextColor,
                  fontSize: 26,
                  height: 2,
                ),
                border: InputBorder.none,
              ),
              scrollPadding: const EdgeInsets.all(20.0),
              autofocus: true,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              cursorColor: Colors.black,
              onTapOutside: (_) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.02 * widget.height),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: widget.onListsTap,
                      child: Image.asset(
                        AppIcons.lists,
                        scale: 3,
                      ),
                    ),
                    SizedBox(
                      width: widget.width * 0.05,
                    ),
                    InkWell(
                      onTap: widget.onReminderTap,
                      child: Image.asset(
                        AppIcons.reminderBell,
                        scale: 3,
                      ),
                    ),
                  ],
                ),
                BlackButtonWidget(
                  onPressed: widget.onBlackButtonPressed,
                  width: widget.width * 0.3,
                  borderRadius: BorderRadius.circular(22),
                  child: const Text(
                    TestStrings.create,
                    style: TextStyle(color: backgroundColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
