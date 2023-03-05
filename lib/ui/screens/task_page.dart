import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/helpers/sliding_panel_helper.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/sample_data/sample_data.dart';
import 'package:todo_app_main_screen/ui/widgets/lists_panel_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/task_page_widgets/task_page_background_widget.dart';

class TaskPage extends StatefulWidget {
  static const routeName = '/task_page';

  const TaskPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final listController = TextEditingController();
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sampleTask =
        ModalRoute.of(context)!.settings.arguments as SingleTaskModel;
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: TaskPageBackgroundWidget(
        height: heightScreen,
        width: widthScreen,
        onReminderTap: () => SlidingPanelHelper()
            .onReminderTap(widthScreen, heightScreen, context),
        onTitleTap: () {},
        onMoveToTap: () {},
        colors: buttonColors,
        controller: textController,
        singleTaskModel: sampleTask,
      ),
      floatingActionButton: showFab
          ? Container(
              padding: EdgeInsets.only(
                  left: widthScreen * 0.1, right: widthScreen * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    heroTag: 'deleteBtn',
                    elevation: 0,
                    backgroundColor: removeColor,
                    onPressed: null,
                    child: Image.asset(
                      AppIcons.delete,
                      scale: 2.5,
                    ),
                  ),
                  FloatingActionButton(
                    heroTag: 'moveBtn',
                    elevation: 0,
                    backgroundColor: textColor,
                    onPressed: () =>
                        SlidingPanelHelper().onPressedShowBottomSheet(
                      ListsPanelWidget(
                        height: heightScreen,
                        width: widthScreen,
                        lists: sampleLists,
                        onTapClose: Navigator.of(context).pop,
                        onAddNewListPressed: () {
                          SlidingPanelHelper().onAddNewListPressed(
                              widthScreen, heightScreen, context);
                        },
                        onButtonPressed: Navigator.of(context).pop,
                      ),
                      context,
                    ),
                    child: Image.asset(
                      AppIcons.moveTo,
                      scale: 3,
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
