import 'package:appetito/src/models/user-appetito.dart';
import 'package:appetito/src/pages/add-recipe/add_recipe.dart';
import 'package:appetito/src/pages/home/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipePage extends StatelessWidget {
  static String tag = '/recipe';

  @override
  Widget build(BuildContext context) {
    // Datos del usuario logeado
    final user = Provider.of<Future<UserAppetito>>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Titulo de receta',
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
              _cabeceraReceta(context),
            ],
          ),
        ),
      ),
      floatingActionButton: _addButton(context),
    );
  }

  Widget _addButton(BuildContext context) {
    return FloatingActionButton(
      splashColor: Colors.amberAccent,
      onPressed: () {
        Navigator.pushNamed(context, AddRecipePage.tag);
      },
      child: Icon(Icons.add),
    );
  }

  Widget _cabeceraReceta(BuildContext context) {
    double Width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
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
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.timer),
                  SizedBox(
                    width: 5,
                  ),
                  _tituloreceta("Minutos"),
                  SizedBox(
                    width: 10,
                  ),
                  _tituloreceta("|"),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.local_dining),
                  SizedBox(
                    width: 5,
                  ),
                  _tituloreceta("Porciones")
                ],
              ),
            ),
            _subtitulo("Ingredientes"),
            _descripcioningrediente("Ingrediente 1"),
            _descripcioningrediente("Ingrediente 2"),
            _descripcioningrediente("Ingrediente 3"),
            _descripcioningrediente("Ingrediente 4"),
            SizedBox(width: 10),
            _subtitulo("Procedimiento"),
            _descripcionprocedimiento("Procedimiento para la receta 1"),
            _descripcionprocedimiento("Procedimiento para la receta 1"),
            _descripcionprocedimiento("Procedimiento para la receta 1"),
            _descripcionprocedimiento("Procedimiento para la receta 1"),
            _descripcionprocedimiento("Procedimiento para la receta 1"),
            _descripcionprocedimiento("Procedimiento para la receta 1"),
            _descripcionprocedimiento("Procedimiento para la receta 1"),
            _descripcionprocedimiento("Procedimiento para la receta 1"),
            _descripcionprocedimiento("Procedimiento para la receta 1"),
          ],
        ),
      ),
    );
  }

  Widget _descripcioningrediente(String descripcion) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(
            Icons.arrow_forward_ios,
            size: 10.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0, top: 5.0, bottom: 5.0),
          child: Text(
            descripcion,
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }

  Widget _descripcionprocedimiento(String descripcion) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(
            Icons.clear_all,
            size: 15.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0, top: 5.0, bottom: 5.0),
          child: Text(
            descripcion,
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }

  Widget _tituloreceta(String titulo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text(
        titulo,
        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _subtitulo(String titulo) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
          child: Text(
            titulo,
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
