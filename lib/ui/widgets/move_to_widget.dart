import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'lists_panel_widget.dart';

class MoveToWidget extends StatefulWidget {
  final List<Widget> lists;
  final PanelController listPanelController;
  final double height;
  final double panelMaxheight;
  final double panelMinheight;
  final double width;
  final BorderRadiusGeometry? borderRadius;
  final Widget? body;
  final void Function() onTap;

   const MoveToWidget(
      {Key? key,
      required this.listPanelController,
      required this.height,
      required this.width,
      required this.borderRadius,
      required this.body,
      required this.lists,
      required this.onTap, required this.panelMaxheight, required this.panelMinheight,})
      : super(key: key);

  @override
  State<MoveToWidget> createState() => _MoveToWidgetState();
}

class _MoveToWidgetState extends State<MoveToWidget> {

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      isDraggable: true,
      minHeight: 0,
      maxHeight: 0.5 * widget.height,
      borderRadius: widget.borderRadius,
      controller: widget.listPanelController,
      onPanelOpened: () => setState(() {}),
      onPanelClosed: () => setState(() {}),

      body: widget.body,
      panelBuilder: (controller) => ListsPanelWidget(
        height: widget.height,
        width: widget.width,
        lists: widget.lists,
        onTap: widget.onTap,
        controller: controller,
        panelController: widget.listPanelController,
      ),
    );
  }
}
