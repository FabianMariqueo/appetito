import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';

class RecipeImages extends StatefulWidget {
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
        showImage(),
        SizedBox(
          height: 20.0,
        ),
        OutlineButton(
          onPressed: () {},
          child: Text('Upload Image'),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          status,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        CarouselSlider(
          options: CarouselOptions(height: 400.0),
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: Text(
                      'text $i',
                      style: TextStyle(fontSize: 16.0),
                    ));
              },
            );
          }).toList(),
        )
      ],
    );
  }

  chooseImage() {
    setState(() {
      file = ImagePicker().getImage(source: ImageSource.gallery);
    });
  }

  Widget showImage() {
    return FutureBuilder<PickedFile>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<PickedFile> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          return Flexible(
            child: Image.file(
              File(snapshot.data.path),
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }
}
