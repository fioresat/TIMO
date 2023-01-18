import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/ui/widgets/date_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/move_to_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/nav_bar_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/quote_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/tasks_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/single_task_widget.dart';

List<Widget> testTasks = [
  const SingleTaskWidget(
    task: 'Thinking through a brand idea',
    active: textColor,
    colorful: lightBlueColor,
  ),
  const SingleTaskWidget(
    task: 'Organize a photo shoot',
    active: Colors.transparent,
    colorful: Colors.transparent,
  ),
  const SingleTaskWidget(
    task:
        'Buying groceries to take home. Buying groceries to take home. Buying groceries to take home.',
    active: Colors.transparent,
    colorful: Colors.transparent,
  ),
];

List<Widget> testLists = [
  const Text(
    'Todo',
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
    //double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: secondBackgroundColor,
      body: SlidingUpPanel(
        isDraggable: false,
        minHeight: 0,
        maxHeight: 0.3 * heightScreen,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        controller: listsPanelController,
        onPanelOpened: () => setState(() {}),
        onPanelClosed: () => setState(() {}),
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
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          controller: panelController,
          onPanelOpened: () => setState(() {}),
          onPanelClosed: () => setState(() {}),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 0.049 * heightScreen,
                    ),
                    NavBarWidget(
                      height: heightScreen,
                      onPressed: () {},
                    ),
                    DateWidget(
                      dateTime: DateTime.now(),
                      height: heightScreen,
                    ),
                    SizedBox(
                      height: 0.044 * heightScreen,
                    ),
                    QuoteWidget(
                      author: 'Maya Angelou',
                      content:
                          'You will face many defeats in life, but never let yourself be defeated. So many defeats',
                      height: heightScreen,
                    ),
                    SizedBox(
                      height: 0.03 * heightScreen,
                    ),
                  ],
                ),
              ),
            ],
          ),
          panelBuilder: (controller) => TasksWidget(
            onPressed: () {
              listsPanelController.open();
              setState(() {
                isMoveTo = true;
              });
            },
            padding: panelController.isPanelOpen
                ? Column(
                    children: [
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Icon(Icons.keyboard_arrow_down),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'ToDo',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(
                    height: 25,
                  ),
            tasks: testTasks,
            controller: controller,
            panelController: panelController,
          ),
        ),
        panelBuilder: (controller) => MoveToWidget(
          onTap: () {
            listsPanelController.close();
            setState(() {
              isMoveTo = false;
            });
          },
          lists: testLists,
          controller: controller,
          panelController: listsPanelController,
          height: heightScreen,
        ),
      ),
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
                        child: Icon(Icons.add),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
