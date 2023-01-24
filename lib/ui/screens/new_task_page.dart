import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/ui/style.dart';
import 'package:todo_app_main_screen/ui/widgets/add_new_list_panel_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/new_task_page_widgets/colors_panel_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/new_task_page_widgets/new_task_page_background_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/reminder_panel_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'my_home_page.dart';

List<Color> colors = [
  lightBlueColor,
  yellowColor,
  blueColor,
  greenColor,
  purpleColor,
  redColor,
  orangeColor,
  pinkColor
];

class NewTaskPage extends StatefulWidget {
  static const routeName = '/new_task_page';

  const NewTaskPage({Key? key}) : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final controller = TextEditingController();
  final listController = TextEditingController();

  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      body: NewTaskPageBackgroundWidget(
        height: heightScreen,
        controller: controller,
        width: widthScreen,
        onBlackButtonPressed: () {},
        onListsTap: () {
          onListsTap(widthScreen, heightScreen);
        },
        onReminderTap: () {
          onReminderTap(widthScreen, heightScreen);
        },
      ),
    );
  }

  void onPressedShowBottomSheet(Widget child) {
    showMaterialModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: commonBorderRadius,
      ),
      enableDrag: false,
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: child,
      ),
    );
  }

  void onAddNewListPressed(double widthScreen, double heightScreen) {
    onPressedShowBottomSheet(
      AddNewListPanelWidget(
        height: heightScreen,
        onTapClose: () {
          Navigator.of(context).pop();
        },
        width: widthScreen,
        controller: listController,
      ),
    );
  }

  void onReminderTap(double widthScreen, double heightScreen) {
    onPressedShowBottomSheet(
      ReminderPanelWidget(
        height: heightScreen,
        onTap: () {
          Navigator.of(context).pop();
        },
        width: widthScreen,
      ),
    );
  }

  void onListsTap(double widthScreen, double heightScreen) {
    onPressedShowBottomSheet(
      ColorsPanelWidget(
        height: heightScreen,
        width: widthScreen,
        onTapClose: Navigator.of(context).pop,
        lists: testLists,
        colors: colors,
        onAddNewListPressed: () {
          onAddNewListPressed(widthScreen, heightScreen);
        },
      ),
    );
  }
}
