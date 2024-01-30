import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const MyMap());

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  @override
  State createState() => MyMapState();
}

class MyMapState extends State<MyMap> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(5.397781363395903, 100.31131339912291);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      allMarkers.add(_createMarker(
        id: 'value1',
        position: LatLng(5.475530644247125, 100.19025415226275),
        title: 'Lazyboys Campsite',
        snippet: 'Tap for navigation',
        
      ));
      allMarkers.add(_createMarker(
        id: 'value2',
        position: LatLng(5.30464937652237, 100.253318655264),
        title: 'Camping Papanhill',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value3',
        position: LatLng(5.751864981962598, 100.37198130959572),
        title: 'DGenting Wild Campsite',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value4',
        position: LatLng(4.437942384275554, 101.40073482830887),
        title: 'Zakka Campsite',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value5',
        position: LatLng(3.2476103442812065, 101.62351337144882),
        title: 'FRIM Camping Area',
        snippet: 'Tap for navigation',
      ));
      allMarkers.add(_createMarker(
        id: 'value6',
        position: LatLng(5.753672080284848, 100.36964631534308),
        title: 'Perangin Campsite',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value7',
        position: LatLng(5.414797470036626, 100.76734960324455),
        title: 'Family Camping Lubuk jong',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value8',
        position: LatLng(5.751864981962598, 100.37198130959572),
        title: 'Pak Chan Campsite',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value9',
        position: LatLng(5.410774234538416, 100.77149244256131),
        title: 'DGenting Wild Campsite',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value10',
        position: LatLng(5.751864981962598, 100.37198130959572),
        title: 'DGenting Wild Campsite',
        snippet: 'Tap for navigation',
      ));
      allMarkers.add(_createMarker(
        id: 'value11',
        position: LatLng(3.367394034067959, 101.78572501076562),
        title: 'Yunkai Campsite',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value12',
        position: LatLng(4.919825916969265, 100.8345036488389),
        title: 'Uzeer Puteh Campsite (ALA NAVY SEAL)',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value13',
        position: LatLng(4.919825916969265, 100.8345036488389),
        title: 'Selama Beach Campsite',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value14',
        position: LatLng(5.376596052586372, 100.2784921812455),
        title: 'Fortress Hill Recreational',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value15',
        position: LatLng(2.915765352597927, 101.9196733924752),
        title: 'YAKA Campsite',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value16',
        position: LatLng(5.319510741767801, 100.21858236209005),
        title: 'YMCA Penang Campsite',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value17',
        position: LatLng(5.275601480210552, 100.28323580698063),
        title: 'Penang Mini Campsite',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value18',
        position: LatLng(4.452994349108709, 101.19760806238787),
        title: 'Rock Garden & Himalaya Camping Resort, Malaysia',
        snippet: 'Tap for navigation',
      ));


      allMarkers.add(_createMarker(
        id: 'value19',
        position: LatLng(5.370785216561001, 100.24724981139659),
        title: 'Erra Malik',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value20',
        position: LatLng(6.377997456941312, 100.51142691290555),
        title: 'Campsite Desa Mak Piah',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value21',
        position: LatLng(5.364974325649242, 100.29377004345076),
        title: 'Ketitir Base Camp',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value22',
        position: LatLng(5.410947211707374, 100.20690938718721),
        title: 'Bangawan Solo Campsite',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value23',
        position: LatLng(5.493357417537347, 100.37793704520705),
        title: 'Pusat Kecemerlangan Pengakap Pulau Pinang (PusKeP)',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value24',
        position: LatLng(5.48671347181499, 100.38535322850278),
        title: 'Kebun 3 Beradik',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value25',
        position: LatLng(5.483022358644263, 100.47657226068202),
        title: '#abiangcampsite',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value26',
        position: LatLng(5.373755137112692, 100.44690753477006),
        title: 'Camping site WoodHaven Park',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value27',
        position: LatLng(5.481545907802, 100.37274571948991),
        title: 'Kota Bukit Meriam Wild Campsite',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value28',
        position: LatLng(5.799635239327659, 100.3779370468414),
        title: 'Alfariq Campsite',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value29',
        position: LatLng(5.8581531473621, 100.91236097504812),
        title: 'Sebarau Park Campsite',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value30',
        position: LatLng(2.5747402906957846, 103.0885142499327),
        title: 'Salur Gajah Campsite & Waterfalls',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value31',
        position: LatLng(2.5500457691285585, 103.13520614341402),
        title: 'The Big Bean Hill',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value32',
        position: LatLng(6.125898234685498, 102.37766990839762),
        title: 'Campsite Tanah Abah',
        snippet: 'Tap for navigation',
      ));

      allMarkers.add(_createMarker(
        id: 'value33',
        position: LatLng(5.506075649245116, 102.20856102003485),
        title: 'Pasir Raja Adventure Camp',
        snippet: 'Tap for navigation',
      ));
    });
  }

