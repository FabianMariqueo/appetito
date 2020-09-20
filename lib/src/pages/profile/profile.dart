import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  static String tag = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Perfil',
          style: TextStyle(
            fontSize: 15,
            //fontWeight: FontWeight.w200,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                  radius: (52),
                  backgroundColor: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset('assets/img/user3.png'),
                  )),
              Text(
                'Usuario 3',
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                'Amante de la cocina y pastelería',
                style: TextStyle(fontSize: 15.0),
              ),
              _listaRecetas(context), //no hacen scroll
              _listaRecetas(context),
              _listaRecetas(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listaRecetas(BuildContext context) {
    double Width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image(
              image: AssetImage("assets/img/drawer_img.jpg"),
              fit: BoxFit.cover,
              width: Width,
              height: 100,
            ),
            ListTile(
              title: Text('Nombre receta 1'),
              subtitle: Text('Tiempo | Porciones'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _test(BuildContext context) {
    double Width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(20.0),
      child: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text('hola'),
              subtitle: Text('chao'),
            ),

/*             SizedBox(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image(
                  image: AssetImage("assets/img/drawer_img.jpg"),
                  fit: BoxFit.cover,
                  width: Width,
                  height: 100,
                ),
                ListTile(
                  title: Text('Nombre receta 1'),
                  subtitle: Text('Tiempo | Porciones'),
                ), */
            // ],
            // ),
          ),
        ],
      ),
    );
  }
}
