import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/ui/widgets/date_widget.dart';
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final panelController = PanelController();

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: textColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
