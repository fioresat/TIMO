import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/colors.dart';

class TasksWidget extends StatelessWidget {
  final List<Widget> tasks;

  const TasksWidget({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      width: 428,
      height: 534,
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: tasks,
        ),
      ),
    );
  }
}

class TaskWidget extends StatelessWidget {
  final Color colorful;
  final Color active;
  final String task;

  TaskWidget({
    Key? key,
    required this.colorful,
    required this.active,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 378,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 26,
              bottom: 19,
            ),
            child: Text(
              task,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  color: textColor, fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          Row(
            children: [
              Container(
                height: 5,
                width: 32,
                padding: EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: colorful,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 5,
                width: 32,
                padding: EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: active,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}