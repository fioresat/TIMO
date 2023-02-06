import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:todo_app_main_screen/ui/widgets/black_button_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/panel_close_widget.dart';

class ReminderPanelWidget extends StatefulWidget {
  final double height;
  final double width;
  final void Function() onCloseTap;

  const ReminderPanelWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.onCloseTap,
  }) : super(key: key);

  @override
  State<ReminderPanelWidget> createState() => _ReminderPanelWidgetState();
}

class _ReminderPanelWidgetState extends State<ReminderPanelWidget> {
  DateTime? _chosenDateTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PanelCloseWidget(
            onTapClose: widget.onCloseTap,
            height: widget.height,
          ),
          Text(
            TestStrings.reminder,
            style: TextStyle(
              fontSize: 0.03 * widget.height,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 0.27 * widget.height,
            child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (val) {
                  setState(() {
                    _chosenDateTime = val;
                  });
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: BlackButtonWidget(
              onPressed: () {Navigator.pop(context);},
              width: widget.width - 50,
              borderRadius: const BorderRadius.all(Radius.elliptical(12, 12)),
              child: const Text(
                TestStrings.saveReminderButton,
                style: TextStyle(color: backgroundColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
