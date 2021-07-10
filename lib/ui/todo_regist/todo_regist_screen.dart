import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/repository/fs_todo.dart';
import 'package:todo_app/ui/util/provider.dart';

// Since the state was moved to the view model, this is now a StatelessWidget.
class TodoRegistScreen extends StatelessWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => TodoRegistScreen(),
      fullscreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新規'),
        actions: [
          TextButton(
            onPressed: () {
              FSTodo().registTodo(context.read(todoRegistProvider).title,
                  context.read(todoRegistProvider).detail, context);
            },
            child: Text('追加する'),
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'タイトル'),
              validator: (value) => value!.isEmpty ? 'タイトルは必須項目' : null,
              onChanged: (value) =>
                  context.read(todoRegistProvider).title = value,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'TODO',
                hintText: '何をする？',
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              validator: (value) => value!.isEmpty ? 'Todoは必須項目' : null,
              onChanged: (value) =>
                  context.read(todoRegistProvider).detail = value,
            ),
          ],
        ),
      ),
    );
  }
}
