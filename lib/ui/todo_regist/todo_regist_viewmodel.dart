import 'package:flutter/foundation.dart';

class TodoRegistViewModel extends ChangeNotifier {
  // <-- extends ChangeNotifier
  String _title = '';
  String get title => _title;
  set title(String value) => _title = value;

  String _detail = '';
  String get detail => _detail;
  set detail(String value) => _detail = value;

  String _category = '';
  String get category => _category;
  set category(String value) => _category = value;

  late DateTime _date = DateTime.now();
  DateTime get date => _date;
  set date(DateTime value) => {
        _date = value,
        notifyListeners(),
      };
}
