import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/generated/l10n.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/ui/widgets/panel_close_widget.dart';

import 'black_button_widget.dart';

class AddNewListPanelWidget extends StatefulWidget {
  final double height;
  final double width;
  final void Function() onTapClose;
  final TextEditingController controller;

  const AddNewListPanelWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.onTapClose,
    required this.controller,
  }) : super(key: key);

  @override
  State<AddNewListPanelWidget> createState() => _AddNewListPanelWidgetState();
}

class _AddNewListPanelWidgetState extends State<AddNewListPanelWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double keyBoardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Column(
        children: [
          PanelCloseWidget(
            alignment: Alignment.topRight,
            onTapClose: widget.onTapClose,
            image: AppIcons.closeButton,
          ),
          TextField(
            textCapitalization: TextCapitalization.sentences,
            controller: widget.controller,
            style: TextStyle(
              fontSize: 0.018 * widget.height,
            ),
            decoration: InputDecoration(
              hintText: S.of(context).newList,
              hintStyle: TextStyle(
                color: hintTextColor,
                fontSize: 0.018 * widget.height,
              ),
              border: InputBorder.none,
            ),
            scrollPadding: const EdgeInsets.all(20.0),
            autofocus: true,
            keyboardType: TextInputType.multiline,
            maxLines: 2,
            cursorColor: Colors.black,
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: keyBoardHeight > 0 ? keyBoardHeight + 10 : 10),
            child: BlackButtonWidget(
              height: widget.height * 0.05,
              onPressed: () {
                if (widget.controller.text.isNotEmpty) {
                  String listID = UniqueKey().toString();
                  setState(() {
                    currentList = ListModel(
                      list: widget.controller.text,
                      listID: listID,
                    );
                    addNewList(
                      list: currentList,
                    );
                  });
                }
                widget.onTapClose();
              },
              width: widget.width - 50,
              borderRadius: const BorderRadius.all(Radius.elliptical(12, 12)),
              child: Text(
                S.of(context).createNewList,
                style: TextStyle(color: backgroundColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Future<void> _updateLists(String text) async {
  //   final data = <String, dynamic>{};
  //   final docRef =
  //       db.collection("users").doc('testUser').collection('lists').doc(text);
  //   await docRef.set(data);
  // }

  Future<void> addNewList({
    required ListModel list,
  }) async {
    final docRef = db
        .collection("users")
        .doc('testUser')
        .collection('lists')
        .withConverter(
          toFirestore: (ListModel task, options) => task.toFirestore(),
          fromFirestore: ListModel.fromFirestore,
        )
        .doc(list.listID);
    await docRef.set(list);
  }
}
