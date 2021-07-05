import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/repository/fb_auth.dart';
import 'package:todo_app/ui/signup/signup_screen.dart';
import 'signin_viewmodel.dart';

// Since the state was moved to the view model, this is now a StatelessWidget.
class SigninScreen extends StatelessWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => SigninScreen(),
    );
  }

  // StateProviderを使い受け渡すデータを定義する
// ※ Providerの種類は複数あるが、ここではデータを更新できるStateProviderを使う
  final signinProvider = ChangeNotifierProvider(
    (ref) => SigninViewModel(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ログイン'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) => value!.isEmpty ? 'Eメールは必須項目' : null,
            onChanged: (value) => context.read(signinProvider).email = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
            validator: (value) => value!.isEmpty ? 'パスワードは必須項目' : null,
            onChanged: (value) => context.read(signinProvider).password = value,
            obscureText: true,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: ElevatedButton(
              child: const Text('ログイン'),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                FBAuth().signIn(context.read(signinProvider).email,
                    context.read(signinProvider).password, context);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: ElevatedButton(
              child: const Text('新規登録'),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  SignupScreen.route(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
