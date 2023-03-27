import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_main_screen/l10n/locales.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/models/quote_model.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/models/user_model.dart';
import 'package:todo_app_main_screen/service/fetch_helper.dart';
import 'package:todo_app_main_screen/service/locale_provider.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppStateSplashScreen()) {
    on<AppEventGetUser>(
      (event, emit) async {
        emit(
          const AppStateSplashScreen(),
        );
        await _getUsers();
        await _getLists();
        await _getTasks();
        final QuoteModel quote = await updateQuote();
        if (currentTasks.isEmpty) {
          emit(InitAppState(quoteModel: quote));
        } else {
          emit(LoadedAppState(quoteModel: quote));
        }
      },
    );
    on<AppEventGoToLists>((event, emit) async {
      emit(
        const LoadedListsAppState(),
      );
    });
    on<AppEventGoToSettings>((event, emit) async {
      emit(
        const SettingsAppState(),
      );
    });
    on<AppEventGoToLanguage>((event, emit) async {
      emit(
        LanguageAppState(locale: currentUser.locale),
      );
    });
    on<AppEventChangeLocale>((event, emit) async {
      final int locale =
          changeLocale(context: event.context, index: event.index);
      emit(
        LanguageAppState(locale: locale),
      );
    });
  }

  Future<void> _updateTask({
    required TaskModel updatedTask,
  }) async {
    db
        .collection("users")
        .doc(updatedTask.userID)
        .collection('lists')
        .doc(updatedTask.listID)
        .collection('tasks')
        .doc(updatedTask.taskID)
        .delete()
        .then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
    addNewTask(
      newTask: TaskModel(
        task: updatedTask.task,
        colorIndex: updatedTask.colorIndex,
        listID: currentLists[moveToListIndex].listID,
        dateTimeReminder: updatedTask.dateTimeReminder,
        userID: updatedTask.userID,
        isReminderActive: updatedTask.isReminderActive,
        taskID: updatedTask.taskID,
      ),
    );
    moveToListIndex = -1;
  }

  Future<void> addNewTask({
    required final newTask,
  }) async {
    final docRef = db
        .collection("users")
        .doc(newTask.userID)
        .collection('lists')
        .doc(newTask.listID)
        .collection('tasks')
        .withConverter(
          toFirestore: (TaskModel task, options) => task.toFirestore(),
          fromFirestore: TaskModel.fromFirestore,
        )
        .doc(newTask.taskID);
    await docRef.set(newTask);
    currentList = ListModel(list: 'ToDo', listID: 'ToDo');
  }

  Future<void> _getTasks() async {
    currentTasks.clear();
    await _getLists();
    final tasksRef = db
        .collection("users")
        .doc(currentUser.userID)
        .collection("lists")
        .doc(currentLists[selectedListIndex].listID)
        .collection("tasks")
        .withConverter(
          fromFirestore: TaskModel.fromFirestore,
          toFirestore: (TaskModel task, _) => task.toFirestore(),
        )
        .get()
        .then(
          (querySnapshot) =>
              querySnapshot.docs.map((doc) => doc.data()).toList(),
          onError: (e) => print("Error completing: $e"),
        );

    currentTasks = await tasksRef;
  }

  Future<void> _getLists() async {
    final ref = db
        .collection("users")
        .doc(currentUser.userID)
        .collection("lists")
        .withConverter(
          fromFirestore: ListModel.fromFirestore,
          toFirestore: (ListModel list, _) => list.toFirestore(),
        )
        .get()
        .then(
          (querySnapshot) =>
              querySnapshot.docs.map((doc) => doc.data()).toList(),
          onError: (e) => print("Error completing: $e"),
        );

    currentLists = await ref;
    if (currentLists.isEmpty) {
      addToDoList();
      currentLists = [
        ListModel(
          listID: 'ToDo',
          list: 'ToDo',
        ),
      ];
    }
  }

  Future<void> addToDoList() async {
    final list = ListModel(
      listID: 'ToDo',
      list: 'ToDo',
    );
    final docRef = db
        .collection("users")
        .doc(currentUser.userID)
        .collection('lists')
        .withConverter(
          toFirestore: (ListModel list, options) => list.toFirestore(),
          fromFirestore: ListModel.fromFirestore,
        )
        .doc('ToDo');
    await docRef.set(list);
  }

  //ToDo move to main
  Future<void> _getUsers() async {
    final ref = db.collection("users").doc(currentUser.userID).withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel user, _) => user.toFirestore(),
        );
    final docSnap = await ref.get();
    if (docSnap.data() != null) {
      currentUser = docSnap.data()!;
    } else {
      addNewUser();
    }
  }

  //ToDo move to main
  Future<void> addNewUser() async {
    final docRef = db
        .collection("users")
        .withConverter(
          toFirestore: (UserModel user, options) => user.toFirestore(),
          fromFirestore: UserModel.fromFirestore,
        )
        .doc(currentUser.userID);
    await docRef.set(currentUser);
  }

  int changeLocale({required BuildContext context, required int index}) {
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    final locale = Locales.allLocales[index];
    provider.setLocale(locale);
    _updateUser(locale: index);

    currentUser.locale = index;
    return index;
  }

  Future<void> _updateUser({
    required int locale,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('locale', locale);
    final docRef = db.collection("users").doc(currentUser.userID);
    final updates = <String, dynamic>{
      'locale': locale,
    };
    await docRef.update(updates);
  }

  Future<QuoteModel> updateQuote() async {
    final dataDecoded = await FetchHelper().getData();
    return QuoteModel.fromJson(dataDecoded);
  }
}
