import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appetito/src/models/user-appetito.dart';

class SavedRecipesPage extends StatelessWidget {
  static String tag = '/savedrecipes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Recetas Guardadas',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            _cuadriculaRecetas(context),
          ],
        ),
      ),
    );
  }

  Widget _recetaGuardada(BuildContext context) {
    double Width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image(
                image: AssetImage("assets/img/drawer_img.jpg"),
                fit: BoxFit.cover,
                width: Width / 2,
                height: 70,
              ),
              ListTile(
                title: _titulo("Titulo receta"),
                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.timer),
                    SizedBox(
                      width: 5,
                    ),
                    _descripcion("30 Min."),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.local_dining),
                    SizedBox(
                      width: 5,
                    ),
                    _descripcion("4")
                  ],
                ),
              ),
            ],
          ),
        ),
        InkWell(
          //para poder hacer tap en la categoria
          onTap: () {
            print("Receta");
          },
        ),
      ],
    );
  }

  Widget _cuadriculaRecetas(BuildContext context) {
    return new GridView.count(
      primary: false,
      //padding: const EdgeInsets.all(0),
      crossAxisCount: 2, //cantidad de columnas
      childAspectRatio: 1, //proporcion de tamaño del item
      mainAxisSpacing: 5, //espaciado horizontal
      crossAxisSpacing: 5, //espaciado vertical
      children: <Widget>[
        _recetaGuardada(context),
        _recetaGuardada(context),
        _recetaGuardada(context),
        _recetaGuardada(context),
        _recetaGuardada(context),
        _recetaGuardada(context),
        _recetaGuardada(context),
        _recetaGuardada(context),
        _recetaGuardada(context),
        _recetaGuardada(context),
      ], //new Cards()
      shrinkWrap: true,
    );
  }

  Widget _titulo(String titulo) {
    return Text(
      titulo,
      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _descripcion(String descripcion) {
    return Text(
      descripcion,
      style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal),
    );
  }
}
