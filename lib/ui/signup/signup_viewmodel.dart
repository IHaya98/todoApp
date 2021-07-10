import 'package:flutter/foundation.dart';

class SignupViewModel extends ChangeNotifier {
  // <-- extends ChangeNotifier
  String _email = '';
  String _user_name = '';
  String _password = '';

  String get email => _email;
  set email(String value) => _email = value;
  String get user_name => _user_name;
  set user_name(String value) => _user_name = value;
  String get password => _password;
  set password(String value) => _password = value;
}
