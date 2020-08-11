import 'package:appetito/src/pages/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:appetito/src/pages/app.dart';
import 'package:appetito/src/routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appetito',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: AppPage(),
      initialRoute: SignInPage.tag,
      routes: getRoutes(),
    );
  }
}
