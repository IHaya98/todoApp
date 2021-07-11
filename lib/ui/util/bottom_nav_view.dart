import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/ui/util/provider.dart';

// Since the state was moved to the view model, this is now a StatelessWidget.
class BottomNavScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      return SizedBox(
        height: 100,
        child: BottomNavigationBar(
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
              icon: Icon(Icons.favorite),
              label: 'お気に入り',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle),
              label: 'ユーザー',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: watch(buttomNavProvider).selectedTabIndex,
          onTap: context.read(buttomNavProvider).onTabTapped,
        ),
      );
    });
  }
}

class ButtomNavViewModel extends ChangeNotifier {
  // <-- extends ChangeNotifier
  int _selectedTabIndex = 0;
  String _title = '';
  int get selectedTabIndex => _selectedTabIndex;
  String get title => _title;

  void onTabTapped(int index) {
    _selectedTabIndex = index;
    switch (index) {
      case 0:
        _title = 'ホーム';
        break;
      case 1:
        _title = '検索';
        break;
      case 2:
        _title = 'お気に入り';
        break;
      case 3:
        _title = 'ユーザー';
        break;
    }
    notifyListeners();
  }
}
