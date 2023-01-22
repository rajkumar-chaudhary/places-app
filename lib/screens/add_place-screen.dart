import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import '../models/place.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../providers/great_places.dart';
import '../widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  // const AddPlaceScreen({Key key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();

  static const routeName = '/add=place';
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _TitleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    // _pickedLocation = PlaceLocation(
        // latitude: 37.422, longitude: -122.084); //as map not working
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _savePlace() {
    if (_TitleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      return;
    }
    Provider.of<greatPlaces>(
      context,
      listen: false,
    ).addPlaces(_TitleController.text, _pickedImage, _pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Places'),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      //alignment: Alignment.topCenter,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                        width: 3,
                        color: Colors.blueGrey,
                      )),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Title',
                        ),
                        controller: _TitleController,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    LOcationInput(_selectPlace),
                  ],
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: Icon(Icons.add),
              label: Text(
                'Add place',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: Color.fromARGB(255, 192, 192, 91),
                // backgroundColor: Theme.of(context).accentColor,
                foregroundColor: Colors.black,
              ),
            ),
          ]),
    );
  }
}
