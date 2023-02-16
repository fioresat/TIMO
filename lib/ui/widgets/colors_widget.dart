import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/button_colors.dart';
import 'package:todo_app_main_screen/ui/widgets/single_color_widget.dart';

class ColorsWidget extends StatefulWidget {
  int selectedIndex;
  final double width;

  ColorsWidget({
    Key? key,
    required this.width,
    this.selectedIndex = -1,
  }) : super(key: key);

  @override
  State<ColorsWidget> createState() => _ColorsWidgetState();
}

class _ColorsWidgetState extends State<ColorsWidget> {
  double bottomPadding = 0;
  double topPadding = 20;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: EdgeInsets.only(right: widget.width * 0.15),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: buttonColors.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                setState(() {
                  if (widget.selectedIndex != index) {
                    widget.selectedIndex = index;
                  } else {
                    widget.selectedIndex = -1;
                  }
                });
              },
              child: SingleColorWidget(
                color: buttonColors[index],
                bottomPadding: widget.selectedIndex == index
                    ? bottomPadding = 20
                    : bottomPadding = 0,
                topPadding: widget.selectedIndex == index
                    ? topPadding = 0
                    : topPadding = 20,
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            width: widget.width * 0.07,
          ),
        ),
      ),
    );
  }
}
