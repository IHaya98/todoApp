import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/ui/home/home_screen.dart';
import 'package:todo_app/ui/sample/sample_screen.dart';
import 'package:todo_app/ui/user/user_screen.dart';
import 'package:todo_app/ui/util/buttom_nav_view.dart';
import 'package:todo_app/ui/util/drawer_view.dart';

// Since the state was moved to the view model, this is now a StatelessWidget.
class MainScreen extends StatelessWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => MainScreen(),
    );
  }

  final buttomNavProvider = ChangeNotifierProvider(
    (ref) => ButtomNavViewModel(),
  );

  static List<Widget> _pageList = [
    HomeScreen(),
    SampleScreen(),
    UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sample'),
      ),
      drawer: DrawerView(),
      body: _pageList[context.read(buttomNavProvider).selectedTabIndex],
      bottomNavigationBar: ButtomNavScreen(),
    );
  }
}
