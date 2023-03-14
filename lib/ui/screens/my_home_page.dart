import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/helpers/sliding_panel_helper.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/models/quote_model.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
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
  final panelController = PanelController();
  bool isDeleted = false; //manage undo floating action button visibility
  bool isMoveTo = false; //manage add floating action button visibility
  final scrollController = ScrollController();
  final listController = TextEditingController();
  bool isPanelDraggable = false;
  bool isMoveToPressed = false;
  final _quoteService = FetchHelper();
  QuoteModel _quote = QuoteModel(
    author: '',
    content: '',
  );

  @override
  void initState() {
    _updateQuote('quote1');
    _getLists();
    _getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: secondBackgroundColor,
      body: SlidingUpPanel(
        isDraggable: isPanelDraggable,
        backdropEnabled: true,
        backdropColor: Colors.white,
        backdropOpacity: 1,
        boxShadow: const [
          BoxShadow(blurRadius: 0, color: Color.fromRGBO(0, 0, 0, 0))
        ],
        minHeight: 0.58 * heightScreen,
        maxHeight: 0.95 * heightScreen,
        borderRadius: commonBorderRadius,
        controller: panelController,
        onPanelOpened: () => setState(() {}),
        onPanelClosed: () => setState(() {}),
        body: MainScreenBackgroundWidget(
          width: widthScreen,
          height: heightScreen,
          onPressed: () {
            Navigator.of(context).pushNamed(ListsPage.routeName);
          },
          quoteModel: _quote,
        ),
        panelBuilder: (controller) => FutureBuilder(
            future: _getTasks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return TasksWidget(
                  onPressed: () {
                    SlidingPanelHelper().onPressedShowBottomSheet(
                      ListsPanelWidget(
                        height: heightScreen,
                        width: widthScreen,
                        lists: currentLists,
                        onTapClose: () {
                          Navigator.of(context).pop();
                          setState(() {
                            isMoveTo = false;
                            isMoveToPressed = false;
                          });
                        },
                        onAddNewListPressed: () {
                          SlidingPanelHelper().onAddNewListPressed(widthScreen,
                              heightScreen, context, listController);
                        },
                        onButtonPressed: () {
                          Navigator.of(context).pop();
                          setState(() {
                            isMoveTo = false;
                          });
                        },
                      ),
                      context,
                    );
                    setState(() {
                      isMoveTo = true;
                      isMoveToPressed = true;
                    });
                  },
                  isPanelOpen: panelController.isPanelOpen,
                  tasksList: currentTasks,
                  scrollController: scrollController,
                  panelController: panelController,
                  height: panelController.isPanelOpen
                      ? 0.95 * heightScreen
                      : 0.55 * heightScreen,
                  isMoveToPressed: isMoveToPressed,
                );
              } else if (snapshot.connectionState == ConnectionState.none) {
                return Text("No data");
              }
              return const Center(child: CircularProgressIndicator());
            }),
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
  }

  void _updateQuote(String quoteID) async {
    final dataDecoded = await _quoteService.getData(quoteID);
    setState(() {
      _quote = QuoteModel.fromJson(dataDecoded);
    });
  }

  Future<void> _getLists() async {
    final ref = db
        .collection("users")
        .doc("testUser")
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
    log(currentLists.length.toString());
    if (currentLists.isEmpty) {
      addToDoList();
    }
  }
  Future<void> _getTasks() async {
    currentTasks.clear();
    final tasksRef = db
        .collectionGroup('tasks')
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

  Future<void> addToDoList() async {
    final list = ListModel(
      listID: 'ToDo',
      list: 'ToDo',
    );
    final docRef = db
        .collection("users")
        .doc('testUser')
        .collection('lists')
        .withConverter(
          toFirestore: (ListModel task, options) => task.toFirestore(),
          fromFirestore: ListModel.fromFirestore,
        )
        .doc('ToDo');
    await docRef.set(list);
  }
}
