import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/strings.dart';

class ListsWidget extends StatelessWidget {
  final double height;
  final List<Widget> lists;
  final void Function() onAddNewListPressed;

  const ListsWidget({
    Key? key,
    required this.height,
    required this.lists,
    required this.onAddNewListPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lists',
          style: TextStyle(
            fontSize: 0.03 * height,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 0.1 * height,
          child: ListView.builder(
              itemCount: lists.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      lists[index],
                      Image.asset(
                        AppIcons.check,
                        scale: 3,
                      ),
                    ],
                  ),
                );
              }),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 0.03 * height,
            top: 0.02 * height,
          ),
          child: InkWell(
            onTap: onAddNewListPressed,
            child: Text(
              TestStrings.addNewList,
              style: TextStyle(
                fontSize: 0.018 * height,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
