import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// A dropdown widget to select the map type.
class MapTypeDropdown extends StatelessWidget {
  final MapType currentMapType;
  final Function(MapType) onMapTypeChanged;

  const MapTypeDropdown({
    super.key,
    required this.currentMapType,
    required this.onMapTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        child: DropdownButton<MapType>(
          value: currentMapType,
          dropdownColor: Colors.white,
          underline: const SizedBox(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          onChanged: (MapType? newMapType) {
            if (newMapType != null) {
              onMapTypeChanged(newMapType);
            }
          },
          items: const [
            DropdownMenuItem(
              value: MapType.normal,
              child: Text('Normal'),
            ),
            DropdownMenuItem(
              value: MapType.satellite,
              child: Text('Satellite'),
            ),
            DropdownMenuItem(
              value: MapType.terrain,
              child: Text('Terrain'),
            ),
          ],
          iconSize: 28.0,
          borderRadius: BorderRadius.circular(12.0),
          elevation: 4,
        ),
      ),
    );
  }
}
