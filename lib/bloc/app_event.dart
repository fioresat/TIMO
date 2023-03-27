part of 'app_bloc.dart';

@immutable
abstract class AppEvent {
  const AppEvent();
}

@immutable
class AppEventGetUser implements AppEvent {
  const AppEventGetUser() : super();
}

@immutable
class AppEventGoToLists implements AppEvent {
  const AppEventGoToLists() : super();
}

@immutable
class AppEventGoToSettings implements AppEvent {
  const AppEventGoToSettings() : super();
}

@immutable
class AppEventGoToLanguage implements AppEvent {
  const AppEventGoToLanguage() : super();
}

@immutable
class AppEventChangeLocale implements AppEvent {
  BuildContext context;
  int index;

  AppEventChangeLocale({
    required this.context,
    required this.index,
  }) : super();
}

@immutable
class AppEventGetLists implements AppEvent {
  final String userID;

  const AppEventGetLists({
    required this.userID,
  }) : super();
}

@immutable
class AppEventGetTasks implements AppEvent {
  final String userID;
  final String listID;

  const AppEventGetTasks({
    required this.userID,
    required this.listID,
  }) : super();
}

@immutable
class AppEventDeleteList implements AppEvent {
  const AppEventDeleteList();
}

@immutable
class AppEventUpdateList implements AppEvent {
  const AppEventUpdateList();
}

@immutable
class AppEventUpdateTask implements AppEvent {
  const AppEventUpdateTask();
}

@immutable
class AppEventDeleteTask implements AppEvent {
  const AppEventDeleteTask();
}

@immutable
class AppEventAddNewTask implements AppEvent {
  final TextEditingController taskController;

  const AppEventAddNewTask({
    required this.taskController,
  });
}

@immutable
class AppEventGoToNewTask implements AppEvent {
  const AppEventGoToNewTask() : super();
}

@immutable
class AppEventGoToMainView implements AppEvent {
  const AppEventGoToMainView() : super();
}