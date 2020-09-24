import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appetito/src/models/user-appetito.dart';
import 'package:appetito/src/pages/home/drawer.dart';

class MyRecipesPage extends StatelessWidget {
  static String tag = '/myrecipes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Mis recetas',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      drawer: DrawerPage(),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            _miReceta(context),
            _miReceta(context),
            _miReceta(context),
            _miReceta(context),
            _miReceta(context),
            _miReceta(context),
            _miReceta(context),
            _miReceta(context),
            _miReceta(context),
          ],
        ),
      ),
    );
  }

  Widget _miReceta(BuildContext context) {
    double Width = MediaQuery.of(context).size.width;
    double Height = MediaQuery.of(context).size.height;
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage("assets/img/drawer_img.jpg"),
                    fit: BoxFit.cover,
                    width: Width / 3,
                    //height: Height / 5,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _titulo("Titulo de receta"),
                  Row(
                    children: [
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Colors.amber,
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          width: Width / 4,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.edit),
                              SizedBox(width: 5),
                              const Text('Editar',
                                  style: TextStyle(fontSize: 15)),
                            ],
                          ),
                        ),
                        onPressed: () {
                          // Perform some action
                        },
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Colors.amber,
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          width: Width / 4,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.remove_red_eye),
                              SizedBox(width: 5),
                              const Text('Ver', style: TextStyle(fontSize: 15)),
                            ],
                          ),
                        ),
                        onPressed: () {
                          // Perform some action
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _titulo(String titulo) {
    return Text(
      titulo,
      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
    );
  }
}
