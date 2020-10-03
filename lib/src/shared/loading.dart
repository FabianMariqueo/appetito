import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: SpinKitFoldingCube(
          color: Colors.amber[800],
          size: 50,
        ),
      ),
    );
  }
}
