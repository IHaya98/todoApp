import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/repository/fb_auth.dart';
import 'package:todo_app/ui/util/provider.dart';

// Since the state was moved to the view model, this is now a StatelessWidget.
class DrawerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 60,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'メニュー',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text('test'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('ログアウト'),
            trailing: Icon(Icons.logout),
            onTap: () {
              // Update the state of the app.
              FBAuth().signOut(context);
            },
          ),
          Consumer(
            builder: (context, watch, child) {
              return new SwitchListTile(
                value: watch(themeProvider).isDark,
                title: Text('ダークモード'),
                onChanged: (value) => {context.read(themeProvider).toggle()},
              );
            },
          ),
        ],
      ),
    );
  }
}
