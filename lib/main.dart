import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/ui/screens/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'CeraPro',
      ),
      home: const MyHomePage(),
    );
  }
}
