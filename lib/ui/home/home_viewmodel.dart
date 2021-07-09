import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/repository/fs_todo.dart';

class HomeViewModel extends ChangeNotifier {
  String _title = '';
  String get title => _title;
  set title(String value) => _title = value;

  String _detail = '';
  String get detail => _detail;
  set detail(String value) => _detail = value;

  HomeViewModel() {}
  HomeViewModel.set(title, detail) {
    this._title = title;
    this._detail = detail;
  }
}

class HomeViewModelList extends ChangeNotifier {
  List<HomeViewModel> _todoList = [];
  List<HomeViewModel> get todoList => _todoList;
  set todoList(List<HomeViewModel> value) => _todoList = value;

  void readTodoList(List<HomeViewModel> todoList, BuildContext context) async {
    await FSTodo().readTodo(todoList, context);
    notifyListeners();
  }
}
