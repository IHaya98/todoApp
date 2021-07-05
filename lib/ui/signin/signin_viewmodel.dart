import 'package:flutter/foundation.dart';

class SigninViewModel extends ChangeNotifier {
  // <-- extends ChangeNotifier
  String _email = '';
  String _password = '';

  String get email => _email;
  set email(String value) => _email = value;
  String get password => _password;
  set password(String value) => _password = value;
}
