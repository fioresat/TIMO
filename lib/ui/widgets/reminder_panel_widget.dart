import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:todo_app_main_screen/ui/style.dart';
import 'package:todo_app_main_screen/ui/widgets/black_button_widget.dart';

class ReminderPanelWidget extends StatefulWidget {
  final PanelController reminderPanelController;
  final double height;
  final double width;
  final Widget? body;
  final void Function() onTap;

  const ReminderPanelWidget({
    Key? key,
    required this.reminderPanelController,
    required this.height,
    required this.width,
    required this.body,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ReminderPanelWidget> createState() => _ReminderPanelWidgetState();
}

class _ReminderPanelWidgetState extends State<ReminderPanelWidget> {
  DateTime? _chosenDateTime;

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      isDraggable: false,
      minHeight: 0,
      maxHeight: 0.5 * widget.height,
      borderRadius: commonBorderRadius,
      controller: widget.reminderPanelController,
      onPanelOpened: () => setState(() {}),
      onPanelClosed: () => setState(() {}),
      body: widget.body,
      panelBuilder: (controller) => Padding(
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
            SizedBox(
              height: 300,
              child: CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (val) {
                    setState(() {
                      _chosenDateTime = val;
                    });
                  }),
            ),
            BlackButtonWidget(
              onPressed: () {},
              width: widget.width - 50,
              borderRadius: const BorderRadius.all(Radius.elliptical(12, 12)),
              child: const Text(
                TestStrings.move,
                style: TextStyle(color: backgroundColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
