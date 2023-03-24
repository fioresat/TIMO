import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/helpers/sliding_panel_helper.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/models/quote_model.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/models/user_model.dart';
import 'package:todo_app_main_screen/service/fetch_helper.dart';
import 'package:todo_app_main_screen/ui/screens/lists_page.dart';
import 'package:todo_app_main_screen/ui/screens/new_task_page.dart';
import 'package:todo_app_main_screen/ui/style.dart';
import 'package:todo_app_main_screen/ui/widgets/lists_panel_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/main_page_widgets/main_page_background_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/main_page_widgets/tasks_widget.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/my_home_page';

  const MyHomePage({Key? key}) : super(key: key);

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
  final _quoteService = FetchHelper();
  QuoteModel _quote = QuoteModel(
    author: '',
    content: '',
  );

  @override
  void initState() {
    _updateQuote();
    _getUsers();
    _getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Builder(builder: (context) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: (currentLists.isNotEmpty)
            ? buttonColors[currentLists[selectedListIndex].listColorIndex]
            : buttonColors[0],
        body: Stack(
          children: [
            MainScreenBackgroundWidget(
              width: widthScreen,
              height: heightScreen,
              onPressed: () {
                Navigator.of(context).pushNamed(ListsPage.routeName);
              },
              quoteModel: _quote,
            ),
            DraggableScrollableSheet(
              controller: dragController,
                minChildSize: 0.58,
                maxChildSize: 1,
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
                isPanelOpen: dragController.isAttached,
                tasksList: currentTasks,
                scrollController: scrlCtrl,
                height: dragController.isAttached ?
                    0.95 * heightScreen :
                0.55 * heightScreen,

                isMoveToPressed: isMoveTo, dragController: dragController,
              );
            }),
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
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
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

  void _updateQuote() async {
    final dataDecoded = await _quoteService.getData();

    setState(() {
      _quote = QuoteModel.fromJson(dataDecoded);
    });
  }

  Future<void> _getTasks() async {
    currentTasks.clear();
    await _getLists();
    final tasksRef = db
        .collection("users")
        .doc(currentUser.userID)
        .collection("lists")
        .doc(currentLists[selectedListIndex].listID)
        .collection("tasks")
        .withConverter(
          fromFirestore: TaskModel.fromFirestore,
          toFirestore: (TaskModel task, _) => task.toFirestore(),
        )
        .get()
        .then(
          (querySnapshot) =>
              querySnapshot.docs.map((doc) => doc.data()).toList(),
          onError: (e) => print("Error completing: $e"),
        );

    currentTasks = await tasksRef;
  }

  Future<void> _getLists() async {
    final ref = db
        .collection("users")
        .doc(currentUser.userID)
        .collection("lists")
        .withConverter(
          fromFirestore: ListModel.fromFirestore,
          toFirestore: (ListModel list, _) => list.toFirestore(),
        )
        .get()
        .then(
          (querySnapshot) =>
              querySnapshot.docs.map((doc) => doc.data()).toList(),
          onError: (e) => print("Error completing: $e"),
        );

    currentLists = await ref;
    if (currentLists.isEmpty) {
      addToDoList();
      currentLists = [
        ListModel(
          listID: 'ToDo',
          list: 'ToDo',
        ),
      ];
    }
  }

  Future<void> addToDoList() async {
    final list = ListModel(
      listID: 'ToDo',
      list: 'ToDo',
    );
    final docRef = db
        .collection("users")
        .doc(currentUser.userID)
        .collection('lists')
        .withConverter(
          toFirestore: (ListModel list, options) => list.toFirestore(),
          fromFirestore: ListModel.fromFirestore,
        )
        .doc('ToDo');
    await docRef.set(list);
  }

  //ToDo move to main
  Future<void> _getUsers() async {
    final ref = db.collection("users").doc(currentUser.userID).withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel user, _) => user.toFirestore(),
        );
    final docSnap = await ref.get();
    if (docSnap.data() != null) {
      currentUser = docSnap.data()!;
    } else {
      addNewUser();
    }
  }

  //ToDo move to main
  Future<void> addNewUser() async {
    final docRef = db
        .collection("users")
        .withConverter(
          toFirestore: (UserModel user, options) => user.toFirestore(),
          fromFirestore: UserModel.fromFirestore,
        )
        .doc(currentUser.userID);
    await docRef.set(currentUser);
  }
}
