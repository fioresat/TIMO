part of 'app_bloc.dart';

@immutable
abstract class AppState {
  const AppState();
}

@immutable
class InitAppState extends AppState {
  final QuoteModel quoteModel;

  const InitAppState({required this.quoteModel});
}

@immutable
class LoadingAppState extends AppState {
  const LoadingAppState();
}

@immutable
class AppStateSplashScreen extends AppState {
  const AppStateSplashScreen();
}

@immutable
class LoadedAppState extends AppState {
  final QuoteModel quoteModel;
  final List<TaskModel> tasksList;
  final int selectedListIndex;

  const LoadedAppState({
    required this.selectedListIndex,
    required this.tasksList,
    required this.quoteModel,
  });
}

@immutable
class LoadedListsAppState extends AppState {
  final List<ListModel> listsList;

  const LoadedListsAppState({required this.listsList});
}

@immutable
class SettingsAppState extends AppState {
  const SettingsAppState();
}

@immutable
class AddNewTaskAppState extends AppState {
  const AddNewTaskAppState();
}

@immutable
class LanguageAppState extends AppState {
  final int locale;

  const LanguageAppState({required this.locale});
}

@immutable
class ErrorAppState extends AppState {
  const ErrorAppState();
}

@immutable
class SingleTaskAppState extends AppState {
  final TaskModel taskModel;

  const SingleTaskAppState({required this.taskModel});
}
