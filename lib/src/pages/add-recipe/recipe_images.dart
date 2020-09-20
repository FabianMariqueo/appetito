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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        OutlineButton(
          onPressed: chooseImage,
          child: Text('Choose Image'),
        ),
        SizedBox(
          height: 20.0,
        ),
        showImages(),
      ],
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
            } else {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Text(
                    'cargando imagen',
                    style: TextStyle(fontSize: 16.0),
                  ));
            }
          },
        );
      }).toList(),
    );
  }
}