Marker _createMarker({
  required String id,
  required LatLng position,
  required String title,
  required String snippet,
}) {
  return Marker(
    markerId: MarkerId(id),
    position: position,
    infoWindow: InfoWindow(
      title: title,
      snippet: 'Tap for navigation',
      onTap: () {
        // Handle the tap on the info window
        launchMaps(position.latitude, position.longitude);
      },
    ),
    onTap: () {
      // Do nothing when the marker is tapped
    },
    icon: BitmapDescriptor.defaultMarker,
  );
}


  List<Marker> allMarkers = [];
  Marker marker1 = Marker(
    markerId: MarkerId('value1'),
    position: LatLng(5.475530644247125, 100.19025415226275),
    infoWindow: InfoWindow(
      title: 'Lazyboys Campsite',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker2 = Marker(
    markerId: MarkerId('value2'),
    position: LatLng(5.30464937652237, 100.253318655264),
    infoWindow: InfoWindow(
      title: 'Camping Papanhill',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker3 = Marker(
    markerId: MarkerId('value3'),
    position: LatLng(5.751864981962598, 100.37198130959572),
    infoWindow: InfoWindow(
      title: 'DGenting Wild Campsite',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker4 = Marker(
    markerId: MarkerId('value4'),
    position: LatLng(4.437942384275554, 101.40073482830887),
    infoWindow: InfoWindow(
      title: 'Zakka Campsite',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker5 = Marker(
    markerId: MarkerId('value5'),
    position: LatLng(3.2476103442812065, 101.62351337144882),
    infoWindow: InfoWindow(
      title: 'FRIM Camping Area',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker6 = Marker(
    markerId: MarkerId('value6'),
    position: LatLng(5.753672080284848, 100.36964631534308),
    infoWindow: InfoWindow(
      title: 'Perangin Campsite',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker7 = Marker(
    markerId: MarkerId('value7'),
    position: LatLng(5.414797470036626, 100.76734960324455),
    infoWindow: InfoWindow(
      title: 'Family Camping Lubuk jong',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker8 = Marker(
    markerId: MarkerId('value8'),
    position: LatLng(5.751864981962598, 100.37198130959572),
    infoWindow: InfoWindow(
      title: 'Pak Chan Campsite',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker9 = Marker(
    markerId: MarkerId('value9'),
    position: LatLng(5.410774234538416, 100.77149244256131),
    infoWindow: InfoWindow(
      title: 'DGenting Wild Campsite',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker10 = Marker(
    markerId: MarkerId('value10'),
    position: LatLng(5.751864981962598, 100.37198130959572),
    infoWindow: InfoWindow(
      title: 'DGenting Wild Campsite',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker11 = Marker(
    markerId: MarkerId('value11'),
    position: LatLng(3.367394034067959, 101.78572501076562),
    infoWindow: InfoWindow(
      title: 'Yunkai Campsite',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker12 = Marker(
    markerId: MarkerId('value12'),
    position: LatLng(4.919825916969265, 100.8345036488389),
    infoWindow: InfoWindow(
      title: 'Uzeer Puteh Campsite (ALA NAVY SEAL)',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker13 = Marker(
    markerId: MarkerId('value13'),
    position: LatLng(4.919825916969265, 100.8345036488389),
    infoWindow: InfoWindow(
      title: 'Selama Beach Campsite',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker14 = Marker(
    //havent addded to fire base
    markerId: MarkerId('value14'),
    position: LatLng(5.376596052586372, 100.2784921812455),
    infoWindow: InfoWindow(
      title: 'Fortress Hill Recreational',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker15 = Marker(
    markerId: MarkerId('value15'),
    position: LatLng(2.915765352597927, 101.9196733924752),
    infoWindow: InfoWindow(
      title: 'YAKA Campsite',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker16 = Marker(
    markerId: MarkerId('value16'),
    position: LatLng(5.319510741767801, 100.21858236209005),
    infoWindow: InfoWindow(
      title: 'YMCA Penang Campsite',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker17 = Marker(
    markerId: MarkerId('value17'),
    position: LatLng(5.275601480210552, 100.28323580698063),
    infoWindow: InfoWindow(
      title: 'Penang Mini Campsite',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker18 = Marker(
    markerId: MarkerId('value18'),
    position: LatLng(4.452994349108709, 101.19760806238787),
    infoWindow: InfoWindow(
      title: 'Rock Garden & Himalaya Camping Resort, Malaysia',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  //below is havent added to firebase
  Marker marker19 = Marker(
    markerId: MarkerId('value19'),
    position: LatLng(5.370785216561001, 100.24724981139659),
    infoWindow: InfoWindow(
      title: 'erra malik',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker20 = Marker(
    markerId: MarkerId('value20'),
    position: LatLng(6.377997456941312, 100.51142691290555),
    infoWindow: InfoWindow(
      title: 'Campsite Desa Mak Piah',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker21 = Marker(
    markerId: MarkerId('value21'),
    position: LatLng(5.364974325649242, 100.29377004345076),
    infoWindow: InfoWindow(
      title: 'Ketitir Base Camp',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker22 = Marker(
    markerId: MarkerId('value22'),
    position: LatLng(5.410947211707374, 100.20690938718721),
    infoWindow: InfoWindow(
      title: 'Bangawan Solo Campsite',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker23 = Marker(
    markerId: MarkerId('value23'),
    position: LatLng(5.493357417537347, 100.37793704520705),
    infoWindow: InfoWindow(
      title: 'Pusat Kecemerlangan Pengakap Pulau Pinang (PusKeP)',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker24 = Marker(
    markerId: MarkerId('value24'),
    position: LatLng(5.48671347181499, 100.38535322850278),
    infoWindow: InfoWindow(
      title: 'Kebun 3 Beradik',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker25 = Marker(
    markerId: MarkerId('value25'),
    position: LatLng(5.483022358644263, 100.47657226068202),
    infoWindow: InfoWindow(
      title: '#abiangcampsite',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker26 = Marker(
    markerId: MarkerId('value26'),
    position: LatLng(5.373755137112692, 100.44690753477006),
    infoWindow: InfoWindow(
      title: 'Camping site WoodHaven Park',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker27 = Marker(
    markerId: MarkerId('value27'),
    position: LatLng(5.481545907802, 100.37274571948991),
    infoWindow: InfoWindow(
      title: 'Kota Bukit Meriam Wild Campsite',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker28 = Marker(
    markerId: MarkerId('value28'),
    position: LatLng(5.799635239327659, 100.3779370468414),
    infoWindow: InfoWindow(
      title: 'Alfariq Campsite',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker29 = Marker(
    markerId: MarkerId('value29'),
    position: LatLng(5.8581531473621, 100.91236097504812),
    infoWindow: InfoWindow(
      title: 'Sebarau Park Campsite',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker30 = Marker(
    markerId: MarkerId('value30'),
    position: LatLng(2.5747402906957846, 103.0885142499327),
    infoWindow: InfoWindow(
      title: 'Salur Gajah Campsite & Waterfalls',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker31 = Marker(
    markerId: MarkerId('value31'),
    position: LatLng(2.5500457691285585, 103.13520614341402),
    infoWindow: InfoWindow(
      title: 'The Big Bean Hill',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker32 = Marker(
    markerId: MarkerId('value32'),
    position: LatLng(6.125898234685498, 102.37766990839762),
    infoWindow: InfoWindow(
      title: 'Campsite Tanah Abah',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker33 = Marker(
    markerId: MarkerId('value33'),
    position: LatLng(5.506075649245116, 102.20856102003485),
    infoWindow: InfoWindow(
      title: 'Pasir Raja Adventure Camp',
      snippet: 'Tap for navigation',
    ),
    icon: BitmapDescriptor.defaultMarker,
  );

Marker createMarker({
  required String id,
  required LatLng position,
  required String title,
}) {
  return Marker(
    markerId: MarkerId(id),
    position: position,
    infoWindow: InfoWindow(
      title: title,
      snippet: 'Tap for navigation',
      onTap: () {
        launchMaps(position.latitude, position.longitude);
      },
    ),
    onTap: () {
      // Handle tap on the marker if needed
    },
    icon: BitmapDescriptor.defaultMarker,
  );
}

//Google map marker 
Future<void> launchMaps(double lat, double lng) async {
  final String googleMapsUrl =
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng';

  await launchUrl(Uri.parse(googleMapsUrl));
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
          zoom: 12.0,
        ),
        markers: Set<Marker>.of(allMarkers),
        onTap: (LatLng latLng) {
          // Handle tap on the map if needed
        },
        onLongPress: (LatLng latLng) {
          // Handle long press on the map if needed
        },
      ),
    );
  }
}
