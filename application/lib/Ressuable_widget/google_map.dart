import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(const MyMap());

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  @override
  State createState() => MyMapState();
}

class MyMapState extends State<MyMap> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(5.2632, 100.4846);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      allMarkers.add(marker1);
      allMarkers.add(marker2);
      allMarkers.add(marker3);
      allMarkers.add(marker4);
      allMarkers.add(marker5);
      allMarkers.add(marker6);
      allMarkers.add(marker7);
      allMarkers.add(marker8);
      allMarkers.add(marker9);
      allMarkers.add(marker10);
      allMarkers.add(marker11);
      allMarkers.add(marker12);
      allMarkers.add(marker13);
      allMarkers.add(marker14);
      allMarkers.add(marker15);
      allMarkers.add(marker16);
      allMarkers.add(marker17);
      allMarkers.add(marker18);
      allMarkers.add(marker19);
      allMarkers.add(marker20);
      allMarkers.add(marker21);
      allMarkers.add(marker22);
      allMarkers.add(marker23);
      allMarkers.add(marker24);
      allMarkers.add(marker25);
      allMarkers.add(marker26);
      allMarkers.add(marker27);
      allMarkers.add(marker28);
      allMarkers.add(marker29);
      allMarkers.add(marker30);
      allMarkers.add(marker31);
      allMarkers.add(marker32);
      allMarkers.add(marker33);
    });
  }

  List<Marker> allMarkers = [];
  Marker marker1 = Marker(
    markerId: MarkerId('value1'),
    position: LatLng(5.475530644247125, 100.19025415226275),
    infoWindow: InfoWindow(title: 'Lazyboys Campsite'),
    icon: BitmapDescriptor.defaultMarker,
  );
  Marker marker2 = Marker(
    markerId: MarkerId('value2'),
    position: LatLng(5.30464937652237, 100.253318655264),
    infoWindow: InfoWindow(title: 'Camping Papanhill'),
  );
  Marker marker3 = Marker(
    markerId: MarkerId('value3'),
    position: LatLng(5.751864981962598, 100.37198130959572),
    infoWindow: InfoWindow(title: 'DGenting Wild Campsite'),
  );
  Marker marker4 = Marker(
    markerId: MarkerId('value4'),
    position: LatLng(4.437942384275554, 101.40073482830887),
    infoWindow: InfoWindow(title: 'Zakka Campsite'),
  );
  Marker marker5 = Marker(
    markerId: MarkerId('value5'),
    position: LatLng(3.2476103442812065, 101.62351337144882),
    infoWindow: InfoWindow(title: 'FRIM Camping Area'),
  );
  Marker marker6 = Marker(
    markerId: MarkerId('value6'),
    position: LatLng(5.753672080284848, 100.36964631534308),
    infoWindow: InfoWindow(title: 'Perangin Campsite'),
  );
  Marker marker7 = Marker(
    markerId: MarkerId('value7'),
    position: LatLng(5.414797470036626, 100.76734960324455),
    infoWindow: InfoWindow(title: 'Family Camping Lubuk jong'),
  );
  Marker marker8 = Marker(
    markerId: MarkerId('value8'),
    position: LatLng(5.751864981962598, 100.37198130959572),
    infoWindow: InfoWindow(title: 'Pak Chan Campsite'),
  );
  Marker marker9 = Marker(
    markerId: MarkerId('value9'),
    position: LatLng(5.410774234538416, 100.77149244256131),
    infoWindow: InfoWindow(title: 'DGenting Wild Campsite'),
  );
  Marker marker10 = Marker(
    markerId: MarkerId('value10'),
    position: LatLng(5.751864981962598, 100.37198130959572),
    infoWindow: InfoWindow(title: 'DGenting Wild Campsite'),
  );
  Marker marker11 = Marker(
    markerId: MarkerId('value11'),
    position: LatLng(3.367394034067959, 101.78572501076562),
    infoWindow: InfoWindow(title: 'Yunkai Campsite'),
  );
  Marker marker12 = Marker(
    markerId: MarkerId('value12'),
    position: LatLng(4.919825916969265, 100.8345036488389),
    infoWindow: InfoWindow(title: 'Uzeer Puteh Campsite (ALA NAVY SEAL)'),
  );
  Marker marker13 = Marker(
    markerId: MarkerId('value13'),
    position: LatLng(4.919825916969265, 100.8345036488389),
    infoWindow: InfoWindow(title: 'Selama Beach Campsite'),
  );
  Marker marker14 = Marker(
    //havent addded to fire base
    markerId: MarkerId('value14'),
    position: LatLng(5.376596052586372, 100.2784921812455),
    infoWindow: InfoWindow(title: 'Fortress Hill Recreational'),
  );
  Marker marker15 = Marker(
    markerId: MarkerId('value15'),
    position: LatLng(2.915765352597927, 101.9196733924752),
    infoWindow: InfoWindow(title: 'YAKA Campsite'),
  );
  Marker marker16 = Marker(
    markerId: MarkerId('value16'),
    position: LatLng(5.319510741767801, 100.21858236209005),
    infoWindow: InfoWindow(title: 'YMCA Penang Campsite'),
  );
  Marker marker17 = Marker(
    markerId: MarkerId('value17'),
    position: LatLng(5.275601480210552, 100.28323580698063),
    infoWindow: InfoWindow(title: 'Penang Mini Campsite'),
  );
  Marker marker18 = Marker(
    markerId: MarkerId('value18'),
    position: LatLng(4.452994349108709, 101.19760806238787),
    infoWindow:
        InfoWindow(title: 'Rock Garden & Himalaya Camping Resort, Malaysia'),
  );
  //below is havent added to firebase
  Marker marker19 = Marker(
    markerId: MarkerId('value19'),
    position: LatLng(5.370785216561001, 100.24724981139659),
    infoWindow:
        InfoWindow(title: 'erra malik'),
  );
    Marker marker20 = Marker(
    markerId: MarkerId('value20'),
    position: LatLng(6.377997456941312, 100.51142691290555),
    infoWindow:
        InfoWindow(title: 'Campsite Desa Mak Piah'),
  );
    Marker marker21 = Marker(
    markerId: MarkerId('value21'),
    position: LatLng(5.364974325649242, 100.29377004345076),
    infoWindow:
        InfoWindow(title: 'Ketitir Base Camp'),
  );
    Marker marker22 = Marker(
    markerId: MarkerId('value22'),
    position: LatLng(5.410947211707374, 100.20690938718721),
    infoWindow:
        InfoWindow(title: 'Bangawan Solo Campsite'),
  );
    Marker marker23 = Marker(
    markerId: MarkerId('value23'),
    position: LatLng(5.493357417537347, 100.37793704520705),
    infoWindow:
        InfoWindow(title: 'Pusat Kecemerlangan Pengakap Pulau Pinang (PusKeP)'),
  );
    Marker marker24 = Marker(
    markerId: MarkerId('value24'),
    position: LatLng(5.48671347181499, 100.38535322850278),
    infoWindow:
        InfoWindow(title: 'Kebun 3 Beradik'),
  );
      Marker marker25 = Marker(
    markerId: MarkerId('value25'),
    position: LatLng(5.483022358644263, 100.47657226068202),
    infoWindow:
        InfoWindow(title: '#abiangcampsite'),
  );
      Marker marker26 = Marker(
    markerId: MarkerId('value26'),
    position: LatLng(5.373755137112692, 100.44690753477006),
    infoWindow:
        InfoWindow(title: 'Camping site WoodHaven Park'),
  );
        Marker marker27 = Marker(
    markerId: MarkerId('value27'),
    position: LatLng(5.481545907802, 100.37274571948991),
    infoWindow:
        InfoWindow(title: 'Kota Bukit Meriam Wild Campsite'),
  );
        Marker marker28 = Marker(
    markerId: MarkerId('value28'),
    position: LatLng(5.799635239327659, 100.3779370468414),
    infoWindow:
        InfoWindow(title: 'Alfariq Campsite'),
  );
          Marker marker29 = Marker(
    markerId: MarkerId('value29'),
    position: LatLng(5.8581531473621, 100.91236097504812),
    infoWindow:
        InfoWindow(title: 'Sebarau Park Campsite'),
  );
            Marker marker30 = Marker(
    markerId: MarkerId('value30'),
    position: LatLng(2.5747402906957846, 103.0885142499327),
    infoWindow:
        InfoWindow(title: 'Salur Gajah Campsite & Waterfalls'),
  );
              Marker marker31 = Marker(
    markerId: MarkerId('value31'),
    position: LatLng(2.5500457691285585, 103.13520614341402),
    infoWindow:
        InfoWindow(title: 'The Big Bean Hill'),
  );
                Marker marker32 = Marker(
    markerId: MarkerId('value32'),
    position: LatLng(6.125898234685498, 102.37766990839762),
    infoWindow:
        InfoWindow(title: 'Campsite Tanah Abah'),
  );
                  Marker marker33 = Marker(
    markerId: MarkerId('value33'),
    position: LatLng(5.506075649245116, 102.20856102003485),
    infoWindow:
        InfoWindow(title: 'Pasir Raja Adventure Camp'),
  );
  
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
