import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_based_app/Provider/provider.dart';
import 'package:location_based_app/Widget/dropdown.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';


// Screen to display the entered location on a map.
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _targetLocation;
  bool _isLoading = true;
  MapType _currentMapType = MapType.normal;

  @override
  void initState() {
    super.initState();
    _fetchLocationCoordinates();
  }

  // Fetches the location coordinates using the location name.
  Future<void> _fetchLocationCoordinates() async {
    final locationName = Provider.of<LocationProvider>(context, listen: false).location;
    if (locationName != null) {
      try {
        List<Location> locations = await locationFromAddress(locationName);
        if (locations.isNotEmpty) {
          setState(() {
            _targetLocation = LatLng(locations.first.latitude, locations.first.longitude);
            _isLoading = false;
          });
        } else {
          _showErrorAndGoBack();
        }
      } catch (e) {
        debugPrint('Error fetching location coordinates: $e');
        _showErrorAndGoBack();
      }
    }
  }

  // Shows an error and navigates back to the previous screen.
  void _showErrorAndGoBack() {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Incorrect address, please try again!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map View"),
        actions: [
          // Map type dropdown button widget
          MapTypeDropdown(
            currentMapType: _currentMapType,
            onMapTypeChanged: (newMapType) {
              setState(() {
                _currentMapType = newMapType;
              });
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              mapType: _currentMapType,
              initialCameraPosition: CameraPosition(
                target: _targetLocation!,
                zoom: 14,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('targetLocation'),
                  position: _targetLocation!,
                ),
              },
              onMapCreated: (GoogleMapController controller) {},
            ),
    );
  }
}
