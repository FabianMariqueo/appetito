import 'package:appetito/src/pages/app.dart';
import 'package:appetito/src/pages/authentication/sign_in.dart';
import 'package:appetito/src/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:appetito/src/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:appetito/src/models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
          title: 'Appetito',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          //home: AppPage(),
          initialRoute: AppPage.tag,
          routes: getRoutes(),
        ));
  }
}
