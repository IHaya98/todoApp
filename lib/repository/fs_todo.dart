import 'package:uuid/uuid.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/home/home_viewmodel.dart';
import 'package:todo_app/ui/main_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/ui/util/provider.dart';

class FSTodo {
  final _fs_todo = FirebaseFirestore.instance.collection('todo');

  Future<void> registTodo(String id, String title, String detail,
      DateTime? date, String? category, BuildContext context) {
    if (id == '') {
      id = Uuid().v1();
    }
    return _fs_todo
        .doc(id)
        .set({
          'id': id,
          'user_id': context.read(userProvider).user_id,
          'title': title,
          'detail': detail,
          'deadline': date,
          'category': category,
          'created_dt': Timestamp.now()
        })
        .then((value) => {
              context.read(todoRegistProvider).title = '',
              context.read(todoRegistProvider).detail = '',
              context.read(todoRegistProvider).date = DateTime.now(),
              context.read(todoRegistProvider).category = '',
              Navigator.of(context).pop(
                MainScreen.route(),
              ),
            })
        .catchError((error) => print(error));
  }

  //未使用
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

  Future<void> deleteTodo(String id, BuildContext context) {
    if (id == null) {
      print("ID IS NULL");
    }
    return _fs_todo
        .doc(id)
        .delete()
        .then((value) => print("Todo Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
