import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/repository/fs_todo.dart';
import 'package:todo_app/ui/todo_regist/todo_regist_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/ui/util/provider.dart';

class SearchScreen extends StatelessWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => SearchScreen(),
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
            TodoRegistScreen.route(context),
          );
        },
        child: Icon(Icons.add_circle_outline),
      ),
    );
  }

  Widget buildTodoList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('todo').snapshots(),
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
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            final data = document.data()! as Map<String, dynamic>;
            return Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Icon(Icons.task),
                      title: Text('${data['title']}'),
                      subtitle: Text('${data['detail']}'),
                    ),
                    SizedBox(height: 12),
                    Text(
                        '締切日：${DateFormat("yyyy年MM月dd日").format(data['deadline'].toDate())}'),
                    SizedBox(height: 12),
                    Text('カテゴリー：${data['category']}'),
                    SizedBox(height: 12),
                    Text(
                        'by ${data['user_id'] == context.read(userProvider).user_id ? context.read(userProvider).user_name : ''}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FavoriteButton(data),
                        SizedBox(width: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              TodoRegistScreen.route_update(
                                context,
                                data['id'],
                                data['title'],
                                data['detail'],
                                data['deadline'],
                                data['category'],
                              ),
                            );
                          },
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
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget FavoriteButton(Map<String, dynamic> data) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('todo')
          .doc(data['id'])
          .collection('favorite')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot_detail) {
        if (!snapshot_detail.hasData) {
          return const Center(
            child: const CircularProgressIndicator(),
          );
        }
        if (snapshot_detail.hasError) {
          return const Text('Something went wrong');
        }
        bool isFavorite = false;
        int favoriteCount = 0;
        snapshot_detail.data!.docs.map((DocumentSnapshot document_detail) {
          final data_test = document_detail.data()! as Map<String, dynamic>;
          favoriteCount++;
          if (!isFavorite) {
            isFavorite =
                data_test['user_id'] == context.read(userProvider).user_id;
          }
        }).toList();
        return ElevatedButton.icon(
          icon: Icon(
            Icons.favorite,
            color: isFavorite ? Colors.red : Colors.black,
          ),
          label: Text('${favoriteCount.toString()}'),
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: isFavorite ? Colors.red : Colors.black,
          ),
          onPressed: () {
            isFavorite
                ? FSTodo().deleteFavorite(
                    data['id'], context.read(userProvider).user_id)
                : FSTodo().addFavorite(
                    data['id'], context.read(userProvider).user_id);
          },
        );
      },
    );
  }
}
