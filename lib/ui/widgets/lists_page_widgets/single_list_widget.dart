import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';

class SingleListWidget extends StatefulWidget {
  final double height;
  final void Function() onOptionsTap;
  TextEditingController controller;
  String listTitle;

  SingleListWidget({
    Key? key,
    required this.height,
    required this.onOptionsTap,
    required this.controller,
    required this.listTitle,
  }) : super(key: key);

  @override
  State<SingleListWidget> createState() => _SingleListWidgetState();
}

class _SingleListWidgetState extends State<SingleListWidget> {
  bool isTapped = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.height * 0.22,
          decoration: BoxDecoration(
              color: lightBlueColor, borderRadius: BorderRadius.circular(26)),
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
          width: 80,
          child: Row(
            children: [
              isTapped
                  ? Image.asset(
                      AppIcons.userPoint,
                      scale: 3,
                    )
                  : Container(
                      width: 1,
                    ),
              const SizedBox(width: 5,),
              Expanded(
                child: TextField(
                  maxLines: 1,
                  onTap: () => setState(() => isTapped = !isTapped),
                  style: const TextStyle(
                      color: darkColor, overflow: TextOverflow.ellipsis),
                  textAlign: TextAlign.center,
                  controller: widget.controller,
                  cursorColor: darkColor,
                  cursorHeight: 18,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  onChanged: (String newText) => _updateTitle(newText)
                ),
              )
            ],
          ),
        )
      ],
    );
  }
  void _updateTitle(String newTitle) {
    setState(() {
      widget.listTitle = newTitle;
    });
  }
}
