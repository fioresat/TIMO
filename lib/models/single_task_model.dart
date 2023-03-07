import 'package:cloud_firestore/cloud_firestore.dart';

class SingleTaskModel {
  int colorIndex;
  bool isReminderActive;
  String task;
  String list;
  int listColorIndex;
  String userID;
  String taskID;

  SingleTaskModel({
    this.userID = 'testUser',
    this.taskID = '',
    this.colorIndex = -1,
    this.listColorIndex = 0,
    this.isReminderActive = false,
    required this.task,
    this.list = "ToDo",
  });

  factory SingleTaskModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return SingleTaskModel(
      colorIndex: data?['colorIndex'],
      isReminderActive: data?['isReminderActive'],
      task: data?['task'],
      list: data?['list'],
      listColorIndex: data?['listColorIndex'],
      userID: data?['userID'],
      taskID: data?['taskID'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "colorIndex": colorIndex,
      "isReminderActive": isReminderActive,
      "task": task,
      "list": list,
      "listColorIndex": listColorIndex,
      "userID": userID,
      "taskID": taskID,
    };
  }
}

class ReminderTaskModel extends SingleTaskModel {
  DateTime dateTimeReminder;

  ReminderTaskModel({
    required super.task,
    required this.dateTimeReminder,
    required super.userID,
  });
}
