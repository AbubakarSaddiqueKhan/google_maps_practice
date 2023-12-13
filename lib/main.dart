import 'package:flutter/material.dart';
import 'package:google_maps_flutter_f12/screens/auto_complete_google_places_api_design.dart';
import 'package:google_maps_flutter_f12/screens/geo_location_package_design.dart';
import 'package:google_maps_flutter_f12/screens/google_maps_screen_design.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMapsScreenDesign();
    // return GeoLocationPackageDesign();
    // return AutoCompleteGooglePlacesApiDesign();
  }
}
