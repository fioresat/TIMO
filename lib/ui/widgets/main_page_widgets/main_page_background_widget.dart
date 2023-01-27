import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:todo_app_main_screen/ui/widgets/main_page_widgets/date_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/main_page_widgets/quote_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/nav_bar_widget.dart';

class MainScreenBackgroundWidget extends StatelessWidget {
  final double width;
  final double? height;
  final void Function() onPressed;

  const MainScreenBackgroundWidget({
    super.key,
    this.height,
    required this.onPressed,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 0.049 * height!,
              ),
              NavBarWidget(
                width: width,
                height: height!,
                onPressed: onPressed,
                titleColor: textColor,
                buttonColor: lightBlueColor,
              ),
              DateWidget(
                dateTime: DateTime.now(),
                height: height,
              ),
              SizedBox(
                height: 0.044 * height!,
              ),
              QuoteWidget(
                author: TestStrings.quoteAuthor,
                content: TestStrings.quoteContent,
                height: height,
              ),
              SizedBox(
                height: 0.03 * height!,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
