import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/ui/home/home_viewmodel.dart';
import 'package:todo_app/ui/util/bottom_nav_view.dart';
import 'package:todo_app/ui/util/mytheme_model.dart';

final themeProvider = ChangeNotifierProvider(
  (ref) => MyThemeModel(),
);
// StateProviderを使い受け渡すデータを定義する
// ※ Providerの種類は複数あるが、ここではデータを更新できるStateProviderを使う
final countProvider = ChangeNotifierProvider(
  (ref) => HomeViewModel(),
);

final buttomNavProvider = ChangeNotifierProvider(
  (ref) => ButtomNavViewModel(),
);
