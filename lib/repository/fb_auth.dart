import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/repository/fs_user.dart';
import 'package:todo_app/ui/main_screen.dart';
import 'package:todo_app/ui/signin/signin_screen.dart';
import 'package:todo_app/ui/sample/sample_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/ui/util/provider.dart';

class FBAuth {
  final _auth = FirebaseAuth.instance;

  Future<void> signUp(String email, String user_name, String password,
      BuildContext context) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user != null) {
        await FSUser().registUser(email, user_name, context);
        Navigator.of(context).push(
          SigninScreen.route(),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user != null) {
        await FSUser().readUser(email, context);
        Navigator.of(context).pushReplacement(
          MainScreen.route(),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context).pushReplacement(
      SigninScreen.route(),
    );
  }

  Future<bool> checkAuth(BuildContext context) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      return false;
    } else {
      await FSUser().readUser(currentUser.email, context);
      return true;
    }
  }
}
