import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/add_place-screen.dart';
import '../providers/great_places.dart';
import './place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  // const MyWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Great Places'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<greatPlaces>(context).fetchAndsetPlaces(),
        builder: ((context, snapshot) =>
            //  snapshot.connectionState ==
            //         ConnectionState.waiting
            //     ? Center(
            //         child: CircularProgressIndicator(),
            //       )
            //     :
            Consumer<greatPlaces>(
              child: Center(child: Text('No places added try adding some!')),
              builder: (context, grtplaces, ch) => grtplaces.items.length <= 0
                  ? ch
                  : ListView.builder(
                      itemCount: grtplaces.items.length,
                      itemBuilder: ((context, i) => ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(
                                grtplaces.items[i].image,
                              ),
                            ),
                            title: Text(grtplaces.items[i].title),
                            // subtitle:
                            //     Text(grtplaces.items[i].location.address),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                PlaceDetailScreen.routeName,
                                arguments: grtplaces.items[i].id,
                              );
                            },
                          )),
                    ),
            )),
        // child:
      ),
    );
  }
}
