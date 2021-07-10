import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/repository/fs_todo.dart';
import 'package:todo_app/ui/todo_regist/todo_regist_screen.dart';

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
        child: buildTodoList(),
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

  Widget buildTodoList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('todo')
          .orderBy('created_dt', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: const CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        return ListView(
          children: snapshot.data!.docs.map(
            (DocumentSnapshot document) {
              final data = document.data()! as Map<String, dynamic>;
              return Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.album),
                      title: Text('${data['title']}'),
                      subtitle: Text('${data['detail']}'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text('更新する'),
                          style: TextButton.styleFrom(
                            primary: Colors.blue,
                          ),
                        ),
                        SizedBox(width: 20),
                        TextButton(
                          onPressed: () {
                            FSTodo().deleteTodo(data['id'], context);
                          },
                          child: Text('削除する'),
                          style: TextButton.styleFrom(
                            primary: Colors.blue,
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    )
                  ],
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
