      import 'package:flutter/material.dart';
      import 'package:google_maps_flutter/google_maps_flutter.dart';
      
      void main() => runApp(const MyMap());
      
      class MyMap extends StatefulWidget {
        const MyMap({super.key});
      
        @override
        State createState() =>  MyMapState();
      }
      
      class  MyMapState extends State {
        late GoogleMapController mapController;
      
        final LatLng _center = const LatLng(5.2632, 100.4846);
      
        void _onMapCreated(GoogleMapController controller) {
          mapController = controller;
        }
      
        @override
        Widget build(BuildContext context) {
          return SizedBox(
            height: 300.0,
            child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11.0,
                  ),
                ),
          );
        }
      }