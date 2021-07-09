import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/repository/fs_todo.dart';
import 'package:todo_app/ui/todo_regist/todo_regist_screen.dart';
import 'package:todo_app/ui/util/provider.dart';
import 'home_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(builder: (context, watch, child) {
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              var todo = watch(todoListProvider).todoList[index];
              return ListTile(
                title: Text(todo.title),
                subtitle: Text(todo.detail),
              );
            },
            separatorBuilder: (context, index) => Divider(color: Colors.black),
            itemCount: watch(todoListProvider).todoList.length,
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            TodoRegistScreen.route(),
          );
        },
        child: Icon(Icons.add_circle_outline),
      ),
    );
  }
}
