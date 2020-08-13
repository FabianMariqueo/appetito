import 'dart:math';

import 'package:appetito/src/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class SignInPage extends StatefulWidget {
  static String tag = '/signin';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  static String tag = '/signin';

  String _password;

  // Servicio de Authentication
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text("Appetito"), Text("Login"), _loginInput()],
        ),
      ),
    );
  }

  Widget _loginInput() {
    return Center(
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          width: min(constraints.maxWidth, 600),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 32.0),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Ingrese su usuario o email',
                    icon: const Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: const Icon(Icons.person))),
                validator: (val) =>
                    val.length < 6 ? 'Password too short.' : null,
                onSaved: (val) => _password = val,
                obscureText: true,
              ),
              new TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Password',
                    icon: const Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: const Icon(Icons.lock))),
                validator: (val) =>
                    val.length < 6 ? 'Password too short.' : null,
                onSaved: (val) => _password = val,
                obscureText: true,
              ),
              RaisedButton(
                onPressed: () async {
                  dynamic result = await _authService.signInAnon();
                  print(result);
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: const Text('Gradient Button',
                      style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
