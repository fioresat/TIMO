import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/helpers/sliding_panel_helper.dart';
import 'package:todo_app_main_screen/ui/screens/settings_page.dart';
import 'package:todo_app_main_screen/ui/widgets/lists_page_widgets/options_panel_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/lists_page_widgets/single_list_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/nav_bar_widget.dart';

import 'add_button_widget.dart';

class ListsPageBackgroundWidget extends StatefulWidget {
  final double height;
  final double width;
  final void Function() onPressed;
  final List lists;

  final void Function() onAddButtonTap;

  ListsPageBackgroundWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.onPressed,
    required this.lists,
    required this.onAddButtonTap,
  }) : super(key: key);

  @override
  State<ListsPageBackgroundWidget> createState() =>
      _ListsPageBackgroundWidgetState();
}

class _ListsPageBackgroundWidgetState extends State<ListsPageBackgroundWidget> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: widget.height * 0.017,
          top: widget.height * 0.048,
          left: 25,
          right: 25,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Navigator.pushNamed(
                    context,
                    SettingsPage.routeName,
                  ),
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
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: (widget.width * 0.04),
              ),
              child: widget.lists.isEmpty
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: widget.height * 0.04),
                        child: AddButtonWidget(
                          onAddButtonTap: () {
                            widget.onAddButtonTap();
                          },
                          width: widget.width,
                          height: widget.height,
                        ),
                      ),
                    )
                  : GridView.count(
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      //scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      childAspectRatio: 1.5 / 2.5,
                      crossAxisSpacing: widget.width * 0.1,
                      mainAxisSpacing: widget.width * 0.01,
                      children: [
                        ...widget.lists.asMap().entries.map(
                              (list) => SingleListWidget(
                                onListTap: () {
                                  setState(() {
                                    _selectedIndex = list.key;
                                  });
                                },
                                height: widget.height,
                                onOptionsTap: () {
                                  SlidingPanelHelper().onPressedShowBottomSheet(
                                    OptionsPanelWidget(
                                      height: widget.height,
                                      width: widget.width,
                                      onTapClose: Navigator.of(context).pop,
                                      colors: buttonColors,
                                      onRenameTap: () {
                                        Navigator.pop(context);
                                      },
                                      onDeleteTap: () {
                                        setState(() {
                                          widget.lists.removeAt(list.key);
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                    context,
                                  );
                                },
                                title: list.value,
                                isTapped: _selectedIndex == list.key,
                                onAddButtonTap: () {
                                  widget.onAddButtonTap();
                                },
                                width: widget.width,
                              ),
                            ),
                        AddButtonWidget(
                          onAddButtonTap: () {
                            widget.onAddButtonTap();
                          },
                          width: widget.width,
                          height: widget.height,
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
