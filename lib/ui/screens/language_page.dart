import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_main_screen/consts/app_icons.dart';
import 'package:todo_app_main_screen/l10n/locales.dart';
import 'package:todo_app_main_screen/service/locale_provider.dart';
import 'package:todo_app_main_screen/ui/widgets/language_page_widgets/language_list.dart';

class LanguagePage extends StatefulWidget {
  static const routeName = '/language_page';

  const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            bottom: heightScreen * 0.017,
            top: heightScreen * 0.060,
            left: 25,
            right: 25),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ExpandTapWidget(
                onTap: () => Navigator.pop(context),
                tapPadding: const EdgeInsets.all(50.0),
                child: Image.asset(
                  AppIcons.back,
                  scale: 3,
                ),
              ),
            ),
            SizedBox(
              height: 0.9 * heightScreen,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var language = languageList[index];
                    return InkWell(
                      onTap: () {
                        final provider = Provider.of<LocaleProvider>(context, listen: false);
                        final locale = Locales.allLocales[index];
                        provider.setLocale(locale);
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset(
                          language.flag,
                          scale: 3,
                        ),
                        title: Text(language.name),
                        trailing: Image.asset(
                          AppIcons.check,
                          scale: 3,
                          color: _selectedIndex == index
                              ? Colors.black
                              : Colors.transparent,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: languageList.length),
            ),
          ],
        ),
      ),
    );
  }
}
