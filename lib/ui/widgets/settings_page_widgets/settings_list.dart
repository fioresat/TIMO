import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:todo_app_main_screen/models/settings_model.dart';
import 'package:todo_app_main_screen/ui/screens/language_page.dart';

List<Settings> settingsList = [
  Settings(
    route: '',
    url: 'https://flutter.dev/',
    widget: SettingsWidget(
      title: SettingsStrings.aboutUs,
      trailing: settingsImage,
    ),
  ),
  Settings(
    route: LanguagePage.routeName,
    url: '',
    widget: const SettingsWidget(
      title: SettingsStrings.language,
      trailing: Text(
        'English',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.normal,
          color: paleTextColor,
        ),
      ),
    ),
  ),
  Settings(
    route: '',
    url: '',
    widget: SettingsWidget(
      title: SettingsStrings.report,
      trailing: Container(),
    ),
  ),
  Settings(
    route: '',
    url: 'https://flutter.dev/',
    widget: SettingsWidget(
      title: SettingsStrings.termsOfUsing,
      trailing: settingsImage,
    ),
  ),
  Settings(
    route: '',
    url: 'https://flutter.dev/',
    widget: SettingsWidget(
      title: SettingsStrings.privacyPolicy,
      trailing: settingsImage,
    ),
  ),
];

class SettingsWidget extends StatelessWidget {
  final String title;
  final Widget trailing;

  const SettingsWidget({
    Key? key,
    required this.title,
    required this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: darkColor,
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}

Widget settingsImage = Image.asset(
  AppIcons.link,
  scale: 3,
);


