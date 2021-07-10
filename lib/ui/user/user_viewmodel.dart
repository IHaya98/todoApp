import 'package:flutter/foundation.dart';

class UserViewModel extends ChangeNotifier {
  // <-- extends ChangeNotifier
  int _counter = 0;
  int get counter => _counter;

  String _user_id = '';
  String get user_id => _user_id;
  set user_id(String value) => _user_id = value;

  String _user_name = '';
  String get user_name => _user_name;
  set user_name(String value) => _user_name = value;

  String _mail = '';
  String get mail => _mail;
  set mail(String value) => _mail = value;

  void increment() {
    _counter++;
    notifyListeners(); // <-- notify listeners
  }
}
