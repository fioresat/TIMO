import 'package:flutter/material.dart';

class SingleColorWidget extends StatelessWidget {
  final Color color;
  final void Function()? onColorTap;
  final void Function()? onColorSecTap;
  final AlignmentGeometry alignment;

  SingleColorWidget(
      {Key? key,
      required this.color,
      required this.onColorTap,
      required this.alignment,
      required this.onColorSecTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onColorTap,
      onSecondaryTap: onColorSecTap,
      child: Align(
        alignment: alignment,
        child: Container(
          height: 36,
          width: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
