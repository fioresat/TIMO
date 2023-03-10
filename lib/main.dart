import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/ui/screens/language_page.dart';
import 'package:todo_app_main_screen/ui/screens/lists_page.dart';
import 'package:todo_app_main_screen/ui/screens/my_home_page.dart';
import 'package:todo_app_main_screen/ui/screens/new_task_page.dart';
import 'package:todo_app_main_screen/ui/screens/premium_page.dart';
import 'package:todo_app_main_screen/ui/screens/settings_page.dart';
import 'package:todo_app_main_screen/ui/screens/task_page.dart';
import 'firebase_options.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
List<SingleTaskModel> currentTasks = [];
List<ListModel> currentLists = [];
int taskCurrentColorIndex = -1;
int listCurrentColorIndex = 0;
ListModel currentList = ListModel(list: 'ToDo', listID: 'ToDo');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.white,
        fontFamily: 'CeraPro',
      ),
      routes: {
        MyHomePage.routeName: (context) => const MyHomePage(),
        NewTaskPage.routeName: (context) => NewTaskPage(),
        TaskPage.routeName: (context) => const TaskPage(),
        ListsPage.routeName: (context) => const ListsPage(),
        SettingsPage.routeName: (context) => const SettingsPage(),
        LanguagePage.routeName: (context) => const LanguagePage(),
        PremiumPage.routeName: (context) => const PremiumPage()
      },
      initialRoute: MyHomePage.routeName,
    );
  }
}
