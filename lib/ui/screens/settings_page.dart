import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/consts/colors.dart';
import 'package:todo_app_main_screen/generated/l10n.dart';
import 'package:todo_app_main_screen/main.dart';
import 'package:todo_app_main_screen/ui/screens/language_page.dart';
import 'package:todo_app_main_screen/ui/screens/premium_page.dart';
import 'package:todo_app_main_screen/ui/widgets/language_page_widgets/language_list.dart';
import 'package:todo_app_main_screen/ui/widgets/settings_page_widgets/settings_widget.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings_page';

  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: heightScreen * 0.017,
            top: heightScreen * 0.060,
            left: 25,
            right: 25,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ExpandTapWidget(
                    tapPadding: const EdgeInsets.all(50.0),
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      AppIcons.close,
                      scale: 3,
                    ),
                  ),
                  Text(
                    S.of(context).settings,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: darkColor,
                    ),
                  ),
                  SizedBox(
                    width: widthScreen * 0.1,
                  )
                ],
              ),
              SizedBox(
                height: heightScreen * 0.06,
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(
                  context,
                  PremiumPage.routeName,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/banner.png',
                    scale: 3,
                  ),
                ),
              ),
              // SizedBox(
              //   height: 0.9 * heightScreen,
              //   child: ListView.separated(
              //       shrinkWrap: true,
              //       itemBuilder: (context, index) {
              //
              //         return settingsList[index];
              //       },
              //       separatorBuilder: (context, index) {
              //         return const Divider();
              //       },
              //       itemCount: settingsList.length),
              // ),
              SizedBox(
                height: 0.9 * heightScreen,
                child: ListView(
                  children: [
                    SettingsWidget(
                      route: '',
                      url: 'https://flutter.dev/',
                      title: S.of(context).aboutUs,
                      trailing: settingsImage,
                    ),
                    SettingsWidget(
                      route: LanguagePage.routeName,
                      url: '',
                      title: S.of(context).language,
                      trailing: Text(
                        currentUser.locale >= 0
                            ? languageList[currentUser.locale].name
                            : '',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          color: paleTextColor,
                        ),
                      ),
                    ),
                    SettingsWidget(
                      route: '',
                      url: '',
                      title: S.of(context).reportProblem,
                      trailing: Container(),
                    ),
                    SettingsWidget(
                      route: '',
                      url: 'https://flutter.dev/',
                      title: S.of(context).termsOfUsing,
                      trailing: settingsImage,
                    ),
                    SettingsWidget(
                      route: '',
                      url: 'https://flutter.dev/',
                      title: S.of(context).privacyPolicy,
                      trailing: settingsImage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
