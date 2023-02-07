import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/ui/widgets/colors_widget.dart';

class TaskPageBackgroundWidget extends StatefulWidget {
  final double height;
  final double width;
  final SingleTaskModel singleTaskModel;
  final void Function() onReminderTap;
  final void Function() onTitleTap;
  final void Function() onMoveToTap;
  final List<Color> colors;
  final TextEditingController controller;

  const TaskPageBackgroundWidget(
      {Key? key,
      required this.height,
      required this.width,
      required this.onReminderTap,
      required this.onTitleTap,
      required this.onMoveToTap,
      required this.colors,
      required this.controller,
      required this.singleTaskModel})
      : super(key: key);

  @override
  State<TaskPageBackgroundWidget> createState() =>
      _TaskPageBackgroundWidgetState();
}

class _TaskPageBackgroundWidgetState extends State<TaskPageBackgroundWidget> {
  DateTime date = DateTime.now();
  bool isTapped = false;

  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.singleTaskModel.task;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          FocusManager.instance.primaryFocus?.unfocus();
          isTapped = false;
        });
      },
      child: Padding(
        padding: EdgeInsets.only(
            bottom: widget.height * 0.017,
            top: widget.height * 0.048,
            left: 25,
            right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Image.asset(
                AppIcons.back,
                scale: 3,
              ),
            ),
            SizedBox(
              height: widget.height * 0.05,
            ),
            TextField(
              onTap: () => setState(() => isTapped = true),
              controller: widget.controller,
              cursorColor: darkColor,
              cursorHeight: 26,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: darkColor,
              ),
              onChanged: (String newText) => setState(() {
                widget.singleTaskModel.task == newText;
              }),
              onSubmitted: (_) => setState(() {
                isTapped = false;
              }),
              onTapOutside: (_) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
            SizedBox(
              height: widget.height * 0.03,
            ),
            Opacity(
              opacity: isTapped == true ? 0.2 : 1,
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Color',
                      style: TextStyle(
                        fontSize: 20,
                        color: greyTextColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: widget.height * 0.02,
                  ),
                  ColorsWidget(
                    width: widget.width,
                    selectedIndex: widget.singleTaskModel.colorIndex,
                  ),
                  SizedBox(
                    height: widget.height * 0.04,
                  ),
                  Container(
                    height: 1,
                    decoration: const BoxDecoration(
                      color: separatorColor,
                    ),
                  ),
                  SizedBox(
                    height: widget.height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        TestStrings.reminder,
                        style: TextStyle(
                          fontSize: 20,
                          color: greyTextColor,
                        ),
                      ),
                      Row(
                        children: const [
                          Text(
                            '+',
                            style: TextStyle(
                              fontSize: 24,
                              color: greyTextColor,
                            ),
                          ),
                          Text(
                            ' add',
                            style: TextStyle(
                              fontSize: 18,
                              color: greyTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: widget.height * 0.02,
                  ),
                  InkWell(
                    onTap: widget.onReminderTap,
                    child: Row(
                      children: [
                        Text(
                          '${date.hour}-${date.minute.toString().padLeft(2, "0")}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${date.day} ${DateFormat("MMMM").format(date).toLowerCase().substring(0, 3)}.',
                          style: const TextStyle(
                            color: paleTextColor,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: widget.height * 0.02,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: separatorColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: TestStrings.activeReminder,
                                    style: TextStyle(
                                      color: activeReminderText,
                                      fontSize: 14,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 5,
                                        bottom: 4,
                                      ),
                                      child: Container(
                                        height: 6,
                                        width: 23,
                                        decoration: const BoxDecoration(
                                          color: textColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: widget.width * 0.05,
                          ),
                          InkWell(
                            child: Image.asset(
                              AppIcons.closeButton,
                              scale: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
