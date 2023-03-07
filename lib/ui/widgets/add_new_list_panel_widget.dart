import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:todo_app_main_screen/models/list_model.dart';
import 'package:todo_app_main_screen/sample_data/sample_data.dart';
import 'package:todo_app_main_screen/ui/widgets/panel_close_widget.dart';

import 'black_button_widget.dart';

class AddNewListPanelWidget extends StatefulWidget {
  final double height;
  final double width;
  final void Function() onTapClose;

  const AddNewListPanelWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.onTapClose,
  }) : super(key: key);

  @override
  State<AddNewListPanelWidget> createState() => _AddNewListPanelWidgetState();
}

class _AddNewListPanelWidgetState extends State<AddNewListPanelWidget> {
  TextEditingController controller = TextEditingController();

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
            controller: controller,
            style: TextStyle(
              fontSize: 0.018 * widget.height,
            ),
            decoration: InputDecoration(
              hintText: TestStrings.hintTextList,
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
                if (controller.text.isNotEmpty) {
                  setState(() {
                    //sampleLists.insert(sampleLists.length-1,controller.text);
                    sampleLists = sampleLists..add(ListModel(list: controller.text));
                  });
                }
                widget.onTapClose();
              },
              width: widget.width - 50,
              borderRadius: const BorderRadius.all(Radius.elliptical(12, 12)),
              child: const Text(
                TestStrings.createNewList,
                style: TextStyle(color: backgroundColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
