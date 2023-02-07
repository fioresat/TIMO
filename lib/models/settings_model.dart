import 'package:flutter/material.dart';

class SettingsModel {
  final String route;
  final Widget widget;
  final String url;

  SettingsModel({
    required this.widget,
    required this.route,
    required this.url,
  });
}
