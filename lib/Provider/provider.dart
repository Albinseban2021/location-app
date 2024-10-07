import 'package:flutter/material.dart';

// A provider to manage the location state.
class LocationProvider with ChangeNotifier {
  String? _location;

  String? get location => _location;
  // Sets the location and notifies listeners.
  void setLocation(String location) {
    _location = location;
    notifyListeners();
  }
}
