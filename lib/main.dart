import 'package:flutter/material.dart';
import 'package:todo_app/ui/main_screen.dart';
import 'package:todo_app/ui/signin/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/repository/fb_auth.dart';
import 'package:todo_app/ui/util/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.length == 0) {
    await Firebase.initializeApp();
  }

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _loggedIn = FBAuth().checkAuth();
    final FirstScreen = _loggedIn ? MainScreen() : SigninScreen();
    return Consumer(builder: (context, watch, child) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: watch(themeProvider).current,
        home: FirstScreen,
      );
    });
  }
}
