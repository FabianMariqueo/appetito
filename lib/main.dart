import 'package:appetito/src/pages/app.dart';
import 'package:appetito/src/pages/authentication/sign_in.dart';
import 'package:appetito/src/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:appetito/src/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:appetito/src/models/user-appetito.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return StreamProvider<UserAppetito>.value(
        value: AuthService().user,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Appetito',
          theme: ThemeData(
            primarySwatch: Colors.amber,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          //home: AppPage(),
          initialRoute: AppPage.tag,
          routes: getRoutes(),
        ));
  }
}
