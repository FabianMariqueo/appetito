import 'package:appetito/src/models/user-appetito.dart';
import 'package:appetito/src/pages/app.dart';
import 'package:appetito/src/routes/routes.dart';
import 'package:appetito/src/services/auth.dart';
import 'package:appetito/src/shared/loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
          // Si el status esta aun cargando
          if (snapshot.connectionState == ConnectionState.waiting) {
            return this._loadingApp();
          }

          // Estado listo de la application
          return StreamProvider<UserAppetito>.value(
              value: AuthService().user, child: this._mainApp());
        });
  }

// Widget con la aplicacion principal
  Widget _mainApp() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Appetito',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: AppPage(),
      initialRoute: AppPage.tag,
      routes: getRoutes(),
    );
  }

// Widget con la página cuando está cargando la aplicacion de firebase
  Widget _loadingApp() {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Appetito',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Loading());
  }
}
