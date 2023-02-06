import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:todo_app_main_screen/helpers/sliding_panel_helper.dart';
import 'package:todo_app_main_screen/ui/screens/lists_page.dart';
import 'package:todo_app_main_screen/ui/screens/new_task_page.dart';
import 'package:todo_app_main_screen/ui/style.dart';
import 'package:todo_app_main_screen/ui/widgets/lists_panel_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/main_page_widgets/main_page_background_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/main_page_widgets/tasks_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/main_page_widgets/single_task_widget.dart';

List<Widget> testTasks = [
  const SingleTaskWidget(
    task: TestStrings.task1,
    active: textColor,
    colorful: lightBlueColor,
  ),
  const SingleTaskWidget(
    task: TestStrings.task2,
    active: Colors.transparent,
    colorful: Colors.transparent,
  ),
  const SingleTaskWidget(
    task: TestStrings.task3,
    active: Colors.transparent,
    colorful: Colors.transparent,
  ),
  const SingleTaskWidget(
    task: TestStrings.task1,
    active: textColor,
    colorful: lightBlueColor,
  ),
  const SingleTaskWidget(
    task: TestStrings.task2,
    active: Colors.transparent,
    colorful: Colors.transparent,
  ),
  const SingleTaskWidget(
    task: TestStrings.task3,
    active: Colors.transparent,
    colorful: Colors.transparent,
  ),
  const SingleTaskWidget(
    task: TestStrings.task1,
    active: textColor,
    colorful: lightBlueColor,
  ),
  const SingleTaskWidget(
    task: TestStrings.task2,
    active: Colors.transparent,
    colorful: Colors.transparent,
  ),
  const SingleTaskWidget(
    task: TestStrings.task3,
    active: Colors.transparent,
    colorful: Colors.transparent,
  ),
  const SingleTaskWidget(
    task: TestStrings.task1,
    active: textColor,
    colorful: lightBlueColor,
  ),
  const SingleTaskWidget(
    task: TestStrings.task2,
    active: Colors.transparent,
    colorful: Colors.transparent,
  ),
  const SingleTaskWidget(
    task: TestStrings.task3,
    active: Colors.transparent,
    colorful: Colors.transparent,
  ),
  const SingleTaskWidget(
    task: TestStrings.task1,
    active: textColor,
    colorful: lightBlueColor,
  ),
  const SingleTaskWidget(
    task: TestStrings.task2,
    active: Colors.transparent,
    colorful: Colors.transparent,
  ),
  const SingleTaskWidget(
    task: TestStrings.task3,
    active: Colors.transparent,
    colorful: Colors.transparent,
  ),
];

List<Widget> testLists = [
  const Text(
    TestStrings.list1,
    style: TextStyle(
      fontSize: 20,
    ),
  ),
  const Text(
    TestStrings.list2,
    style: TextStyle(
      fontSize: 20,
    ),
  ),
  const Text(
    TestStrings.list3,
    style: TextStyle(
      fontSize: 20,
    ),
  ),
];

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

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: secondBackgroundColor,
      body: SlidingUpPanel(
        isDraggable: false,
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
        ),
        panelBuilder: (controller) => TasksWidget(
          onPressed: () {
            SlidingPanelHelper().onPressedShowBottomSheet(
              ListsPanelWidget(
                height: heightScreen,
                width: widthScreen,
                lists: testLists,
                onTapClose: () {
                  Navigator.of(context).pop();
                  setState(() {
                    isMoveTo = false;
                  });
                },
                onAddNewListPressed: () {
                  SlidingPanelHelper().onAddNewListPressed(
                      widthScreen, heightScreen, context);
                },
              ),
              context,
            );
            setState(() {
              isMoveTo = true;
            });
          },
          isPanelOpen: panelController.isPanelOpen,
          tasks: testTasks,
          controller: scrollController,
          panelController: panelController,
          height: panelController.isPanelOpen
              ? 0.95 * heightScreen
              : 0.55 * heightScreen,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.only(
          left: 25.0,
          right: 25.0,
          top: 0.0086 * heightScreen, // ToDo
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                isDeleted
                    ? FloatingActionButton(
                        backgroundColor: textColor,
                        onPressed: () {},
                        child: const Icon(Icons.undo),
                      )
                    : Container(),
                isMoveTo
                    ? Container()
                    : FloatingActionButton(
                        backgroundColor: textColor,
                        onPressed: () {
                          Navigator.pushNamed(context, NewTaskPage.routeName);
                        },
                        child: Image.asset(AppIcons.addButton),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
