import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/colors.dart';

class DateWidget extends StatelessWidget {
  final DateTime dateTime;

  const DateWidget({
    super.key,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    String weekDay =
    DateFormat('EEEEE', 'en_US').format(dateTime).toLowerCase();
    String date = DateFormat('d', 'en_US').format(dateTime).toLowerCase();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          weekDay,
          style: TextStyle(
            color: textColor,
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          date,
          style: TextStyle(
            color: textColor,
            fontSize: 164,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}