import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/ui/screens/my_home_page.dart';
import 'package:todo_app_main_screen/ui/screens/new_task_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'CeraPro',
      ),
      routes: {
        MyHomePage.routeName: (context) => const MyHomePage(),
        NewTaskPage.routeName: (context) => const NewTaskPage()
      },
      initialRoute: MyHomePage.routeName,
    );
  }
}
