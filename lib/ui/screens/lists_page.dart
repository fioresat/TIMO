import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:todo_app_main_screen/helpers/sliding_panel_helper.dart';
import 'package:todo_app_main_screen/ui/widgets/lists_page_widgets/lists_page_background_widget.dart';

class ListsPage extends StatefulWidget {
  static const routeName = '/lists_page';

  const ListsPage({Key? key}) : super(key: key);

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  final listController = TextEditingController();
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListsPageBackgroundWidget(
        height: heightScreen,
        width: widthScreen,
        onPressed: () {},
        lists: sampleLists,
        onOptionsTap: () => SlidingPanelHelper()
            .onOptionsTap(context, widthScreen, heightScreen, buttonColors, onRenameTap(context)),
        onAddButtonTap: () => SlidingPanelHelper().onAddNewListPressed(
            widthScreen, heightScreen, context, listController),
        controller: textController,
      ),
    );
  }

  List<String> sampleLists = [
    TestStrings.list1,
    TestStrings.list2,
    TestStrings.list3,
  ];
}

void Function() onRenameTap(BuildContext context) {
  return Navigator.of(context).pop;
}
