import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/ui/signin/signin_screen.dart';
import 'package:todo_app/ui/util/provider.dart';
import 'package:uuid/uuid.dart';

class FSUser {
  final _fs_user = FirebaseFirestore.instance.collection('user');

  Future<void> registUser(String mail, String user_name, BuildContext context) {
    String id = Uuid().v1();
    return _fs_user
        .doc(id)
        .set({
          'id': id,
          'mail': mail,
          'user_name': user_name,
          'created_dt': Timestamp.now()
        })
        .then((value) => {
              context.read(userProvider).user_id = id,
              context.read(userProvider).user_name = user_name,
              context.read(userProvider).mail = mail,
              Navigator.of(context).pop(
                SigninScreen.route(),
              ),
            })
        .catchError((error) => print(error));
  }

  //未使用
  Future<void> readUser(String? mail, BuildContext context) {
    if (mail == null) {
      mail = context.read(userProvider).mail;
    }
    QueryDocumentSnapshot<Object?> data;
    return _fs_user
        .where('mail', isEqualTo: mail)
        .get()
        .then(
          (QuerySnapshot snapshot) => {
            data = snapshot.docs[0],
            context.read(userProvider).user_id = data['id'],
            context.read(userProvider).user_name = data['user_name'],
            context.read(userProvider).mail = data['mail'],
          },
        )
        .catchError((error) => print(error));
  }
}
