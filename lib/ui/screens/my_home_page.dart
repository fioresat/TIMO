import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:todo_app_main_screen/ui/style.dart';
import 'package:todo_app_main_screen/ui/widgets/main_screen_background_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/move_to_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/tasks_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/single_task_widget.dart';

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
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final panelController = PanelController();
  final listsPanelController = PanelController();
  bool isDeleted = false; //manage undo floating action button visibility
  bool isMoveTo = false; //manage add floating action button visibility

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: secondBackgroundColor,
      body: MoveToWidget(
          panelController: listsPanelController,
          height: heightScreen,
          width: widthScreen,
          borderRaduis: commonBorderRadius,
          body: SlidingUpPanel(
            isDraggable: false,
            backdropEnabled: true,
            backdropColor: Colors.white,
            backdropOpacity: 1,
            boxShadow: const [
              BoxShadow(blurRadius: 0, color: Color.fromRGBO(0, 0, 0, 0))
            ],
            minHeight: 0.55 * heightScreen,
            maxHeight: 0.95 * heightScreen,
            borderRadius: commonBorderRadius,
            controller: panelController,
            onPanelOpened: () => setState(() {}),
            onPanelClosed: () => setState(() {}),
            body: MainScreenBackgroundWidget(
              height: heightScreen,
              onPressed: () {},
            ),
            panelBuilder: (controller) => TasksWidget(
              onPressed: () {
                listsPanelController.open();
                setState(() {
                  isMoveTo = true;
                });
              },
              isPanelOpen: panelController.isPanelOpen,
              tasks: testTasks,
              controller: controller,
              panelController: panelController,
              height: panelController.isPanelOpen
                  ? 0.95 * heightScreen
                  : 0.55 * heightScreen,
            ),
          ),
          lists: testLists,
          onTap: () {
            listsPanelController.close();
            setState(() {
              isMoveTo = false;
            });
          },),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                        onPressed: () {},
                        child: const Icon(Icons.add),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
