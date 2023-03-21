import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/helpers/sliding_panel_helper.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/ui/widgets/lists_panel_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/task_page_widgets/task_page_background_widget.dart';

class TaskPage extends StatefulWidget {
  static const routeName = '/task_page';

  const TaskPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final listController = TextEditingController();
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final taskModelFromMainScreen =
        ModalRoute.of(context)!.settings.arguments as TaskModel;
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: TaskPageBackgroundWidget(
        height: heightScreen,
        width: widthScreen,
        onReminderTap: () => SlidingPanelHelper().onReminderTap(
          widthScreen,
          heightScreen,
          context,
          () {},
          taskModelFromMainScreen,
        ),
        onTitleTap: () {},
        onMoveToTap: () {},
        colorsList: buttonColors,
        taskController: textController,
        taskModel: taskModelFromMainScreen,
        onCloseTap: () {
          _updateTask(
            updatedTask: taskModelFromMainScreen,
          );
          Navigator.pop(context);
        },
      ),
      floatingActionButton: showFab
          ? Container(
              padding: EdgeInsets.only(
                left: widthScreen * 0.1,
                right: widthScreen * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    heroTag: 'deleteBtn',
                    elevation: 0,
                    backgroundColor: removeColor,
                    onPressed: () {
                      _deleteTask(oldTask: taskModelFromMainScreen);
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      AppIcons.delete,
                      scale: 2.5,
                    ),
                  ),
                  FloatingActionButton(
                    heroTag: 'moveBtn',
                    elevation: 0,
                    backgroundColor: textColor,
                    onPressed: () =>
                        SlidingPanelHelper().onPressedShowBottomSheet(
                      ListsPanelWidget(
                        height: heightScreen,
                        width: widthScreen,
                        lists: currentLists,
                        onTapClose: Navigator.of(context).pop,
                        onAddNewListPressed: () {
                          SlidingPanelHelper().onAddNewListPressed(
                            widthScreen,
                            heightScreen,
                            context,
                            listController,
                          );
                        },
                        onButtonPressed: Navigator.of(context).pop,
                      ),
                      context,
                    ),
                    child: Image.asset(
                      AppIcons.moveTo,
                      scale: 3,
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Future<void> _deleteTask({
    required TaskModel oldTask,
  }) async {
    db
        .collection("users")
        .doc(oldTask.userID)
        .collection('lists')
        .doc(oldTask.listID)
        .collection('tasks')
        .doc(oldTask.taskID)
        .delete()
        .then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }

  Future<void> _updateTask({
    required TaskModel updatedTask,
  }) async {
    if (selectedListIndex == moveToListIndex) {
      final docRef = db
          .collection("users")
          .doc('testUser')
          .collection('lists')
          .doc(updatedTask.listID)
          .collection('tasks')
          .doc(updatedTask.taskID);

      final updates = <String, dynamic>{
        'task': textController.text,
        'colorIndex': (taskCurrentColorIndex == -1)
            ? updatedTask.colorIndex
            : taskCurrentColorIndex,
      };
      docRef.update(updates);
    } else {
      db
          .collection("users")
          .doc('testUser')
          .collection('lists')
          .doc(updatedTask.listID)
          .collection('tasks')
          .doc(updatedTask.taskID)
          .delete()
          .then(
            (doc) => print("Document deleted"),
            onError: (e) => print("Error updating document $e"),
          );
      addNewTask(
        newTask: TaskModel(
          task: textController.text,
          colorIndex: (taskCurrentColorIndex == -1)
              ? updatedTask.colorIndex
              : taskCurrentColorIndex,
          listID: currentLists[moveToListIndex].listID,
          dateTimeReminder: updatedTask.dateTimeReminder,
          userID: updatedTask.userID,
          isReminderActive: updatedTask.isReminderActive,
          taskID: updatedTask.taskID,
        ),
      );
    }
    moveToListIndex = -1;
  }

  Future<void> addNewTask({
    required final newTask,
  }) async {
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
    currentList = ListModel(list: 'ToDo', listID: 'ToDo');
  }
}
