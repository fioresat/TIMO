import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/helpers/sliding_panel_helper.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/sample_data/sample_data.dart';
import 'package:todo_app_main_screen/ui/widgets/new_task_page_widgets/new_task_page_background_widget.dart';

class NewTaskPage extends StatefulWidget {
  static const routeName = '/new_task_page';

  const NewTaskPage({Key? key}) : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final controller = TextEditingController();
  final listController = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      body: NewTaskPageBackgroundWidget(
        height: heightScreen,
        controller: controller,
        width: widthScreen,
        onBlackButtonPressed: () {
          if (controller.text.isNotEmpty) {
            addNewTask(
              text: controller.text,
              taskID: UniqueKey().toString(),
              list: listController.text,
            );
          }
          Navigator.pop(context);
        },
        onListsTap: () {
          SlidingPanelHelper().onListsTap(
            context,
            widthScreen,
            heightScreen,
            sampleLists,
            buttonColors,
            listController,
          );
        },
        onReminderTap: () {
          SlidingPanelHelper().onReminderTap(
            widthScreen,
            heightScreen,
            context,
          );
        },
      ),
    );
  }

  Future<void> addNewTask({
    required String text,
    required String taskID,
    int? colorIndex,
    String? list,
  }) async {
    final task = SingleTaskModel(
      task: text,
      taskID: taskID,
      list: list!.isNotEmpty ? list : 'ToDo',
    );
    final docRef = db
        .collection("users")
        .doc(task.userID)
        .collection('lists')
        .doc(task.list)
        .collection('tasks')
        .withConverter(
          toFirestore: (SingleTaskModel task, options) => task.toFirestore(),
          fromFirestore: SingleTaskModel.fromFirestore,
        )
        .doc(task.taskID);
    await docRef.set(task);
  }
}
