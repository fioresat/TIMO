import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/single_task_model.dart';
import 'package:todo_app_main_screen/ui/widgets/main_page_widgets/single_task_widget.dart';

class TasksWidget extends StatefulWidget {
  final bool isPanelOpen;
  final double height;
  final List<SingleTaskModel> tasks;
  final ScrollController controller;
  final PanelController panelController;
  final void Function()? onPressed;
  final bool isMoveToPressed;

  const TasksWidget(
      {Key? key,
      required this.isPanelOpen,
      required this.tasks,
      required this.controller,
      required this.panelController,
      this.onPressed,
      required this.height,
      required this.isMoveToPressed})
      : super(key: key);

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
      padding: const EdgeInsets.only(
        right: 25,
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Center(
                child: widget.isPanelOpen ? Container() : dragHandle(),
              ),
              todoButton(),
            ],
          ),
          SizedBox(
            height: 0.9 * widget.height,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                controller: widget.controller,
                physics: widget.panelController.isPanelOpen
                    ? const AlwaysScrollableScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                //scrollController: widget.controller,
                itemCount: tasks.length,
                //shrinkWrap: true,
                //onReorder: widget.panelController.isPanelOpen ? reorderData : (){},
                itemBuilder: (BuildContext context, int index) {
                  return widget.isMoveToPressed == false
                      ? Slidable(
                          key: ValueKey(tasks[index]),
                          endActionPane: ActionPane(
                            extentRatio: 0.35,
                            dismissible: DismissiblePane(
                              onDismissed: () {
                                setState(() {
                                  _undo(tasks, index);
                                });
                              },
                            ),
                            motion: const ScrollMotion(),
                            children: [
                              CustomSlidableAction(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                ),
                                onPressed: (BuildContext context) {
                                  setState(() {});
                                },
                                child: InkWell(
                                  onTap: widget.onPressed,
                                  child: Image.asset(
                                    AppIcons.moveTo,
                                    scale: 2.9,
                                  ),
                                ),
                              ),
                              CustomSlidableAction(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                ),
                                onPressed: (BuildContext context) {
                                  setState(() {
                                    //ToDo
                                    _undo(tasks, index);
                                  });
                                },
                                child: Image.asset(
                                  AppIcons.delete,
                                  scale: 2.9,
                                ),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                            ),
                            child: Card(
                              elevation: 0,
                              child: SingleTaskWidget(
                                singleTaskModel: widget.tasks[index],
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                            left: 25,
                          ),
                          child: Card(
                            elevation: 0,
                            child: SingleTaskWidget(
                              singleTaskModel: widget.tasks[index],
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
        onVerticalDragEnd: (DragEndDetails details) => _movePanel(),
        onVerticalDragStart: (DragStartDetails details) => _movePanel(),
        onVerticalDragDown: (DragDownDetails details) => _movePanel(),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 150.0, right: 150, top: 10, bottom: 20),
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
        ? Padding(
            padding: const EdgeInsets.only(left: 25, top: 15),
            child: InkWell(
              onTap: widget.panelController.close,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    AppIcons.arrowClose,
                    scale: 3,
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  const Text(
                    TestStrings.toDo,
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ],
              ),
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

  void _undo(List<SingleTaskModel> tasks, int index) {
    Duration duration = const Duration(seconds: 5);
    SingleTaskModel deletedItem = tasks.removeAt(index);
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return TweenAnimationBuilder<Duration>(
            duration: duration,
            tween: Tween(begin: duration, end: Duration.zero),
            onEnd: () {
              _deleteTask(oldTask: deletedItem);
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
                        _deleteTask(oldTask: deletedItem);
                        Navigator.of(context).pop();
                      }),
                ],
              );
            });
      },
    );
  }

  Future<void> _deleteTask({
    required SingleTaskModel oldTask,
  }) async {
    db
        .collection("users")
        .doc(oldTask.userID)
        .collection('lists')
        .doc(oldTask.listID)
        .collection('tasks')
        .doc(oldTask.taskID)
        .delete()
        .then(
          (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
  }
}
