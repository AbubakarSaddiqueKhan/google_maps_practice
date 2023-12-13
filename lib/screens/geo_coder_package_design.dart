import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// flutter pub add flutter_geocoder
// Use to convert coordinates into address or vice versa .

// Geo coding package is much better than the geo coder package . So use it
class GeoCoderPackageDesign extends StatefulWidget {
  const GeoCoderPackageDesign({super.key});

  @override
  State<GeoCoderPackageDesign> createState() => _GeoCoderPackageDesignState();
}

class _GeoCoderPackageDesignState extends State<GeoCoderPackageDesign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Geo Coder Package Design"),
        centerTitle: true,
      ),
      body: Center(
          // child: GoogleMap(initialCameraPosition: initialCameraPosition)
          ),
    );
  }
}
