import 'package:flutter/material.dart';

class RecipeIngredients extends StatefulWidget {
  List<String> listaIngredientes;

  RecipeIngredients({this.listaIngredientes});

  @override
  _RecipeIngredients createState() => _RecipeIngredients();
}

class _RecipeIngredients extends State<RecipeIngredients> {
  @override
  Widget build(BuildContext context) {
    return Column(children: showIngredients());
  }

  List<Widget> showIngredients() {
    return widget.listaIngredientes
        .map(
          (ingrediente) => Builder(
            builder: (BuildContext context) => Container(
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          labelText: "Ingrediente",
                          hintText: "Ej: 3 huevos",
                          icon: Icon(Icons.list),
                        ),
                        onChanged: (value) {
                          setState(() {
                            ingrediente = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Icon(Icons.close)
                ],
              ),
            ),
          ),
        )
        .toList();
  }
}
