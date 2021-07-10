# todo_app

A new Flutter project.

## Getting Started
Firebaseのプロジェクト作成
https://firebase.flutter.dev/docs/overview/

スプラッシュ画面を作成する
pubspec.ymlに下記を設定してコマンドを入力する
flutter_native_splash:
  image: "assets/icon/emo_5.png"
  color: "4DD0E1"
・作成
flutter pub get
flutter pub run flutter_native_splash:create
・削除
flutter pub run flutter_native_splash:remove