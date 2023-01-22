import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helper/loaction_helper.dart';
import '../screens/map_screen.dart';

class LOcationInput extends StatefulWidget {
  // const LOcationInput({Key key}) : super(key: key);
  final Function onSelectsPlace;
  LOcationInput(this.onSelectsPlace);

  @override
  State<LOcationInput> createState() => _LOcationInputState();
}

class _LOcationInputState extends State<LOcationInput> {
  String _previewImageUrl;

  Future<void> _getCurrentLocation() async {
    final locData = await Location().getLocation();
    // print(locData.latitude);
    // print(locData.longitude);
    final _LocationPreview = LocationHelper.generateLocationPreviewImage(
      latitude: locData.latitude,
      longitude: locData.longitude,
    );
    setState(() {
      _previewImageUrl = _LocationPreview;
    });
    // widget.onSelectsPlace(37.422, -122.084); // as google map not working';
    widget.onSelectsPlace(locData.latitude, locData.longitude);
  }

  Future<void> _selectOnMap() async {
    final selectedlocation =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (ctx) => MapScreen(
                  isSelecting: true,
                )));
    if (selectedlocation == null) {
      return;
    }
    final _LocationPreview = LocationHelper.generateLocationPreviewImage(
      latitude: selectedlocation.latitude,
      longitude: selectedlocation.longitude,
    );
    setState(() {
      _previewImageUrl = _LocationPreview;
    });
    // print(selectedlocation.latitude);
    // widget.onSelectsPlace(37.422, -122.084); // as google map not working';
    widget.onSelectsPlace(
        selectedlocation.latitude, selectedlocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
        width: 3,
        color: Colors.blueGrey,
      )),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(
              width: 1,
              color: Colors.blueGrey,
            )),
            width: double.infinity,
            height: 150,
            alignment: Alignment.center,
            child: _previewImageUrl == null
                ? Text('please select a location')
                : Image.network(_previewImageUrl),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: Icon(
                  Icons.location_on,
                ),
                label: Text('Current Location'),
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor),
              ),
              TextButton.icon(
                onPressed: _selectOnMap,
                icon: Icon(
                  Icons.map,
                ),
                label: Text('Select on Map'),
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
