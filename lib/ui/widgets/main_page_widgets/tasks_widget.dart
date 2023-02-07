import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/ui/widgets/main_page_widgets/single_task_widget.dart';

class TasksWidget extends StatefulWidget {
  final bool isPanelOpen;
  final double height;
  final List<SingleTaskModel> tasks;
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<SingleTaskModel> tasks = widget.tasks;
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Column(
        children: [
          Stack(
            children: [
              Center(
                child: dragHandle(),
              ),
              todoButton(),
            ],
          ),
          SizedBox(
            height: 0.9 * widget.height,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                controller: widget.controller,
                physics: const BouncingScrollPhysics(),
                //scrollController: widget.controller,
                itemCount: tasks.length,
                //shrinkWrap: true,
                //onReorder: reorderData,
                itemBuilder: (BuildContext context, int index) {
                  return Slidable(
                    key: ValueKey(tasks[index]),
                    endActionPane: ActionPane(
                      extentRatio: 0.6,
                      dismissible: DismissiblePane(
                        onDismissed: () {
                          setState(() {
                            // added this block
                            _undo(tasks, index);
                          });
                        },
                      ),
                      motion: const ScrollMotion(),
                      children: [
                        CustomSlidableAction(
                          //flex: 1,
                          onPressed: (BuildContext context) {
                            setState(() {});
                          },
                          child: InkWell(
                            onTap: widget.onPressed,
                            child: SizedBox(
                              width: 100,
                              height: 56,
                              child: Image.asset(
                                AppIcons.moveTo,
                                scale: 3,
                              ),
                            ),
                          ),
                        ),
                        CustomSlidableAction(
                          //flex: 2,
                          onPressed: (BuildContext context) {
                            setState(() {
                              //ToDo
                              _undo(tasks, index);
                            });
                          },
                          child: Container(
                            width: 100,
                            height: 56,
                            child: Image.asset(
                              AppIcons.delete,
                              scale: 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 0,
                      child: SingleTaskWidget(
                        singleTaskModel: tasks[index],
                      ),
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
        onVerticalDragUpdate: (DragUpdateDetails dets) => _movePanel(),
        onVerticalDragEnd: (DragEndDetails dets) => _movePanel(),
        onVerticalDragStart: (DragStartDetails dets) => _movePanel(),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 150.0, right: 150, top: 10, bottom: 30),
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

  Widget todoButton() {
    return widget.isPanelOpen
        ? InkWell(
            onTap: widget.panelController.close,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: const [
                Icon(Icons.keyboard_arrow_down),
                SizedBox(
                  width: 5,
                ),
                Text(
                  TestStrings.toDo,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        : const SizedBox(
            height: 22,
          );
  }

  void _movePanel() {
    widget.panelController.isPanelOpen
        ? setState(() {
            widget.panelController.close();
          })
        : setState(() {
            widget.panelController.open();
          });
  }

  void _undo(List tasks, int index) {
    Duration duration = const Duration(seconds: 5);
    Widget deletedItem = tasks.removeAt(index);
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return TweenAnimationBuilder<Duration>(
            duration: duration,
            tween: Tween(begin: duration, end: Duration.zero),
            onEnd: () {
              Navigator.of(context).pop(true);
            },
            builder: (BuildContext context, Duration value, Widget? child) {
              final seconds = value.inSeconds % 60;
              return CupertinoAlertDialog(
                title: Text('The task will be deleted in $seconds seconds'),
                actions: <CupertinoDialogAction>[
                  CupertinoDialogAction(
                      child: const Text('Undo'),
                      onPressed: () {
                        setState(
                          () {
                            tasks = tasks..insert(index, deletedItem);
                          },
                        );
                        Navigator.of(context).pop();
                      }),
                  CupertinoDialogAction(
                      isDestructiveAction: true,
                      child: const Text('Delete'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ],
              );
            });
      },
    );
  }
}
