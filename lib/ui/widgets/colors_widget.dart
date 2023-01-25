import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/ui/widgets/single_color_widget.dart';

class ColorsWidget extends StatefulWidget {
  final List<Color> colors;
  final double width;

  const ColorsWidget({
    Key? key,
    required this.width,
    required this.colors,
  }) : super(key: key);

  @override
  State<ColorsWidget> createState() => _ColorsWidgetState();
}

class _ColorsWidgetState extends State<ColorsWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: EdgeInsets.only(right: widget.width * 0.15),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: widget.colors.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (
            BuildContext context,
            int index,
          ) {
            return SingleColorWidget(
              color: widget.colors[index],
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
