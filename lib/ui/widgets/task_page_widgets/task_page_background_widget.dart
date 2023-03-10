import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/ui/widgets/colors_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/panel_close_widget.dart';

class TaskPageBackgroundWidget extends StatefulWidget {
  final double height;
  final double width;
  final SingleTaskModel singleTaskModel;
  final void Function() onReminderTap;
  final void Function() onTitleTap;
  final void Function() onMoveToTap;
  final void Function() onCloseTap;
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
      required this.singleTaskModel,
      required this.onCloseTap,})
      : super(key: key);

  @override
  State<TaskPageBackgroundWidget> createState() =>
      _TaskPageBackgroundWidgetState();
}

class _TaskPageBackgroundWidgetState extends State<TaskPageBackgroundWidget> {

  bool isTapped = false;

  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.singleTaskModel.task;
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(widget.singleTaskModel.dateTimeReminder);
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
            top: widget.height * 0.058,
            left: 25,
            right: 25),
        child: Column(
          children: [
            PanelCloseWidget(
              alignment: Alignment.topLeft,
              onTapClose: widget.onCloseTap,
              image: AppIcons.back,
            ),
            SizedBox(
              height: widget.height * 0.05,
            ),
            Flexible(
              child: TextField(
                onTap: () => setState(
                  () => isTapped = true,
                ),
                controller: widget.controller,
                cursorColor: darkColor,
                cursorHeight: 26,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: null,
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
                onTapOutside: (_) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  isTapped = false;
                },
              ),
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
                    selectedTaskColorIndex: widget.singleTaskModel.colorIndex,
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
                      InkWell(
                        onTap: widget.onReminderTap,
                        child: Row(
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
                      ),
                    ],
                  ),
                  SizedBox(
                    height: widget.height * 0.02,
                  ),
                  InkWell(
                    onTap: widget.onReminderTap,
                    child: (widget.singleTaskModel.isReminderActive == true) ? Row(
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
                    ) : Container(),
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
            ),
          ],
        ),
      ),
    );
  }
}
