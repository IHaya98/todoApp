import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/ui/util/drawer_view.dart';

// Since the state was moved to the view model, this is now a StatelessWidget.
class ButtomNavScreen extends StatelessWidget {
  final buttomNavProvider = ChangeNotifierProvider(
    (ref) => ButtomNavViewModel(),
  );

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
