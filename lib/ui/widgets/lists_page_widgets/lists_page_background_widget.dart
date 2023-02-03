import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/ui/screens/settings_page.dart';
import 'package:todo_app_main_screen/ui/widgets/lists_page_widgets/single_list_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/nav_bar_widget.dart';

class ListsPageBackgroundWidget extends StatefulWidget {
  final double height;
  final double width;
  final void Function() onPressed;
  final List lists;
  final String listTitle;
  final void Function() onOptionsTap;
  final void Function() onAddButtonTap;
  TextEditingController controller;

  ListsPageBackgroundWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.onPressed,
    required this.lists,
    required this.onOptionsTap,
    required this.onAddButtonTap,
    required this.controller,
    required this.listTitle,
  }) : super(key: key);

  @override
  State<ListsPageBackgroundWidget> createState() =>
      _ListsPageBackgroundWidgetState();
}

class _ListsPageBackgroundWidgetState extends State<ListsPageBackgroundWidget> {
  bool isTapped = false;

  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.listTitle;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            bottom: widget.height * 0.017,
            top: widget.height * 0.048,
            left: 25,
            right: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, SettingsPage.routeName),
                  child: const Icon(
                    Icons.settings,
                    size: 30,
                  ),
                ),
                NavBarWidget(
                  height: widget.height,
                  onPressed: widget.onPressed,
                  width: widget.width,
                  titleColor: backgroundColor,
                  buttonColor: darkColor,
                )
              ],
            ),
            Container(
                padding:
                    EdgeInsets.symmetric(horizontal: (widget.width * 0.04)),
                child: widget.lists.isEmpty
                    ? Align(alignment: Alignment.centerLeft, child: addButton())
                    : GridView.count(
                        crossAxisCount: 2,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        childAspectRatio: 1.5 / 2.5,
                        crossAxisSpacing: widget.width * 0.1,
                        mainAxisSpacing: widget.width * 0.01,
                        children: [
                          ...widget.lists.map((list) => SingleListWidget
                            (height: widget.height,
                              onOptionsTap: widget.onOptionsTap,
                              controller: widget.controller,
                              listTitle: widget.listTitle)),
                          addButton()
                        ],
                      )),
          ],
        ),
      ),
    );
  }

  Widget addButton() {
    return InkWell(
      onTap: widget.onAddButtonTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: widget.height * 0.22,
            width: widget.width * 0.35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                border: Border.all(color: lightBorderColor, width: 2)),
            child: Image.asset(
              AppIcons.plus,
              scale: 2.5,
            ),
          ),
          Container()
        ],
      ),
    );
  }
}
