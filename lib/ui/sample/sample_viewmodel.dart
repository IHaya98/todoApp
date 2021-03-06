import 'package:flutter/foundation.dart';

class SampleViewModel extends ChangeNotifier {
  // <-- extends ChangeNotifier
  int _counter = 0;
  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners(); // <-- notify listeners
  }
}
