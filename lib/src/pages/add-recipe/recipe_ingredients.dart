import 'package:flutter/material.dart';

class RecipeIngredients extends StatefulWidget {
  List<String> listaIngredientes;

  RecipeIngredients({this.listaIngredientes});

  @override
  _RecipeIngredients createState() => _RecipeIngredients();
}

class _RecipeIngredients extends State<RecipeIngredients> {
  List<TextEditingController> _inputControllers = [];
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          "Ingredientes",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      ...showIngredients(),
      FloatingActionButton(
        splashColor: Colors.amberAccent,
        onPressed: () {
          setState(() {
            widget.listaIngredientes.add("");
          });
        },
        child: Icon(Icons.add),
      )
    ]);
  }

  List<Widget> showIngredients() {
    List<Widget> listaWidgetIngredientes = [];
    List<TextEditingController> ingredientesControllers = [];
    widget.listaIngredientes.forEach((ingrediente) => {
          ingredientesControllers.add(TextEditingController(text: ingrediente))
        });
    widget.listaIngredientes
        .asMap()
        .forEach((index, ingrediente) => listaWidgetIngredientes.add(
              Container(
                padding: EdgeInsets.only(left: 5, right: 8),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextField(
                          controller: ingredientesControllers[index],
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: "Ingrediente",
                            hintText: "Ej: 3 huevos",
                            icon: Icon(Icons.list),
                          ),
                          onChanged: (value) {
                            widget.listaIngredientes[index] = value;
                          },
                        ),
                      ),
                    ),
                    widget.listaIngredientes.length > 1
                        ? IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                widget.listaIngredientes.removeAt(index);
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
