import 'dart:math';

import 'package:appetito/src/models/user-appetito.dart';
import 'package:appetito/src/services/auth.dart';
import 'package:appetito/src/shared/loading.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  static String tag = '/signin';

  final Function showSignIn;
  final Function showWelcome;

  SignInPage({this.showSignIn, this.showWelcome});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // Servicio de Authentication
  final AuthService _authService = AuthService();

  // Modelo de datos del usuario
  final UserAppetito _user = UserAppetito();

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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      widget.showWelcome(true);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/logo.png',
                          height: 100,
                          width: 100,
                        ),
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _loginInput(),
                  //const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("¿No tienes una cuenta?"),
                      FlatButton(
                        onPressed: () {
                          widget.showSignIn(false);
                        },
                        child: Text(
                          "Registrate",
                        ),
                      )
                    ],
                  ),
                  _signInWithGoogle(),
                ],
              ),
            ),
          ));
  }

  Widget _loginInput() {
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
                  //const SizedBox(height: 10.0),
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
                            setState(() {
                              this._loading = true;
                            });
                            print(_user);
                            dynamic result = await _authService
                                .signInWithEmailAndPassword(_user);
                            if (result == null) {
                              print("Error");
                              setState(() {
                                this._loading = false;
                              });
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
                          child: const Text('Ingresar',
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
                image: AssetImage("assets/img/google_logo.png"), height: 25.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Ingresa con Google',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
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
