import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPickerWidget extends StatefulWidget {
  final Function(LatLng)? onLocationPicked;

  LocationPickerWidget({Key? key, this.onLocationPicked}) : super(key: key);

  @override
  _LocationPickerWidgetState createState() => _LocationPickerWidgetState();
}

class _LocationPickerWidgetState extends State<LocationPickerWidget> {
  LatLng? selectedLocation;
  TextEditingController _searchController = TextEditingController();
  List<String> locationSuggestions = [];

  Future<void> _searchLocations(String query) async {
    // Implement location search logic here, e.g., using the Google Places API.
    // Update the 'locationSuggestions' list with search results.

    // For demonstration purposes, let's simulate search results.
    setState(() {
      locationSuggestions = [
        'Sungai Sedim',
        'Kuala Kangsar',
        'Campsite Rimba',
        'Bukit Suling',
      ];
    });
  }

  Future<void> _pickLocation(String location) async {
    // Implement location selection logic here.
    // When a location is picked, call widget.onLocationPicked(selectedLocation).

    // For demonstration purposes, let's set a sample location.
    selectedLocation = LatLng(37.7749, -122.4194); // San Francisco, CA
    if (widget.onLocationPicked != null) {
      widget.onLocationPicked!(
          selectedLocation!); // Add the ! to indicate it's not null
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          onChanged: _searchLocations,
          decoration: InputDecoration(
            hintText: 'Search for a location',
          ),
        ),
        if (locationSuggestions.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            itemCount: locationSuggestions.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(locationSuggestions[index]),
                onTap: () => _pickLocation(locationSuggestions[index]),
              );
            },
          ),
        if (selectedLocation != null)
          Text(
              'Selected Location: ${selectedLocation!.latitude}, ${selectedLocation!.longitude}'),
        ElevatedButton(
          onPressed: () => _pickLocation(
              'Selected Location'), // Implement this based on your logic
          child: Text('Confirm Location'),
        ),
      ],
    );
  }
}
