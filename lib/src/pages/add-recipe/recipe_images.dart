import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';

class RecipeImages extends StatefulWidget {
  List<Future<PickedFile>> listaImagenes;

  RecipeImages({this.listaImagenes});

  @override
  _RecipeImages createState() => _RecipeImages();
}

class _RecipeImages extends State<RecipeImages> {
  Future<PickedFile> file;
  String status = '';
  String base64Image;
  PickedFile tmpFile;
  String errMessage = 'Error Uploading Image';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          widget.listaImagenes.length > 0 ? showImages() : showDefault(),
          InkWell(
            onTap: () {
              chooseImage();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 13),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.amber[700]),
              child: Text(
                'Seleccionar Imagen',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  chooseImage() {
    setState(() {
      widget.listaImagenes
          .add(ImagePicker().getImage(source: ImageSource.gallery));
    });
  }

  Widget showImages() {
    return CarouselSlider(
      options: CarouselOptions(height: 150.0, enableInfiniteScroll: false),
      items: widget.listaImagenes.map((i) {
        return FutureBuilder<PickedFile>(
          future: i,
          builder: (BuildContext context, AsyncSnapshot<PickedFile> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                null != snapshot.data) {
              tmpFile = snapshot.data;
              return Column(
                children: [
                  Flexible(
                    child: Image.file(
                      File(snapshot.data.path),
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Text(
                    'cargando imagen',
                    style: TextStyle(fontSize: 16.0),
                  ));
            } else {
              widget.listaImagenes.remove(i);
              return showDefault();
            }
          },
        );
      }).toList(),
    );
  }

  Widget showDefault() {
    return Image.asset(
      'assets/img/image_default.png',
      height: 100,
      width: 100,
    );
  }
}
