import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/helpers/sliding_panel_helper.dart';
import 'package:todo_app_main_screen/sample_data/sample_data.dart';
import 'package:todo_app_main_screen/ui/widgets/lists_page_widgets/lists_page_background_widget.dart';



class ListsPage extends StatefulWidget {
  static const routeName = '/lists_page';

  const ListsPage({Key? key}) : super(key: key);

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  final listController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
          onAddButtonTap: () => SlidingPanelHelper().onAddNewListPressed(
            widthScreen,
            heightScreen,
            context,
          ),
        ),
    );
  }
}


