import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/ui/widgets/colors_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/panel_close_widget.dart';

class OptionsPanelWidget extends StatefulWidget {
  final double height;
  final double width;
  final void Function() onTapClose;
  final List<Color> colors;
  final void Function() onRenameTap;
  final void Function() onDeleteTap;

  const OptionsPanelWidget(
      {Key? key,
      required this.height,
      required this.width,
      required this.onTapClose,
      required this.colors,
      required this.onRenameTap,
      required this.onDeleteTap})
      : super(key: key);

  @override
  State<OptionsPanelWidget> createState() => _OptionsPanelWidgetState();
}

class _OptionsPanelWidgetState extends State<OptionsPanelWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: widget.width * 0.04,
        right: widget.width * 0.04,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 0.01 * widget.height,
          ),
          PanelCloseWidget(
            onTapClose: widget.onTapClose,
            height: widget.height,
          ),
          SizedBox(
            height: 0.01 * widget.height,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Color',
              style: TextStyle(
                fontSize: 0.025 * widget.height,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 0.01 * widget.height,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ColorsWidget(
              width: widget.width,
            ),
          ),
          OptionsWidget(
            onOptionTap: () {
              widget.onRenameTap();
            },
            height: widget.height,
            optionTitle: 'Rename',
            textColor: textColor,
          ),
          OptionsWidget(
            onOptionTap: () {},
            height: widget.height,
            optionTitle: 'Thumbnail',
            textColor: textColor,
          ),
          OptionsWidget(
            onOptionTap: () {
              widget.onDeleteTap();
            },
            height: widget.height,
            optionTitle: 'Delete',
            textColor: removeColor,
          ),
          SizedBox(
            height: 0.03 * widget.height,
          ),
        ],
      ),
    );
  }
}

class OptionsWidget extends StatelessWidget {
  final Function() onOptionTap;
  final double height;
  final String optionTitle;
  final Color textColor;

  const OptionsWidget({
    Key? key,
    required this.onOptionTap,
    required this.height,
    required this.optionTitle,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onOptionTap,
      child: Padding(
        padding: EdgeInsets.only(
          top: 0.03 * height,
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            optionTitle,
            style: TextStyle(
              fontSize: 0.025 * height,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
