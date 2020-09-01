import 'dart:math';

import 'package:appetito/src/models/user.dart';
import 'package:appetito/src/services/auth.dart';
import 'package:appetito/src/shared/loading.dart';
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

  // Indicador loading
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return this._loading
        ? Loading()
        : Scaffold(
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
                  ),
                  _signInWithGoogle()
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
                        labelText: 'Ingrese su Email',
                        icon: const Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: const Icon(Icons.person))),
                    validator: (val) =>
                        val.isEmpty ? 'Complete el Email' : null,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) {
                      setState(() => _user.email = val);
                    },
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Password',
                        icon: const Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: const Icon(Icons.lock))),
                    validator: (val) =>
                        val.length < 6 ? 'Password too short.' : null,
                    onChanged: (val) {
                      setState(() => _user.password = val);
                    },
                    obscureText: true,
                  ),
                  const SizedBox(height: 10.0),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              this._loading = true;
                            });
                            dynamic result =
                                _authService.signInWithEmailAndPassword(_user);
                            if (result == null) {
                              print("Error");
                              this._loading = false;
                            }
                          }
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

  Widget _signInWithGoogle() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        print("Login google");

        setState(() {
          this._loading = true;
        });

        dynamic result = _authService.signInWithGoogle();
        if (result == null) {
          print("Error");
          this._loading = false;
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage("assets/img/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
