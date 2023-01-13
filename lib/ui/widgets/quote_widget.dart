import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/colors.dart';

class QuoteWidget extends StatelessWidget {
  final String author;
  final String content;
  final double? height;

  const QuoteWidget(
      {required this.content,
      super.key,
      required this.author,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          author,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 0.008 * height!,
        ),
        Text(
          content,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
