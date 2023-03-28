import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_main_screen/helpers/functions.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/models/quote_model.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppStateSplashScreen()) {
    on<AppEventGetUser>(
      (event, emit) async {
        emit(
          const AppStateSplashScreen(),
        );
        await getUsers();
        await getLists();
        final tasksList =
            await getTasks(listModel: currentLists[selectedListIndex]);
        final QuoteModel quote = await updateQuote();
        emit(
          LoadedAppState(
            selectedListIndex: selectedListIndex,
            quoteModel: quote,
            tasksList: tasksList,
          ),
        );
      },
    );
    on<AppEventGoToLists>((event, emit) async {
      final listsList = await getLists();
      emit(
        LoadedListsAppState(listsList: listsList),
      );
    });
    on<AppEventGoToNewTask>((event, emit) async {
      emit(
        const AddNewTaskAppState(),
      );
    });
    on<AppEventGoToMainView>((event, emit) async {
      final tasksList = await getTasks(
        listModel: currentLists[selectedListIndex],
      );
      final QuoteModel quote = await updateQuote();
      emit(
        LoadedAppState(
          selectedListIndex: selectedListIndex,
          tasksList: tasksList,
          quoteModel: quote,
        ),
      );
    });
    on<AppEventAddNewTask>((event, emit) async {
      createNewTask(
        taskController: event.taskController,
      );
      final tasksList = await getTasks(
        listModel: currentLists[selectedListIndex],
      );
      final QuoteModel quote = await updateQuote(); // ToDo add lists
      emit(
        LoadedAppState(
          selectedListIndex: selectedListIndex,
          quoteModel: quote,
          tasksList: tasksList,
        ),
      );
    });
    on<AppEventGoToSettings>((event, emit) async {
      emit(
        const SettingsAppState(),
      );
    });
    on<AppEventGoToSingleTask>((event, emit) async {
      final taskModel = event.taskModel;
      emit(
        SingleTaskAppState(taskModel: taskModel),
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
    on<AppEventDeleteTask>((event, emit) async {
      await deleteTask(oldTask: event.taskModel);
      final tasksList = await getTasks(
        listModel: currentLists[selectedListIndex],
      );
      final QuoteModel quote = await updateQuote();
      emit(
        LoadedAppState(
          selectedListIndex: 0,
          quoteModel: quote,
          tasksList: tasksList,
        ),
      );
    });
    on<AppEventMoveToTask>((event, emit) async {
      await moveToFromMainScreenTask(updatedTask: event.taskModel);
      final tasksList = await getTasks(
        listModel: currentLists[selectedListIndex],
      );
      final QuoteModel quote = await updateQuote();
      emit(
        LoadedAppState(
          selectedListIndex: selectedListIndex,
          quoteModel: quote,
          tasksList: tasksList,
        ),
      );
    });
    on<AppEventDeleteList>((event, emit) async {
      await deleteList(oldList: event.listModel);
      final listsList = await getLists();

      emit(
        LoadedListsAppState(
          listsList: listsList,
        ),
      );
    });
    on<AppEventUpdateListColor>((event, emit) async {
      await updateListColor(
        oldList: event.listModel,
        listColorIndex: event.listColorIndex,
      );
      final listsList = await getLists();

      emit(
        LoadedListsAppState(
          listsList: listsList,
        ),
      );
    });
    on<AppEventChangeList>((event, emit) async {
      selectedListIndex = event.index;
      final tasksList = await getTasks(
        listModel: currentLists[selectedListIndex],
      );
      final QuoteModel quote = await updateQuote();
      emit(
        LoadedAppState(
            tasksList: tasksList,
            quoteModel: quote,
            selectedListIndex: selectedListIndex),
      );
    });
    on<AppEventAddNewListFromListScreen>((event, emit) async {
      await createNewList(listController: event.listController);
      final listsList = await getLists();
//create list of FocusNode => AppState => ListPage => BackgroundWidget
      emit(
        LoadedListsAppState(listsList: listsList),
      );
    });
  }
}
