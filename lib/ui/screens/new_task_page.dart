import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/helpers/sliding_panel_helper.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
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
  final taskModel = SingleTaskModel(task: '');

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
              listID: currentList.listID,
              colorIndex: taskCurrentColorIndex,
            );
            setState(() {
              taskCurrentColorIndex = -1;
              listCurrentColorIndex = 0;
              currentList = ListModel(
                list: 'ToDo',
                listID: 'ToDo',
              );
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
  }) async {
    final task = SingleTaskModel(
      task: text,
      taskID: taskID,
      listID: listID!.isNotEmpty ? listID : 'ToDo',
      colorIndex: colorIndex,
    );
    final docRef = db
        .collection("users")
        .doc(task.userID)
        .collection('lists')
        .doc(task.listID)
        .collection('tasks')
        .withConverter(
          toFirestore: (SingleTaskModel task, options) => task.toFirestore(),
          fromFirestore: SingleTaskModel.fromFirestore,
        )
        .doc(task.taskID);
    await docRef.set(task);
  }

  Future<void> addNewList({
    required String text,
    required String listID,
  }) async {
    final list = ListModel(
      list: text,
      listID: listID,
    );
    final docRef = db
        .collection("users")
        .doc('testUser')
        .collection('lists')
        .withConverter(
          toFirestore: (ListModel task, options) => task.toFirestore(),
          fromFirestore: ListModel.fromFirestore,
        )
        .doc(list.listID);
    await docRef.set(list);
  }
}
