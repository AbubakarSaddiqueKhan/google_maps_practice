// Location package is used to fetch the current location of the user .
// flutter pub add location
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CurrentLocationDesign extends StatefulWidget {
  const CurrentLocationDesign({super.key});

  @override
  State<CurrentLocationDesign> createState() => _CurrentLocationDesignState();
}

Set<Marker> _marker = <Marker>{};

class _CurrentLocationDesignState extends State<CurrentLocationDesign> {
  double? currentLocationLatitude;
  double? currentLocationLongitude;

  void checkForPermission() async {
    print("Entered //////////////////////////////// ");
    Location location = new Location();
    location.onLocationChanged.listen((event) {
      print(event.latitude);
      print(event.longitude);
    });

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

// _locationData = await location.getLocation();

    try {
      var userLocation = await location.getLocation();
      setState(() {
        currentLocationLongitude = userLocation.longitude;
        currentLocationLatitude = userLocation.latitude;

        _marker.add(Marker(
            markerId: const MarkerId("Current Location"),
            position:
                LatLng(currentLocationLatitude!, currentLocationLongitude!)));
      });
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Current Live Location"),
      ),
    );
  }
}
