import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/helpers/sliding_panel_helper.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/ui/widgets/new_task_page_widgets/new_task_page_background_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/shake_error_widget.dart';

class NewTaskPage extends StatefulWidget {
  static const routeName = '/new_task_page';

  const NewTaskPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> with SingleTickerProviderStateMixin {
  final taskController = TextEditingController();
  final listController = TextEditingController();
  final taskModel = TaskModel(task: '');
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      body: NewTaskPageBackgroundWidget(
        height: heightScreen,
        taskController: taskController,
        width: widthScreen,
        onBlackButtonPressed: () {
          if (taskController.text.isNotEmpty) {
            addNewTask(
              text: taskController.text,
              taskID: UniqueKey().toString(),
              listID: currentList.listID,
              colorIndex: taskCurrentColorIndex,
              dateTimeReminder: currentDateTimeReminder,
              isReminderActive: currentIsReminderActive,
            );
            setState(() {
              taskCurrentColorIndex = -1;
              listCurrentColorIndex = 0;
              currentList = ListModel(
                list: 'ToDo',
                listID: 'ToDo',
              );
              currentDateTimeReminder = '2000-01-01 00:00:00';
              currentIsReminderActive = false;
            });
          }
          Navigator.pop(context);
        },
        onListsTap: () {
          SlidingPanelHelper().onListsTap(
            context,
            widthScreen,
            heightScreen,
            currentLists,
            buttonColors,
            listController,
            taskCurrentColorIndex,
          );
        },
        onReminderTap: () {
          SlidingPanelHelper().onReminderTap(
            widthScreen,
            heightScreen,
            context,
            () {},
            taskModel,
          );
        },
      ),
    );
  }

  Future<void> addNewTask({
    required String text,
    required String taskID,
    required int colorIndex,
    String? listID,
    required String dateTimeReminder,
    bool? isReminderActive,
  }) async {
    final newTask = TaskModel(
      task: text,
      userID: currentUser.userID,
      taskID: taskID,
      listID: listID!.isNotEmpty ? listID : 'ToDo',
      colorIndex: colorIndex,
      dateTimeReminder: dateTimeReminder,
      isReminderActive: isReminderActive ?? false,
    );
    final docRef = db
        .collection("users")
        .doc(newTask.userID)
        .collection('lists')
        .doc(newTask.listID)
        .collection('tasks')
        .withConverter(
          toFirestore: (TaskModel task, options) => task.toFirestore(),
          fromFirestore: TaskModel.fromFirestore,
        )
        .doc(newTask.taskID);
    await docRef.set(newTask);

  }
}
