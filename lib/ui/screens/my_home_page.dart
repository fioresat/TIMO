import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/ui/widgets/date_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/quote_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/tasks_widget.dart';


List<Widget> testTasks = [
  const SizedBox(
    height: 30,
  ),
  TaskWidget(
    task: 'Thinking through a brand idea',
    active: textColor,
    colorful: lightBlueColor,
  ),
  TaskWidget(
    task: 'Organize a photo shoot',
    active: Colors.transparent,
    colorful: Colors.transparent,
  ),
  TaskWidget(
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
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: secondBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 44,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 13),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              width: 2.0,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Center(
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
                    height: 42,
                  ),
                  QuoteWidget(
                    author: 'Maya Angelou',
                    content:
                        'You will face many defeats in life, but never let yourself be defeated. So many defeats',
                  ),
                  SizedBox(
                    height: 29,
                  ),
                ],
              ),
            ),
            TasksWidget(tasks: testTasks),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: textColor,
      ),
    );
  }
}






