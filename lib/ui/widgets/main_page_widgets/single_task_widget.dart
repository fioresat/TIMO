import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/ui/screens/task_page.dart';

class SingleTaskWidget extends StatelessWidget {
  final SingleTaskModel singleTaskModel;

  const SingleTaskWidget({
    Key? key,
    required this.singleTaskModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      width: 378,
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          TaskPage.routeName,
          arguments: singleTaskModel,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 11,
              ),
              child: Text(
                singleTaskModel.task,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Row(
              children: [
                singleTaskModel.colorIndex >= 0 &&
                        singleTaskModel.colorIndex < buttonColors.length
                    ? Container(
                        height: 5,
                        width: 32,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: buttonColors[singleTaskModel.colorIndex],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      )
                    : const SizedBox(),
                SizedBox(
                  width: singleTaskModel.colorIndex >= 0 &&
                          singleTaskModel.colorIndex < buttonColors.length
                      ? 10
                      : 0,
                ),
                Container(
                  height: 5,
                  width: 32,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: singleTaskModel.isReminderActive
                        ? textColor
                        : Colors.transparent,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
