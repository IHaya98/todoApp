import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/ui/home/home_viewmodel.dart';
import 'package:todo_app/ui/todo_regist/todo_regist_viewmodel.dart';
import 'package:todo_app/ui/user/user_viewmodel.dart';
import 'package:todo_app/ui/util/bottom_nav_view.dart';
import 'package:todo_app/ui/util/mytheme_model.dart';

final themeProvider = ChangeNotifierProvider(
  (ref) => MyThemeModel(),
);

final userProvider = ChangeNotifierProvider(
  (ref) => UserViewModel(),
);

final countProvider = ChangeNotifierProvider(
  (ref) => HomeViewModel(),
);

final buttomNavProvider = ChangeNotifierProvider(
  (ref) => ButtomNavViewModel(),
);

final todoRegistProvider = ChangeNotifierProvider(
  (ref) => TodoRegistViewModel(),
);

final todoListProvider = ChangeNotifierProvider(
  (ref) => HomeViewModelList(),
);
