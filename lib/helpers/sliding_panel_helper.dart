import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todo_app_main_screen/ui/style.dart';
import 'package:todo_app_main_screen/ui/widgets/add_new_list_panel_widget.dart';
import 'package:todo_app_main_screen/ui/widgets/reminder_panel_widget.dart';

class SlidingPanelHelper {
  void onPressedShowBottomSheet(Widget child, BuildContext context) {
    showMaterialModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: commonBorderRadius,
      ),
      enableDrag: false,
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: child,
      ),
    );
  }

  void onAddNewListPressed(double widthScreen, double heightScreen,
      BuildContext context, TextEditingController controller) {
    onPressedShowBottomSheet(
        AddNewListPanelWidget(
          height: heightScreen,
          onTapClose: () {
            Navigator.of(context).pop();
          },
          width: widthScreen,
          controller: controller,
        ),
        context);
  }

  void onReminderTap(
      double widthScreen, double heightScreen, BuildContext context) {
    onPressedShowBottomSheet(
        ReminderPanelWidget(
          height: heightScreen,
          onTap: () {
            Navigator.of(context).pop();
          },
          width: widthScreen,
        ),
        context);
  }
}
