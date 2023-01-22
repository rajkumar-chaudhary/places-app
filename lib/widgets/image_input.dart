import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function selectedImage;
  ImageInput(this.selectedImage);
  // const ImageInput({Key key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _imageStore;

  Future<void> _takeImage() async {
    final _picker = ImagePicker();
    final imagegot = await _picker.getImage(
      source: ImageSource.camera,
      maxHeight: 600,
    );

    if (File(imagegot.path) == null) {
      return;
    }
    // final imagegot = await ImagePicker.pickImage(
    //   source: ImageSource.camera,
    //   maxWidth: 600,
    // );
    setState(() {
      _imageStore = File(imagegot.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(File(imagegot.path).path);
    final savedImage =
        await File(imagegot.path).copy('${appDir.path}/$fileName');

    widget.selectedImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        width: 3,
        color: Colors.blueGrey,
      )),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 100,
            width: 150,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
            ),
            child: _imageStore != null
                ? Image.file(
                    _imageStore,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : Center(
                    child: Text(
                      'No image taken!',
                      textAlign: TextAlign.center,
                    ),
                  ),
          ),
          SizedBox(
            width: 10,
          ),
          TextButton.icon(
            onPressed: _takeImage,
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            style: TextButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              foregroundColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
