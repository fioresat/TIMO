import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/generated/l10n.dart';

class DateWidget extends StatelessWidget {
  final DateTime dateTime;
  final double? height;

  const DateWidget({
    super.key,
    required this.dateTime,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    String weekDay =
        DateFormat('EEEEE', Localizations.localeOf(context).toString()).format(dateTime).toLowerCase();
    String date = DateFormat('d', 'en_US').format(dateTime).toLowerCase();
    return Stack(
      children: [
        Container(
          height: 0.18 * height!,
          child: Text(
            date,
            maxLines: 1,
            style: TextStyle(
              color: textColor,
              fontSize: 0.18 * height!,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          child: Text(
            weekDay,
            maxLines: 1,
            style: TextStyle(
              color: textColor,
              fontSize: 0.03 * height!,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
