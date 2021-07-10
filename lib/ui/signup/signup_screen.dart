import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/repository/fb_auth.dart';
import 'signup_viewmodel.dart';

// Since the state was moved to the view model, this is now a StatelessWidget.
class SignupScreen extends StatelessWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => SignupScreen(),
    );
  }

  // StateProviderを使い受け渡すデータを定義する
// ※ Providerの種類は複数あるが、ここではデータを更新できるStateProviderを使う
  final signupProvider = ChangeNotifierProvider(
    (ref) => SignupViewModel(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新規登録'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) => value!.isEmpty ? 'Eメールは必須項目' : null,
            onChanged: (value) => context.read(signupProvider).email = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Username'),
            validator: (value) => value!.isEmpty ? 'ユーザー名は必須項目' : null,
            onChanged: (value) =>
                context.read(signupProvider).user_name = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
            validator: (value) => value!.isEmpty ? 'パスワードは必須項目' : null,
            onChanged: (value) => context.read(signupProvider).password = value,
            obscureText: true,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: ElevatedButton(
              child: const Text('登録'),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                FBAuth().signUp(
                    context.read(signupProvider).email,
                    context.read(signupProvider).user_name,
                    context.read(signupProvider).password,
                    context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
