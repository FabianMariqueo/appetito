import 'package:flutter/material.dart';

class RecipeProcedures extends StatefulWidget {
  List<String> proceduresList;

  RecipeProcedures({this.proceduresList});

  @override
  _RecipeProcedures createState() => _RecipeProcedures();
}

class _RecipeProcedures extends State<RecipeProcedures> {
  List<TextEditingController> _inputControllers = [];
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          "Procedimientos",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      ...showProcedures(),
      FloatingActionButton(
        heroTag: "add-procedure",
        splashColor: Colors.amberAccent,
        onPressed: () {
          setState(() {
            widget.proceduresList.add("");
          });
        },
        child: Icon(Icons.add),
      )
    ]);
  }

  List<Widget> showProcedures() {
    List<Widget> procedureWidgetList = [];
    widget.proceduresList.forEach((procedure) =>
        {_inputControllers.add(TextEditingController(text: procedure))});
    widget.proceduresList
        .asMap()
        .forEach((index, procedure) => procedureWidgetList.add(
              Container(
                padding: EdgeInsets.only(left: 5, right: 8),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _inputControllers[index],
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            labelText: "Instrucciones del paso",
                            hintText: "Ej: Hervir la cuchara",
                            icon: InkWell(
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                padding: EdgeInsets.symmetric(vertical: 13),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Colors.grey[600]),
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            widget.proceduresList[index] = value;
                          },
                        ),
                      ),
                    ),
                    widget.proceduresList.length > 1
                        ? IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                widget.proceduresList.removeAt(index);
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

    return procedureWidgetList;
  }
}
