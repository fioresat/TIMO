import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:todo_app_main_screen/ui/widgets/black_button_widget.dart';

class NewTaskPage extends StatefulWidget {
  static const routeName = '/new_task_page';

  const NewTaskPage({Key? key}) : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: heightScreen * 0.05, horizontal: widthScreen * 0.05),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: Navigator.of(context).pop,
                child: Padding(
                  padding: EdgeInsets.only(top: 0.02 * heightScreen),
                  child: Image.asset(AppIcons.close, scale: 3),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                controller: controller,
                style: const TextStyle(
                  fontSize: 26,
                ),
                decoration: const InputDecoration(
                  hintText: TestStrings.hintText,
                  hintStyle: TextStyle(
                    color: hintTextColor,
                    fontSize: 26,
                    height: 2,
                  ),
                  border: InputBorder.none,
                ),
                scrollPadding: const EdgeInsets.all(20.0),
                autofocus: true,
                keyboardType: TextInputType.multiline,
                maxLines: 99999,
                cursorColor: Colors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.2 * heightScreen),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Image.asset(AppIcons.lists, scale: 3),
                      ),
                      SizedBox(
                        width: widthScreen * 0.05,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Image.asset(AppIcons.reminderBell, scale: 3),
                      ),
                    ],
                  ),
                  BlackButtonWidget(
                    onPressed: () {},
                    width: widthScreen * 0.3,
                    borderRadius: BorderRadius.circular(22),
                    child: const Text(
                      TestStrings.create,
                      style: TextStyle(color: backgroundColor),
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
