import 'dart:math';

import 'package:appetito/src/models/user.dart';
import 'package:appetito/src/services/auth.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  static String tag = '/signin';

  final Function toogleView;

  SignInPage({this.toogleView});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  static String tag = '/signin';

  // Servicio de Authentication
  final AuthService _authService = AuthService();
  // Modelo de datos del usuario
  final User _user = User();
  // Validar formulario
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Appetito"),
            Text("Login"),
            _loginInput(),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("¿No tienes una cuenta?"),
                FlatButton(
                  onPressed: () {
                    widget.toogleView();
                  },
                  child: Text(
                    "Registrarse",
                  ),
                )
              ],
            )
          ],
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
            child: Form(
              key: _formKey,
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
                    onSaved: (val) => _user.email = val,
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
                    onSaved: (val) => _user.password = val,
                    obscureText: true,
                  ),
                  const SizedBox(height: 10.0),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 25.0),
                          child: const Text('Ingresar',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ));
      }),
    );
  }
}
