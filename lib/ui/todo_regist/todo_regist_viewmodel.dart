import 'package:flutter/foundation.dart';

class TodoRegistViewModel extends ChangeNotifier {
  // <-- extends ChangeNotifier
  String _title = '';
  String get title => _title;
  set title(String value) => _title = value;

  String _detail = '';
  String get detail => _detail;
  set detail(String value) => _detail = value;
}
