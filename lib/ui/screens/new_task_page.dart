import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:todo_app_main_screen/ui/widgets/new_task_page_background_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/reminder_panel_widget.dart';

class NewTaskPage extends StatefulWidget {
  static const routeName = '/new_task_page';

  const NewTaskPage({Key? key}) : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final controller = TextEditingController();
  final reminderPanelController = PanelController();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ReminderPanelWidget(
        body: NewTaskPageBackgroundWidget(
          height: heightScreen,
          controller: controller,
          width: widthScreen,
          onPressed: () {},
          onListsTap: () {},
          onReminderTap: () {
            reminderPanelController.open();
          },
        ),
        reminderPanelController: reminderPanelController,
        height: heightScreen,
        width: widthScreen,
        onTap: () {
          reminderPanelController.close();
        },
      ),
    );
  }
}
