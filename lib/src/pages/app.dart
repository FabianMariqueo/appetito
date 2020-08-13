import 'package:appetito/src/models/user.dart';
import 'package:appetito/src/pages/home/home.dart';
import 'package:appetito/src/pages/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppPage extends StatelessWidget {
  static String tag = '/';

  @override
  Widget build(BuildContext context) {
    // Datos del usuario logeado
    final user = Provider.of<User>(context);

    if(user == null){
      return SignInPage();
    }else {
      return HomePage();
    }

  }
}
