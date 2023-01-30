import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/consts/strings.dart';
import 'package:todo_app_main_screen/models/settings_model.dart';
import 'package:todo_app_main_screen/ui/screens/language_page.dart';

List<Settings> settingsList = [
  Settings(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            SettingsStrings.aboutUs,
            style: TextStyle(
                fontSize: 19, fontWeight: FontWeight.w600, color: darkColor),
          ),
          Image.asset(
            AppIcons.link,
            scale: 3,
          )
        ],
      ),
      '',
      'https://flutter.dev/'),
  Settings(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            SettingsStrings.language,
            style: TextStyle(
                fontSize: 19, fontWeight: FontWeight.w600, color: darkColor),
          ),
          Text(
            'English',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.normal,
                color: paleTextColor),
          )
        ],
      ),
      LanguagePage.routeName,
      ''),
  Settings(
      const Text(
        SettingsStrings.report,
        style: TextStyle(
            fontSize: 19, fontWeight: FontWeight.w600, color: darkColor),
      ),
      '',
      ''),
  Settings(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            SettingsStrings.termsOfUsing,
            style: TextStyle(
                fontSize: 19, fontWeight: FontWeight.w600, color: darkColor),
          ),
          Image.asset(
            AppIcons.link,
            scale: 3,
          )
        ],
      ),
      '',
      'https://flutter.dev/'),
  Settings(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            SettingsStrings.privacyPolicy,
            style: TextStyle(
                fontSize: 19, fontWeight: FontWeight.w600, color: darkColor),
          ),
          Image.asset(
            AppIcons.link,
            scale: 3,
          )
        ],
      ),
      '',
      'https://flutter.dev/')
];
