import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Since the state was moved to the view model, this is now a StatelessWidget.
class BottomNavScreen extends StatelessWidget {
  late ChangeNotifierProvider<ButtomNavViewModel> buttomNavProvider;
  BottomNavScreen(
      ChangeNotifierProvider<ButtomNavViewModel> buttomNavProvider) {
    this.buttomNavProvider = buttomNavProvider;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '検索',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            label: 'ユーザー',
          ),
        ],
        currentIndex: watch(buttomNavProvider).selectedTabIndex,
        onTap: context.read(buttomNavProvider).onTabTapped,
      );
    });
  }
}

class ButtomNavViewModel extends ChangeNotifier {
  // <-- extends ChangeNotifier
  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;

  void onTabTapped(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }
}
