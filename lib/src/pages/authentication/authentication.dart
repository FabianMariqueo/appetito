import 'package:appetito/src/pages/authentication/sign_in.dart';
import 'package:appetito/src/pages/authentication/sign_up.dart';
import 'package:flutter/cupertino.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showSingnIn = true;

  // Intercambiar entre Login y registro
  void toogleView() {
    setState(() {
      showSingnIn = !showSingnIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSingnIn) {
      return SignInPage(toogleView: toogleView);
    } else {
      return SignUpPage(toogleView: toogleView);
    }
  }
}
