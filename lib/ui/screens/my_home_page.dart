import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/ui/widgets/date_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/quote_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/tasks_widget.dart';

List<Widget> testTasks = [
  const SizedBox(
    height: 40,
  ),
  const TaskWidget(
    task: 'Thinking through a brand idea',
    active: textColor,
    colorful: lightBlueColor,
  ),
  const TaskWidget(
    task: 'Organize a photo shoot',
    active: Colors.transparent,
    colorful: Colors.transparent,
  ),
  const TaskWidget(
    task:
        'Buying groceries to take home. Buying groceries to take home. Buying groceries to take home.',
    active: Colors.transparent,
    colorful: Colors.transparent,
  ),
];

List<Widget> testTasksTodo = [
  const SizedBox(
    height: 18,
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
      )
    ],
  ),
  const TaskWidget(
    task: 'Thinking through a brand idea',
    active: textColor,
    colorful: lightBlueColor,
  ),
  const TaskWidget(
    task: 'Organize a photo shoot',
    active: Colors.transparent,
    colorful: Colors.transparent,
  ),
  const TaskWidget(
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 44,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                width: 2.0,
                                style: BorderStyle.solid),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'lists',
                              style: TextStyle(color: textColor, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                    DateWidget(
                      dateTime: DateTime.now(),
                    ),
                     SizedBox(
                      height: heightScreen / 80,
                    ),
                    const QuoteWidget(
                      author: 'Maya Angelou',
                      content:
                          'You will face many defeats in life, but never let yourself be defeated. So many defeats',
                    ),
                    const SizedBox(
                      height: 29,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        panelBuilder: (controller) => panelController.isPanelOpen
            ? TasksWidget(
                tasks: testTasksTodo,
                controller: controller,
                panelController: panelController)
            : TasksWidget(
                tasks: testTasks,
                controller: controller,
                panelController: panelController,
              ),
        minHeight: heightScreen / 1.87,
        maxHeight: heightScreen,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        controller: panelController,
        onPanelOpened: () => setState(() {}),
        onPanelClosed: () => setState(() {}),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: textColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
