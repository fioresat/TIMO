import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';

List<String> sampleLists = [
  TestStrings.list1,
  TestStrings.list2,
  TestStrings.list3
];

List<SingleTaskModel> sampleTasks = [
  SingleTaskModel(colorIndex: 0, task: TestStrings.task1, isActive: true),
  SingleTaskModel(colorIndex: 5, task: TestStrings.task2, isActive: true),
  SingleTaskModel(task: TestStrings.task3),
  SingleTaskModel(task: TestStrings.task1, isActive: true),
  SingleTaskModel(task: TestStrings.task2, ),
  SingleTaskModel(task: TestStrings.task3, isActive: true),
  SingleTaskModel(task: TestStrings.task1, isActive: true),
  SingleTaskModel(task: TestStrings.task2),
  SingleTaskModel(colorIndex: 4, task: TestStrings.task3),
];

