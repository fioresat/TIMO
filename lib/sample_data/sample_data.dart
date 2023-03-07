import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';

List<String> sampleLists = [
  TestStrings.list1,
  TestStrings.list2,
  TestStrings.list3
];

List<SingleTaskModel> sampleTasks = [
  SingleTaskModel(colorIndex: 0, task: TestStrings.task1, isReminderActive: true, list: '', userID: ''),
  SingleTaskModel(colorIndex: 5, task: TestStrings.task2, isReminderActive: true, list: '', userID: ''),
  SingleTaskModel(task: TestStrings.task3, list: '', userID: ''),
  SingleTaskModel(task: TestStrings.task1, isReminderActive: true, list: '', userID: ''),
  SingleTaskModel(task: TestStrings.task2, list: '', userID: '', ),
  SingleTaskModel(task: TestStrings.task3, isReminderActive: true, list: '', userID: ''),
  SingleTaskModel(task: TestStrings.task1, isReminderActive: true, list: '', userID: ''),
  SingleTaskModel(task: TestStrings.task2, list: '', userID: ''),
  SingleTaskModel(colorIndex: 4, task: TestStrings.task3, list: '', userID: ''),
];

