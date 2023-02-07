import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/ui/widgets/main_page_widgets/single_task_widget.dart';

List<String> sampleLists = [
  TestStrings.list1,
  TestStrings.list2,
  TestStrings.list3
];


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