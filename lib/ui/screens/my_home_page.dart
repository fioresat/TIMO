import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/helpers/sliding_panel_helper.dart';
import 'package:todo_app_main_screen/models/quote_model.dart';
import 'package:todo_app_main_screen/sample_data/sample_data.dart';
import 'package:todo_app_main_screen/service/fetch_helper.dart';
import 'package:todo_app_main_screen/ui/screens/lists_page.dart';
import 'package:todo_app_main_screen/ui/screens/new_task_page.dart';
import 'package:todo_app_main_screen/ui/style.dart';
import 'package:todo_app_main_screen/ui/widgets/lists_panel_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/main_page_widgets/main_page_background_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/main_page_widgets/tasks_widget.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/my_home_page';

  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final panelController = PanelController();
  bool isDeleted = false; //manage undo floating action button visibility
  bool isMoveTo = false; //manage add floating action button visibility
  final scrollController = ScrollController();
  final listController = TextEditingController();
  bool isPanelDraggable = false;
  bool isMoveToPressed = false;
  final _quoteService = FetchHelper();
  QuoteModel _quote = QuoteModel(
    author: '',
    content: '',
  );

  @override
  void initState() {
    super.initState();
    _updateQuote('quote1');
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: secondBackgroundColor,
      body: SlidingUpPanel(
        isDraggable: isPanelDraggable,
        backdropEnabled: true,
        backdropColor: Colors.white,
        backdropOpacity: 1,
        boxShadow: const [
          BoxShadow(blurRadius: 0, color: Color.fromRGBO(0, 0, 0, 0))
        ],
        minHeight: 0.58 * heightScreen,
        maxHeight: 0.95 * heightScreen,
        borderRadius: commonBorderRadius,
        controller: panelController,
        onPanelOpened: () => setState(() {}),
        onPanelClosed: () => setState(() {}),
        body: MainScreenBackgroundWidget(
          width: widthScreen,
          height: heightScreen,
          onPressed: () {
            Navigator.of(context).pushNamed(ListsPage.routeName);
          },
          quoteModel: _quote,
        ),
        panelBuilder: (controller) => TasksWidget(
          onPressed: () {
            SlidingPanelHelper().onPressedShowBottomSheet(
              ListsPanelWidget(
                height: heightScreen,
                width: widthScreen,
                lists: sampleLists,
                onTapClose: () {
                  Navigator.of(context).pop();
                  setState(() {
                    isMoveTo = false;
                    isMoveToPressed = false;
                  });
                },
                onAddNewListPressed: () {
                  SlidingPanelHelper()
                      .onAddNewListPressed(widthScreen, heightScreen, context);
                },
                onButtonPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    isMoveTo = false;
                  });
                },
              ),
              context,
            );
            setState(() {
              isMoveTo = true;
              isMoveToPressed = true;
            });
          },
          isPanelOpen: panelController.isPanelOpen,
          tasks: sampleTasks,
          controller: scrollController,
          panelController: panelController,
          height: panelController.isPanelOpen
              ? 0.95 * heightScreen
              : 0.55 * heightScreen,
          isMoveToPressed: isMoveToPressed,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: isMoveTo
          ? Container()
          : FloatingActionButton(
              heroTag: "fab2",
              backgroundColor: textColor,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  NewTaskPage.routeName,
                );
              },
              child: Image.asset(
                AppIcons.addButton,
              ),
            ),
    );
  }

  void _updateQuote(String quoteID) async {
    final dataDecoded = await _quoteService.getData(quoteID);
    setState(() {
      _quote = QuoteModel.fromJson(dataDecoded);
    });
  }
}
