import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/home/home_viewmodel.dart';
import 'package:todo_app/ui/main_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/ui/util/provider.dart';
import 'package:flutter/foundation.dart';

class FSTodo extends ChangeNotifier {
  final _fs_todo = FirebaseFirestore.instance.collection('todo');

  Future<void> registTodo(String title, String detail, BuildContext context) {
    return _fs_todo
        .add({
          'title': title,
          'detail': detail,
        })
        .then((value) => {
              Navigator.of(context).pop(
                MainScreen.route(),
              ),
            })
        .catchError((error) => print(error));
  }

  Future<void> readTodo(List<HomeViewModel> todoList, BuildContext context) {
    return _fs_todo
        .get()
        .then(
          (QuerySnapshot snapshots) => {
            snapshots.docs.forEach(
              (snapshot) => {
                todoList.add(
                  HomeViewModel.set(
                    snapshot['title'],
                    snapshot['detail'],
                  ),
                ),
              },
            ),
            context.read(todoListProvider).todoList = todoList,
            print(todoList),
          },
        )
        .catchError((error) => print(error));
  }
}
