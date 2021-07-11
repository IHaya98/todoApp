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
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/login.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  const Color(0xffff5500).withOpacity(0.2),
                  const Color(0xff00bbaa).withOpacity(0.8),
                ],
                stops: const [
                  0.0,
                  1.0,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 350,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'xxx@xxx.xxx',
                      icon: Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    validator: (value) => value!.isEmpty ? 'Eメールは必須項目' : null,
                    onChanged: (value) =>
                        context.read(signupProvider).email = value,
                  ),
                ),
                Container(
                  width: 350,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      icon: Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    validator: (value) => value!.isEmpty ? 'ユーザー名は必須項目' : null,
                    onChanged: (value) =>
                        context.read(signupProvider).user_name = value,
                  ),
                ),
                Container(
                  width: 350,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      icon: Icon(
                        Icons.password,
                        color: Colors.white,
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    validator: (value) => value!.isEmpty ? 'パスワードは必須項目' : null,
                    onChanged: (value) =>
                        context.read(signupProvider).password = value,
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 350,
                    height: 50,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
