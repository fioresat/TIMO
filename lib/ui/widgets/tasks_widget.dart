import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TasksWidget extends StatefulWidget {
  final bool isPanelOpen;
  final double height;
  final List<Widget> tasks;
  final ScrollController controller;
  final PanelController panelController;
  final void Function()? onPressed;

  const TasksWidget({
    Key? key,
    required this.isPanelOpen,
    required this.tasks,
    required this.controller,
    required this.panelController,
    this.onPressed,
    required this.height,
  }) : super(key: key);

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build(BuildContext context) {
    List<Widget> tasks = widget.tasks;
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Column(
        children: [
          dragHandle(),
          widget.isPanelOpen
              ? Column(
                  children: [
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: const [
                        Icon(Icons.keyboard_arrow_down),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'ToDo',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                )
              : const SizedBox(
                  height: 25,
                ),
          SizedBox(
            height: 0.9 * widget.height,
            child: ReorderableListView.builder(
                scrollController: widget.controller,
                itemCount: tasks.length,
                //shrinkWrap: true,
                onReorder: reorderData,
                itemBuilder: (BuildContext context, int index) {
                  return Slidable(
                    key: ValueKey(tasks[index]),
                    endActionPane: ActionPane(
                      extentRatio: 0.4,
                      dismissible: DismissiblePane(
                        onDismissed: () {
                          setState(() {
                            //ToDo
                            tasks.removeAt(index);
                          });
                        },
                      ),
                      motion: const BehindMotion(),
                      children: [
                        CustomSlidableAction(
                          flex: 1,
                          onPressed: (BuildContext context) {
                            setState(() {});
                          },
                          child: InkWell(
                            onTap: widget.onPressed,
                            child: Image.asset(
                              'assets/icons/move_to_icon.png',
                              scale: 3,
                            ),
                          ),
                        ),
                        CustomSlidableAction(
                          flex: 1,
                          onPressed: (BuildContext context) {
                            setState(() {
                              //ToDo
                              tasks.removeAt(index);
                            });
                          },
                          child: Image.asset(
                            'assets/icons/delete_icon.png',
                            scale: 3,
                          ),
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 0,
                      child: tasks[index],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  void reorderData(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final items = widget.tasks.removeAt(oldIndex);
      widget.tasks.insert(newIndex, items);
    });
  }

  Widget dragHandle() => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _movePanel,
        // onVerticalDragEnd: (DragEndDetails dets) {
        //   if (dets.velocity.pixelsPerSecond.dy != 0) {
        //     _movePanel;
        //   }
        // },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 10),
          child: Container(
            width: 30,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      );

  void _movePanel() {
    widget.panelController.isPanelOpen
        ? setState(() {
            widget.panelController.close();
          })
        : setState(() {
            widget.panelController.open();
          });
  }
}
