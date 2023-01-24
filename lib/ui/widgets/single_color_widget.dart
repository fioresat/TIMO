import 'package:flutter/material.dart';

class SingleColorWidget extends StatefulWidget {
  final Color color;

  const SingleColorWidget({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  State<SingleColorWidget> createState() => _SingleColorWidgetState();
}

class _SingleColorWidgetState extends State<SingleColorWidget> {
  double bottomPadding = 0;
  double topPadding = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 10,
      child: AnimatedPadding(
        padding: EdgeInsets.only(
          bottom: bottomPadding,
          top: topPadding,
        ),
        duration: const Duration(milliseconds: 1),
        child: InkWell(
          onTap: () {
            _updatePadding();
          },
          child: Container(
            height: 36,
            width: 10,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _updatePadding() {
    setState(() {
      bottomPadding = (bottomPadding == 0) ? 20 : 0;
      topPadding = (topPadding == 20) ? 0 : 20;
    });
  }
}
