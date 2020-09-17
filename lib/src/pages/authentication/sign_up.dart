import 'dart:math';

import 'package:appetito/src/models/user-appetito.dart';
import 'package:appetito/src/services/auth.dart';
import 'package:appetito/src/shared/loading.dart';
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
  final UserAppetito _user = UserAppetito();

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
                  _backButton(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img/logo.png',
                        height: 100,
                        width: 100,
                      ),
                      Text(
                        "Registro",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  _registerInput(),
                  //const SizedBox(height: 10.0),
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
            padding: const EdgeInsets.all(40.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //const SizedBox(height: 32.0),
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
                        labelText: 'Contraseña',
                        icon: const Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: const Icon(Icons.lock))),
                    validator: (val) =>
                        val.length < 6 ? 'Contraseña muy corta.' : null,
                    onChanged: (val) {
                      setState(() => _user.password = val);
                    },
                    obscureText: true,
                  ),
                  const SizedBox(height: 20.0),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            this._loading = true;
                            dynamic result = _authService
                                .registerWithEmailAndPassword(_user);
                            if (result == null) {
                              print("Error");
                              this._loading = false;
                            }
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Colors.amber,
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            //color: Colors.amber,
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 60.0),
                          child: const Text('Registrar',
                              style: TextStyle(fontSize: 15)),
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

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Atrás',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
}
