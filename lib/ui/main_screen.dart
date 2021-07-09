import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/ui/home/home_screen.dart';
import 'package:todo_app/ui/sample/sample_screen.dart';
import 'package:todo_app/ui/user/user_screen.dart';
import 'package:todo_app/ui/util/bottom_nav_view.dart';
import 'package:todo_app/ui/util/drawer_view.dart';
import 'package:todo_app/ui/util/provider.dart';

// Since the state was moved to the view model, this is now a StatelessWidget.
class MainScreen extends StatelessWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => MainScreen(),
    );
  }

  static List<Widget> _pageList = [
    HomeScreen(),
    SampleScreen(),
    UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (context, watch, child) {
            return Text(watch(buttomNavProvider).title == ''
                ? 'ホーム'
                : watch(buttomNavProvider).title);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read(todoListProvider).readTodoList([], context);
            },
            child: Text('更新する'),
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
          ),
        ],
      ),
      drawer: DrawerView(),
      body: Consumer(builder: (context, watch, child) {
        return _pageList[watch(buttomNavProvider).selectedTabIndex];
      }),
      bottomNavigationBar: BottomNavScreen(),
    );
  }
}
