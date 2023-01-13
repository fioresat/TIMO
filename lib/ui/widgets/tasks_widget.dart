import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:todo_app_main_screen/consts/colors.dart';

class TasksWidget extends StatefulWidget {
  final Widget padding;
  final List<Widget> tasks;
  final ScrollController controller;
  final PanelController panelController;

  const TasksWidget({
    Key? key,
    required this.padding,
    required this.tasks,
    required this.controller,
    required this.panelController,
  }) : super(key: key);

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build(BuildContext context) {
    List<Widget> tasks = widget.tasks;
    return Container(
      decoration: const BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          children: [
            widget.padding,
            ReorderableListView.builder(
                itemCount: tasks.length,
                shrinkWrap: true,
                onReorder: reorderData,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    background: Container(
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Icon(Icons.favorite, color: Colors.white),
                            Text('Move to',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.delete, color: Colors.white),
                            Text('Delete',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    key: ValueKey(tasks[index]),
                    onDismissed: (DismissDirection direction) {
                      setState(() {
                        tasks.removeAt(index);
                      });
                    },
                    child: Card(
                      elevation: 0,
                      child: tasks[index],
                    ),
                  );

                  // return Card(
                  //   elevation: 0,
                  //   key: ValueKey(index),
                  //   child: widget.tasks[index],
                  // );
                }),
          ],
        ),
      ),
    );
  }

  void reorderData(int oldindex, int newindex) {
    setState(() {
      if (newindex > oldindex) {
        newindex -= 1;
      }
      final items = widget.tasks.removeAt(oldindex);
      widget.tasks.insert(newindex, items);
    });
  }
}
