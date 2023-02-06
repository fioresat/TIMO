import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/helpers/sliding_panel_helper.dart';
import 'package:todo_app_main_screen/ui/screens/lists_page.dart';
import 'package:todo_app_main_screen/ui/widgets/new_task_page_widgets/new_task_page_background_widget.dart';
import 'my_home_page.dart';

class NewTaskPage extends StatefulWidget {
  static const routeName = '/new_task_page';

  const NewTaskPage({Key? key}) : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final controller = TextEditingController();
  final listController = TextEditingController();

  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      body: NewTaskPageBackgroundWidget(
        height: heightScreen,
        controller: controller,
        width: widthScreen,
        onBlackButtonPressed: () {},
        onListsTap: () {
          SlidingPanelHelper().onListsTap(context, widthScreen, heightScreen,
              sampleLists, buttonColors, listController);
        },
        onReminderTap: () {
          SlidingPanelHelper()
              .onReminderTap(widthScreen, heightScreen, context);
        },
      ),
    );
  }
}
