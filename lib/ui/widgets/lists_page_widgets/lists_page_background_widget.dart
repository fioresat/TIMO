import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/ui/screens/settings_page.dart';
import 'package:todo_app_main_screen/ui/widgets/nav_bar_widget.dart';

class ListsPageBackgroundWidget extends StatefulWidget {
  final double height;
  final double width;
  final void Function() onPressed;
  final List lists;
  final void Function() onOptionsTap;
  final void Function() onAddButtonTap;
  final TextEditingController controller;

  const ListsPageBackgroundWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.onPressed,
    required this.lists,
    required this.onOptionsTap,
    required this.onAddButtonTap,
    required this.controller,
  }) : super(key: key);

  @override
  State<ListsPageBackgroundWidget> createState() =>
      _ListsPageBackgroundWidgetState();
}

class _ListsPageBackgroundWidgetState extends State<ListsPageBackgroundWidget> {
  bool isTapped = false;

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
                  onTap: () => Navigator.pushNamed(context, SettingsPage.routeName),
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
                          ...widget.lists.map((list) => Column(
                                children: [
                                  Container(
                                    height: widget.height * 0.22,
                                    decoration: BoxDecoration(
                                        color: lightBlueColor,
                                        borderRadius:
                                            BorderRadius.circular(26)),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          right: 10,
                                          top: 10,
                                          child: InkWell(
                                              onTap: widget.onOptionsTap,
                                              child: Image.asset(
                                                AppIcons.options,
                                                scale: 3,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: widget.height * 0.01,
                                  ),
                                  Flexible(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() => isTapped = true);
                                        widget.controller.text = list;
                                      },
                                      child: isTapped == true
                                          ? SizedBox(
                                              height: 16,
                                              child: TextField(
                                                style: const TextStyle(
                                                    color: darkColor
                                                ),
                                                textAlign: TextAlign.center,
                                                controller: widget.controller,
                                                cursorColor: darkColor,
                                                cursorHeight: 18,
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            )
                                          : RichText(
                                              text: TextSpan(children: [
                                              WidgetSpan(
                                                  child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5, right: 5),
                                                child: Image.asset(
                                                  AppIcons.userPoint,
                                                  scale: 3,
                                                ),
                                              )),
                                              TextSpan(
                                                  text: list,
                                                  style: const TextStyle(
                                                      color: darkColor))
                                            ])),
                                    ),
                                  )
                                ],
                              )),
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
