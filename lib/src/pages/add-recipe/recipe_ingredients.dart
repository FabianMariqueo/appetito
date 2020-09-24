import 'package:flutter/material.dart';

class RecipeIngredients extends StatefulWidget {
  List<String> ingredientsList;

  RecipeIngredients({this.ingredientsList});

  @override
  _RecipeIngredients createState() => _RecipeIngredients();
}

class _RecipeIngredients extends State<RecipeIngredients> {
  List<TextEditingController> _inputControllers = [];
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          "Ingredientes",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      ...showIngredients(),
      FloatingActionButton(
        heroTag: "add-ingredients",
        splashColor: Colors.amberAccent,
        onPressed: () {
          setState(() {
            widget.ingredientsList.add("");
          });
        },
        child: Icon(Icons.add),
      )
    ]);
  }

  List<Widget> showIngredients() {
    List<Widget> listaWidgetIngredientes = [];
    List<TextEditingController> ingredientesControllers = [];
    widget.ingredientsList.forEach((ingrediente) => {
          ingredientesControllers.add(TextEditingController(text: ingrediente))
        });
    widget.ingredientsList
        .asMap()
        .forEach((index, ingrediente) => listaWidgetIngredientes.add(
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: TextField(
                          controller: ingredientesControllers[index],
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: "Ingrediente",
                            hintText: "Ej: 3 huevos",
                            icon: Icon(Icons.assignment),
                          ),
                          onChanged: (value) {
                            widget.ingredientsList[index] = value;
                          },
                        ),
                      ),
                    ),
                    widget.ingredientsList.length > 1
                        ? IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                widget.ingredientsList.removeAt(index);
                              });
                            },
                          )
                        : Icon(
                            Icons.delete,
                            color: Colors.grey[400],
                          ),
                  ],
                ),
              ),
            ));

    return listaWidgetIngredientes;
  }
}
