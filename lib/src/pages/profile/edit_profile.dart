import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appetito/src/models/user-appetito.dart';
import 'package:appetito/src/pages/profile/profile.dart';

class EditProfilePage extends StatelessWidget {
  static String tag = '/editprofile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Editar Perfil',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: ListView(
            children: <Widget>[
              _contenido(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contenido(BuildContext context) {
    final user = Provider.of<UserAppetito>(context);
    double Width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue,
                  child: Text(
                    "${user.email.substring(0, 1)}".toUpperCase(),
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.black38,
                ),
                InkWell(
                  onTap: () => {print("editar foto")},
                  child: Container(
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
/*                 InkWell(onTap: () {
                  print("hola");
                }), */
              ],
            ),
            SizedBox(height: 30),
            _editarNombre(context),
            SizedBox(height: 30),
            _editardescripcion(context),
            SizedBox(height: 30),
            _guardarCambios(context),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _editarNombre(BuildContext context) {
    final user = Provider.of<UserAppetito>(context);
    return Container(
      child: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent),
        child: Container(
          padding: EdgeInsets.only(right: 30, left: 30),
          child: TextFormField(
            initialValue: user.email.substring(0, user.email.indexOf('@')),
            autofocus: false,
            style: TextStyle(fontSize: 15.0, color: Colors.grey),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              labelText: 'Nombre',
              isDense: true, // Added this
            ),
          ),
        ),
      ),
    );
  }

  Widget _editardescripcion(BuildContext context) {
    final user = Provider.of<UserAppetito>(context);
    return Container(
      child: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent),
        child: Container(
          padding: EdgeInsets.only(right: 30, left: 30),
          child: TextFormField(
            initialValue: "usuario de apettito",
            autofocus: false,
            style: TextStyle(fontSize: 15.0, color: Colors.grey),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              labelText: 'Descripcion',
              isDense: true, // Added this
            ),
          ),
        ),
      ),
    );
  }

  Widget _guardarCambios(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        Navigator.pushNamed(context, ProfilePage.tag);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.amber,
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        width: 200,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Row(
          children: <Widget>[
            Icon(Icons.save),
            SizedBox(width: 5),
            const Text('Guardar Cambios', style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
