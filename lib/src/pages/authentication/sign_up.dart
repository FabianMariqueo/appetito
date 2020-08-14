import 'dart:math';

import 'package:appetito/src/models/user.dart';
import 'package:appetito/src/services/auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  static String tag = '/signup';
  final Function toogleView;

  SignUpPage({this.toogleView});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _password;

  // Servicio de Authentication
  final AuthService _authService = AuthService();

  // Validar formulario
  final _formKey = GlobalKey<FormState>();

  // Modelo de datos para el usuario
  final User _user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Appetito"),
            Text("Registro"),
            _registerInput(),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("¿Ya tienes una cuenta?"),
                FlatButton(
                  onPressed: () {
                    widget.toogleView();
                  },
                  child: Text(
                    "Ingresar",
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _registerInput() {
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
                    validator: (val) =>
                        val.isEmpty ? 'Complete el Email' : null,
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
                        val.length < 6 ? 'Password muy corta.' : null,
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
                            dynamic result = _authService
                                .registerWithEmailAndPassword(_user);
                            if (result == null) {
                              print("Error");
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
                          child: const Text('Registrar',
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
