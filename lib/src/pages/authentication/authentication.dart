import 'package:appetito/src/pages/authentication/sign_in.dart';
import 'package:appetito/src/pages/authentication/sign_up.dart';
import 'package:appetito/src/pages/authentication/welcome.dart';
import 'package:flutter/cupertino.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showSingnIn = true;
  bool showWelcome = true;

  // Intercambiar entre Login y registro
  void showSignInPage(bool show) {
    setState(() {
      showSingnIn = show;
    });
  }

  void showWelcomePage(bool show) {
    setState(() {
      showWelcome = show;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showWelcome) {
      return WelcomePage(
          showSignIn: showSignInPage, showWelcome: showWelcomePage);
    } else {
      if (showSingnIn) {
        return SignInPage(
          showSignIn: showSignInPage,
          showWelcome: showWelcomePage,
        );
      } else {
        return SignUpPage(
          showSignIn: showSignInPage,
          showWelcome: showWelcomePage,
        );
      }
    }
  }
}
