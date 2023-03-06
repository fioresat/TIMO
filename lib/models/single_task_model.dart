class SingleTaskModel {
  int colorIndex;
  bool isReminderActive = false;
  String task;
  String list;

  SingleTaskModel({
    this.colorIndex = -1,
    this.isReminderActive = false,
    required this.task,
    this.list = "ToDo",
  });
}

class ReminderTaskModel extends SingleTaskModel {
  DateTime dateTimeReminder;

  ReminderTaskModel({
    required super.task,
    required this.dateTimeReminder,
  });
}
