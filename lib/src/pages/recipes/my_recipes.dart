import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appetito/src/models/user-appetito.dart';

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
      body: Padding(
        padding: EdgeInsets.all(10.0),
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
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20.0),
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      print('ver receta');
                    },
                    child: ClipOval(
                      child: Material(
                        color: Colors.green, // button color
                        child: InkWell(
                          splashColor: Colors.amber, // inkwell color
                          child: SizedBox(
                              width: 35, height: 35, child: Icon(Icons.edit)),
                          onTap: () {},
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        print('ver receta');
                      },
                      child: ClipOval(
                        child: Material(
                          color: Colors.blue, // button color
                          child: InkWell(
                            splashColor: Colors.amber, // inkwell color
                            child: SizedBox(
                                width: 35,
                                height: 35,
                                child: Icon(Icons.library_books)),
                            onTap: () {},
                          ),
                        ),
                      )),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _titulo("Titulo de receta"),
              ],
            ),
            Image(
              image: AssetImage("assets/img/drawer_img.jpg"),
              fit: BoxFit.cover,
              width: 70,
              height: 70,
            ),
          ],
        ),
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
