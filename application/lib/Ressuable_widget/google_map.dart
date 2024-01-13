import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(const MyMap());

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  @override
  State createState() => MyMapState();
}

class MyMapState extends State {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(5.2632, 100.4846);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  List<Marker> allMarkers = [];

  Marker marker1 = Marker(
    markerId: MarkerId('value'),
    position: LatLng(5.475530644247125, 100.19025415226275),
    infoWindow: InfoWindow(title: 'Lazyboys Campsite'),
  );
  Marker marker2 = Marker(
    markerId: MarkerId('value'),
    position: LatLng(5.30464937652237, 100.253318655264),
    infoWindow: InfoWindow(title: 'Camping Papanhill'),
  );

  void initState() {
    super.initState();
    // Fetching data from database
    // final geo = GeoFlutterFire();
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // // Readding data to firestore
    // firestore.collection('google_map_campsites').add({
    //   'Name': 'Lazyboys Campsite',
    //   'location': geo.point(latitude: 5.474843277991884, longitude: 100.19106778593031),
    //   'geohash': GeoFirePoint(5.474843277991884, 100.19106778593031).hash,
    // });
    firestore.collection('google_map_campsites').get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        // allMarkers.add(Marker(
        //     markerId: MarkerId(result.data()['campsite_name']),
        //     position: LatLng(
        //       result.data()['location'].latitude,
        //       result.data()['location'].longitude
        //     ),
        //     infoWindow: InfoWindow(title: result.data()['campsite_name']),
        // ));
        print(result.data());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600.0,
      child: GoogleMap(
        gestureRecognizers: {
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        },
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: Set<Marker>.of(allMarkers),
      ),
    );
  }
}
