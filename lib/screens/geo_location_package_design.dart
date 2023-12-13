import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// Geolocation is the process of determining or estimating geographic coordinates. Whereas reverse geocoding is the process of converting geographic coordinates into a human-readable address.
// flutter pub add geolocator
// flutter pub add geocoding

// Make sure you set the compileSdkVersion in your "android/app/build.gradle" file to 33:

// class GeoLocationPackageDesign extends StatefulWidget {
//   const GeoLocationPackageDesign({super.key});

//   @override
//   State<GeoLocationPackageDesign> createState() =>
//       _GeoLocationPackageDesignState();
// }

// class _GeoLocationPackageDesignState extends State<GeoLocationPackageDesign> {
// // This permission is same as the permission that we get in simple location package .

//   Future<bool> _handleLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location services are disabled. Please enable the services')));
//       return false;
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Location permissions are denied')));
//         return false;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location permissions are permanently denied, we cannot request permissions.')));
//       return false;
//     }
//     return true;
//   }

//   String? _currentAddress;
//   Position? _currentPosition;

//   Future<void> _getCurrentPosition() async {
//     final hasPermission = await _handleLocationPermission();
//     if (!hasPermission) return;
//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) {
//       setState(() => _currentPosition = position);
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }

//   Future<void> _getAddressFromLatLng(Position position) async {
//     await placemarkFromCoordinates(
//             _currentPosition!.latitude, _currentPosition!.longitude)
//         .then((List<Placemark> placemarks) {
//       Placemark place = placemarks[0];
//       setState(() {
//         _currentAddress =
//             '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
//       });
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Geo Coding"),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [Text("Address : $_currentAddress")],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _handleLocationPermission();
//           _getCurrentPosition();
//           _getAddressFromLatLng(_currentPosition!);
//         },
//       ),
//     );
//   }
// }

Set<Marker> _markers = <Marker>{};

class GeoLocationPackageDesign extends StatefulWidget {
  const GeoLocationPackageDesign({Key? key}) : super(key: key);

  @override
  State<GeoLocationPackageDesign> createState() =>
      _GeoLocationPackageDesignState();
}

class _GeoLocationPackageDesignState extends State<GeoLocationPackageDesign> {
  String? _currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  // geo locator . distance between is used to get the distance in meter's bw two geographical point

  double distanceInMeters = 0;
  void checkDistanceBwBwpAndIsb() {
    setState(() {
      distanceInMeters = Geolocator.distanceBetween(
          29.418068, 71.670685, 33.738045, 73.084488);
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  List<Placemark> _placeMarks = <Placemark>[];

  double initialLatitudeValue = 29.395721;
  double initialLongitudeValue = 71.683334;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Location Page")),
      body: SafeArea(
        child: Center(
            child: GoogleMap(
                onTap: (argument) {
                  setState(() {
                    _markers.add(Marker(
                        markerId: MarkerId("Cuurent tap"),
                        position:
                            LatLng(argument.latitude, argument.longitude)));

                    // setState(() async {
                    //   _placeMarks = await placemarkFromCoordinates(
                    //       argument.latitude, argument.longitude);
                    // });
                  });
                },
                markers: _markers,
                initialCameraPosition: CameraPosition(
                    target: LatLng(initialLatitudeValue, initialLongitudeValue),
                    zoom: 10))),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _getCurrentPosition();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(_currentAddress.toString())));
      }),
    );
  }
}

/**
 * 
 * Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('LAT: ${_currentPosition?.latitude ?? ""}'),
              Text('LNG: ${_currentPosition?.longitude ?? ""}'),
              Text('ADDRESS: ${_currentAddress ?? ""}'),
              Text(
                  "Distance Between Bwp And Islmabad in Meter's : $distanceInMeters"),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _getCurrentPosition,
                child: const Text("Get Current Location"),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: checkDistanceBwBwpAndIsb,
                child: const Text("Get Distance"),
              ),
            ],
          ),


 */
