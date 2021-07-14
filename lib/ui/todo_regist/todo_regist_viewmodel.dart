import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/util/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoRegistViewModel extends ChangeNotifier {
  TodoRegistViewModel() {}
  TodoRegistViewModel.init(BuildContext context) {
    context.read(todoRegistProvider).id = '';
    context.read(todoRegistProvider).title = '';
    context.read(todoRegistProvider).detail = '';
    context.read(todoRegistProvider).date = null;
    context.read(todoRegistProvider).category = null;
    notifyListeners();
  }
  TodoRegistViewModel.update(BuildContext context, String id, String title,
      String detail, DateTime date, String category) {
    context.read(todoRegistProvider).id = id;
    context.read(todoRegistProvider).title = title;
    context.read(todoRegistProvider).detail = detail;
    context.read(todoRegistProvider).date = date;
    context.read(todoRegistProvider).category = category;
    notifyListeners();
  }
  String _id = '';
  String get id => _id;
  set id(String value) => _id = value;

  String _title = '';
  String get title => _title;
  set title(String value) => _title = value;

  String _detail = '';
  String get detail => _detail;
  set detail(String value) => _detail = value;

  String? _category = '';
  String? get category => _category;
  set category(String? value) => _category = value;

  DateTime? _date = DateTime.now();
  DateTime? get date => _date;
  set date(DateTime? value) => {
        _date = value,
        notifyListeners(),
      };
}
