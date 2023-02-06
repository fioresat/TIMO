import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/strings.dart';

class ListsWidget extends StatefulWidget {
  final double height;
  final List lists;
  final void Function() onAddNewListPressed;

  const ListsWidget(
      {Key? key,
      required this.height,
      required this.lists,
      required this.onAddNewListPressed})
      : super(key: key);

  @override
  State<ListsWidget> createState() => _ListsWidgetState();
}

class _ListsWidgetState extends State<ListsWidget> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lists',
          style: TextStyle(
            fontSize: 0.03 * widget.height,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 0.1 * widget.height,
          child: ListView.builder(
              itemCount: widget.lists.length,
              itemBuilder: (context, index) {
                if (widget.lists[index].isNotEmpty) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.lists[index],
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Image.asset(
                            AppIcons.check,
                            scale: 3,
                            color: _selectedIndex == index
                                ? Colors.black
                                : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 0.03 * widget.height,
            top: 0.02 * widget.height,
          ),
          child: InkWell(
            onTap: widget.onAddNewListPressed,
            child: Text(
              TestStrings.addNewList,
              style: TextStyle(
                fontSize: 0.018 * widget.height,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
