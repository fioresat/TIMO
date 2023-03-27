import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_main_screen/bloc/app_bloc.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/helpers/sliding_panel_helper.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/models/quote_model.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/ui/screens/new_task_page.dart';
import 'package:todo_app_main_screen/ui/widgets/lists_panel_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/main_page_widgets/main_page_background_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/main_page_widgets/tasks_widget.dart';

class MyHomePage extends StatefulWidget {
  final QuoteModel quoteModel;
  static const routeName = '/my_home_page';

  const MyHomePage({Key? key, required this.quoteModel}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDeleted = false; //manage undo floating action button visibility
  bool isMoveTo = false; //manage add floating action button visibility
  final scrollController = ScrollController();
  final listController = TextEditingController();
  final dragController = DraggableScrollableController();
  bool isPanelDraggable = true;
  bool fabVisibility = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Builder(builder: (context) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: dragController.isAttached &&
                dragController.pixels ==
                    MediaQuery.of(context).size.height * 0.95
            ? Colors.white
            : (currentLists.isNotEmpty)
                ? buttonColors[currentLists[selectedListIndex].listColorIndex]
                : buttonColors[0],
        body: Stack(
          fit: StackFit.expand,
          children: [
            MainScreenBackgroundWidget(
              width: widthScreen,
              height: heightScreen,
              onPressed: () {
                context.read<AppBloc>().add(
                      const AppEventGoToLists(),
                    );
              },
              quoteModel: widget.quoteModel,
            ),
            NotificationListener<DraggableScrollableNotification>(
              onNotification: (DraggableScrollableNotification dsNotification) {
                if (fabVisibility && dsNotification.extent >= 0.95) {
                  setState(() {
                    fabVisibility = false;
                  });
                } else if (!fabVisibility && dsNotification.extent < 0.95) {
                  setState(() {
                    fabVisibility = true;
                  });
                }
                return fabVisibility;
              },
              child: DraggableScrollableSheet(
                  controller: dragController,
                  minChildSize: 0.58,
                  maxChildSize: 0.95,
                  initialChildSize: 0.59,
                  builder: (context, scrlCtrl) {
                    //print(scrlCtrl.offset.toString());
                    return TasksWidget(
                      onMoveToPressed: () {
                        SlidingPanelHelper().onPressedShowBottomSheet(
                          ListsPanelWidget(
                            height: heightScreen,
                            width: widthScreen,
                            lists: currentLists,
                            onTapClose: () {
                              Navigator.of(context).pop();
                              setState(() {
                                isMoveTo = false;
                              });
                            },
                            onAddNewListPressed: () {
                              SlidingPanelHelper().onAddNewListPressed(
                                widthScreen,
                                heightScreen,
                                context,
                                listController,
                              );
                            },
                            onButtonPressed: () {
                              _updateTask(
                                  updatedTask: currentTasks[selectedTaskIndex]);
                              Navigator.of(context).pop();
                              setState(() {
                                isMoveTo = false;
                                selectedTaskIndex = -1;
                              });
                            },
                          ),
                          context,
                        );
                        setState(() {
                          isMoveTo = true;
                        });
                      },
                      isPanelOpen: fabVisibility,
                      tasksList: currentTasks,
                      scrollController: scrlCtrl,
                      height: fabVisibility == false
                          ? 0.95 * heightScreen
                          : 0.55 * heightScreen,
                      isMoveToPressed: isMoveTo,
                      dragController: dragController,
                    );
                  }),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: isMoveTo
            ? Container()
            : FloatingActionButton(
                heroTag: "fab2",
                backgroundColor: textColor,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    NewTaskPage.routeName,
                  );
                },
                child: Image.asset(
                  AppIcons.addButton,
                ),
              ),
      );
    });
  }

  Future<void> _updateTask({
    required TaskModel updatedTask,
  }) async {
    db
        .collection("users")
        .doc(updatedTask.userID)
        .collection('lists')
        .doc(updatedTask.listID)
        .collection('tasks')
        .doc(updatedTask.taskID)
        .delete()
        .then(
          (doc) => log("Document deleted"),
          onError: (e) => log("Error updating document $e"),
        );
    addNewTask(
      newTask: TaskModel(
        task: updatedTask.task,
        colorIndex: updatedTask.colorIndex,
        listID: currentLists[moveToListIndex].listID,
        dateTimeReminder: updatedTask.dateTimeReminder,
        userID: updatedTask.userID,
        isReminderActive: updatedTask.isReminderActive,
        taskID: updatedTask.taskID,
      ),
    );
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
