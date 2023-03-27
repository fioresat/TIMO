import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/helpers/sliding_panel_helper.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/ui/screens/my_home_page.dart';
import 'package:todo_app_main_screen/ui/widgets/lists_page_widgets/options_panel_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/lists_page_widgets/single_list_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/nav_bar_widget.dart';
import 'add_button_widget.dart';

class ListsPageBackgroundWidget extends StatefulWidget {
  final double height;
  final double width;
  final void Function() onPressed;
  final List<ListModel> lists;
  final void Function() onAddButtonTap;
  final void Function() onSettingsButtonTap;
  final TextEditingController controller;

  const ListsPageBackgroundWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.onPressed,
    required this.lists,
    required this.onAddButtonTap,
    required this.controller, required this.onSettingsButtonTap,
  }) : super(key: key);

  @override
  State<ListsPageBackgroundWidget> createState() =>
      _ListsPageBackgroundWidgetState();
}

class _ListsPageBackgroundWidgetState extends State<ListsPageBackgroundWidget> {
  int _selectedIndex = 0;
  late List<FocusNode> focusNodeList;

  @override
  void initState() {
    focusNodeList = List.generate(widget.lists.length, (index) => FocusNode());
    super.initState();
  }

  @override
  void dispose() {
    for (int i = 0; i < widget.lists.length; i++) {
      focusNodeList[i].dispose();
    }
    super.dispose();
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
                ExpandTapWidget(
                  tapPadding: const EdgeInsets.all(50.0),
                  onTap: widget.onSettingsButtonTap,
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
                                    selectedListIndex = _selectedIndex;
                                    Navigator.of(context).pushReplacementNamed(
                                        MyHomePage.routeName);
                                  });
                                },
                                height: widget.height,
                                onOptionsTap: () {
                                  _selectedIndex = list.key;
                                  SlidingPanelHelper().onPressedShowBottomSheet(
                                    OptionsPanelWidget(
                                      selectedListColorIndex: widget
                                          .lists[_selectedIndex].listColorIndex,
                                      height: widget.height,
                                      width: widget.width,
                                      onTapClose: () {
                                        _updateListColor(
                                          oldList: widget.lists[_selectedIndex],
                                        );
                                        Navigator.pop(context);
                                      },
                                      colors: buttonColors,
                                      onRenameTap: () {
                                        FocusScope.of(context).requestFocus(
                                            focusNodeList[list.key]);
                                        Navigator.pop(context);
                                      },
                                      onDeleteTap: () {
                                        setState(() {
                                          _deleteList(
                                            oldList:
                                                widget.lists[_selectedIndex],
                                          );
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                    context,
                                  );
                                },
                                listModel: list.value,
                                isTapped: selectedListIndex == list.key,
                                onAddButtonTap: () {
                                  widget.onAddButtonTap();
                                },
                                width: widget.width,
                                focusNode: focusNodeList[list.key],
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

  Future<void> _deleteList({
    required ListModel oldList,
  }) async {
    db
        .collection("users")
        .doc('testUser')
        .collection('lists')
        .doc(oldList.listID)
        .delete()
        .then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }

  Future<void> _updateListColor({
    required ListModel oldList,
  }) async {
    final docRef = db
        .collection("users")
        .doc('testUser')
        .collection('lists')
        .doc(oldList.listID);

    final updates = <String, int>{
      "listColorIndex": listCurrentColorIndex,
    };
    docRef.update(updates);
  }
}
