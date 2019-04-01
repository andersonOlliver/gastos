import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gastos/auth/auth.dart';
import 'package:gastos/pages/root_page.dart';

Future main() async {
  final FirebaseApp app = await FirebaseApp.configure(
      name: 'testeDB',
      options: const FirebaseOptions(
          googleAppID: '1:675557176654:android:4972b2e951fc151b',
          apiKey: 'AIzaSyBTsAH82CJnW5N6oDiB7M9vDyUQ812ebAk',
          databaseURL: 'https://teste-asdf.firebaseio.com'));
  runApp(MyApp(
    app: app,
  ));
}

class MyApp extends StatelessWidget {
  final FirebaseApp app;

  const MyApp({Key key, this.app}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Firebase Auth Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new RootPage(
          auth: new Auth(),
          app: app,
        ));
  }
}
