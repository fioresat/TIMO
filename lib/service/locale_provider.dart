import 'package:flutter/material.dart';
import 'package:todo_app_main_screen/l10n/locales.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale =  const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!Locales.allLocales.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }
}