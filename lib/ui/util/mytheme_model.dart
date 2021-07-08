import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyThemeModel extends ChangeNotifier {
  ThemeData current = ThemeData.light();
  bool _isDark = false;
  bool get isDark => _isDark;
  toggle() {
    _isDark = !_isDark;
    current = _isDark ? ThemeData.dark() : ThemeData.light();
    notifyListeners();
  }
}
