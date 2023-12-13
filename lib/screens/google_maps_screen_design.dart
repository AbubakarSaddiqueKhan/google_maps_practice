import 'dart:async';
import 'dart:ffi';
import 'dart:math';
// ext.kotlin_version = '1.7.10'

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'dart:ui' as ui;
import 'dart:ui';

class GoogleMapsScreenDesign extends StatefulWidget {
  const GoogleMapsScreenDesign({super.key});

  @override
  State<GoogleMapsScreenDesign> createState() => _GoogleMapsScreenDesignState();
}

Set<Marker> _marker = <Marker>{};

List<String> icons = <String>[
  "assets/images/chef.png",
  "assets/images/cocktail.png",
  "assets/images/family.png",
  "assets/images/love.png",
  "assets/images/pen.png",
  "assets/images/snowman.png",
];

List<LatLng> latLngValues = const <LatLng>[
  LatLng(29.395721, 71.673334),
  LatLng(29.394721, 71.683334),
  LatLng(29.396721, 71.663334),
  LatLng(29.385721, 71.685334),
  LatLng(29.395821, 71.683334),
  LatLng(29.393721, 71.675334),
];

late CustomInfoWindowController _customInfoWindowController;

Random random = Random();
void loadCustomInfoWindowData() {
  for (var index = 0; index < latLngValues.length; index++) {
    _marker.add(Marker(
        markerId: MarkerId(index.toString()),
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    color: Color.fromARGB(
                        random.nextInt(0xFF),
                        random.nextInt(0xFF),
                        random.nextInt(0xFF),
                        random.nextInt(0xFF))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 150,
                      width: 200,
                      child: Image.asset(
                        icons[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      child: FittedBox(
                        child: Text(
                            "This is custom info window for mark of $index"),
                      ),
                    )
                  ],
                ),
              ),
              latLngValues[index]);
        },
        icon: BitmapDescriptor.defaultMarker,
        position: latLngValues[index]));
  }
}

const double initialLatitudeValue = 29.395721;
const double initialLongitudeValue = 71.683334;

const double islamabadLatValue = 33.738045;
const double islamabadLongValue = 73.084488;

MapType _mapType = MapType.normal;

class _GoogleMapsScreenDesignState extends State<GoogleMapsScreenDesign> {
  // late GoogleMapController _googleMapController;

  Completer<GoogleMapController> _googleMapControllerCompleter =
      Completer<GoogleMapController>();
  final CameraPosition _initialCameraPosition = const CameraPosition(
    // The target property is used to set the value of the given position in latitude and the longitude .

    target: LatLng(initialLatitudeValue, initialLongitudeValue),
    // According to the official documentation .
    // The camera's bearing in degrees, measured clockwise from north.
    // A bearing of 0.0, the default, means the camera points north. A bearing of 90.0 means the camera points east.

    // bearing: 150,

    // According to the official documentation .
    // The angle, in degrees, of the camera angle from the nadir.
    // A tilt of 0.0, the default and minimum supported value, means the camera is directly facing the Earth.
    // Note :
    // The   maximum tilt value depends on the current zoom level. Values beyond the supported range are allowed, but on applying them to a map they will be silently clamped to the supported range.

    // tilt: 40,

    // According to the official documentation .
    // The zoom level of the camera.
    // A zoom of 0.0, the default, means the screen width of the world is 256. Adding 1.0 to the zoom level doubles the screen width of the map. So at zoom level 3.0, the screen width of the world is 2³x256=2048.
    // Larger zoom levels thus means the camera is placed closer to the surface of the Earth, revealing more detail in a narrower geographical region.
    // Note :
    // The supported zoom level range depends on the map data and device. Values beyond the supported range are allowed, but on applying them to a map they will be silently clamped to the supported range.
    zoom: 10,
  );

  // This method is called when the map is created and takes the GoogleMapController as its parameter.

  void _onMapCreated(GoogleMapController googleMapController) {
    _googleMapControllerCompleter.complete(googleMapController);
    googleMapController.setMapStyle(mapTheme);

    // _customInfoWindowController.googleMapController = googleMapController;
  }

  void changeMapTypeToHybrid() {
    setState(() {
      _mapType = MapType.hybrid;
    });
  }

  void changeMapTypeToNone() {
    setState(() {
      _mapType = MapType.none;
    });
  }

  void changeMapTypeToSatellite() {
    setState(() {
      _mapType = MapType.satellite;
    });
  }

  void changeMapTypeToTerrain() {
    setState(() {
      _mapType = MapType.terrain;
    });
  }

  void changeMapThemeToAubergine() {
    setState(() {
      _googleMapControllerCompleter.future.then((value) {
        DefaultAssetBundle.of(context)
            .loadString("assets/maptheme/aubergine_theme.json")
            .then((value) {
          mapTheme = value;
        });
      });
    });
  }

  void changeMapThemeToDark() {
    setState(() {
      _googleMapControllerCompleter.future.then((value) {
        DefaultAssetBundle.of(context)
            .loadString("assets/maptheme/dark_theme.json")
            .then((value) {
          mapTheme = value;
        });
      });
    });
  }

  void changeMapThemeToNight() {
    setState(() {
      _googleMapControllerCompleter.future.then((value) {
        DefaultAssetBundle.of(context)
            .loadString("assets/maptheme/night_theme.json")
            .then((value) {
          mapTheme = value;
        });
      });
    });
  }

  void changeMapThemeToRetro() {
    setState(() {
      _googleMapControllerCompleter.future.then((value) {
        DefaultAssetBundle.of(context)
            .loadString("assets/maptheme/retro_theme.json")
            .then((value) {
          mapTheme = value;
        });
      });
    });
  }

  void changeMapThemeToSilver() {
    setState(() {
      _googleMapControllerCompleter.future.then((value) {
        DefaultAssetBundle.of(context)
            .loadString("assets/maptheme/silver_theme.json")
            .then((value) {
          mapTheme = value;
        });
      });
    });
  }

// Change the marker design .
  var markerIcon;
  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/Location_marker.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  void setMarker() {
    print("sbdcjdbcdcbfjbjdfjbvbdjfbvjbdjfbvjebvl");
    setState(() {
      _marker = <Marker>{
        Marker(
            markerId: MarkerId("Bahwalpur"),
            position: LatLng(initialLatitudeValue, initialLongitudeValue))
      };
    });
  }

  // void goToIslamabad() async {
  //   print("in");
  //   GoogleMapController googleMapController =
  //       await _googleMapControllerCompleter.future;
  //   // According to the official documentation .
  //   // Starts an animated change of the map camera position.
  //   // The returned [Future] completes after the change has been started on the platform side.
  //   googleMapController.animateCamera(
  //       CameraUpdate.newLatLng(LatLng(islamabadLatValue, islamabadLongValue))
  //       // CameraUpdate.newCameraPosition(CameraPosition(target: latl))
  //       );

  //   print("///////////////////////////////////////////////////out");
  // }

  double? currentLocationLatitude;
  double? currentLocationLongitude;
  Future getCurrentLocation() async {
    // try {
    //   var userLocation = await Location().getLocation();
    //   setState(() {
    //     currentLocationLongitude = userLocation.longitude;
    //     currentLocationLatitude = userLocation.latitude;

    //     _marker.add(Marker(
    //         markerId: const MarkerId("Current Location"),
    //         position:
    //             LatLng(currentLocationLatitude!, currentLocationLongitude!)));
    //   });
    // } on Exception catch (e) {
    //   print('Could not get location: ${e.toString()}');
    // }
  }

  Future<void> _goToNewYork() async {
    // double lat = 40.7128;
    // double long = -74.0060;

    GoogleMapController controller = await _googleMapControllerCompleter.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(islamabadLatValue, islamabadLongValue), 9));
    setState(() {
      _marker = <Marker>{
        Marker(
            // Marker Id must be unique
            markerId: MarkerId("Islamabad"),
            position: LatLng(islamabadLatValue, islamabadLongValue),
            infoWindow: InfoWindow(
                // The title of the info window will be displayed on the marker ass the label when the user click's on taht specific marker .
                title: "Islamabad"))
      };
    });
  }

  Uint8List? markerImage;

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<Uint8List?> getBytesFromNetworkImage(String imagePath) async {
    final completer = Completer<ImageInfo>();
    var networkImage = NetworkImage(imagePath);
    networkImage.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completer.complete(info)));

    final imageInfo = await completer.future;

    final byteData =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

// same as the simple load image from assets's image
  void loadCustomMarkerFormNetworkImage() async {
    for (var index = 0; index < icons.length; index++) {
      // The network image path is provided here .
      Uint8List? images = await getBytesFromNetworkImage(
          "https://img.freepik.com/premium-photo/generative-ai-cute-lion-sitting-isolated-white-background_634053-3817.jpg?w=740");
      final ui.Codec markerNetworkImageCodec = await ui.instantiateImageCodec(
          images!.buffer.asUint8List(),
          targetHeight: 100,
          targetWidth: 100);

      final ui.FrameInfo frameInfo =
          await markerNetworkImageCodec.getNextFrame();
      final ByteData? byteData =
          await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);

      final Uint8List resizedImageMarker = byteData!.buffer.asUint8List();
      _marker.add(
        Marker(
            markerId: MarkerId(index.toString()),
            position: latLngValues[index],
            infoWindow: InfoWindow(
              title: "This is $index Marker",
            ),
            icon: BitmapDescriptor.fromBytes(resizedImageMarker)),
      );
      setState(() {});
    }
  }

  void loadCustomMarkersData() async {
    for (var index = 0; index < icons.length; index++) {
      final Uint8List markerIcon = await getBytesFromAssets(icons[index], 100);
      _marker.add(
        Marker(
            markerId: MarkerId(index.toString()),
            position: latLngValues[index],
            infoWindow: InfoWindow(
              title: "This is $index Marker",
            ),
            icon: BitmapDescriptor.fromBytes(markerIcon)),
      );
      setState(() {});
    }
  }

  void checkForPermission() async {
    print("Entered //////////////////////////////// ");
    Location location = new Location();

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

  Future<bool> _handleLocationPermissionByGeoLocatorPackage() async {
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

  String mapTheme = "";

  @override
  void initState() {
    super.initState();
    // You can also set the value on the click event of the button for user wanted theme .
    // DefaultAssetBundle.of(context)
    //     .loadString("assets/maptheme/night_theme.json")
    //     .then((value) {
    //   mapTheme = value;
    // });

    // loadCustomMarkersData();
    _customInfoWindowController = CustomInfoWindowController();
    // loadCustomInfoWindowData();
    // loadCustomMarkerFormNetworkImage();
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Maps Flutter"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: GoogleMap(
              // According to the official documentation .
              // Enables or disables showing 3D buildings where available
              // By default's set to true .
              buildingsEnabled: false,

              // According to the official documentation .
              // A map ID is an identifier that's associated with a specific map style or feature. Configure a map style and associate it with a map ID in the Google Cloud Console
              // cloudMapId: "",

              // Circle are used to place the circle on the map .
              // circles: <Circle>{
              //   Circle(
              //       circleId: CircleId("C1"),
              //       center: LatLng(initialLatitudeValue, initialLongitudeValue),
              //       consumeTapEvents: true,
              //       fillColor: Colors.red.shade200,
              //       onTap: () {
              //         print("Circle is Tapped");
              //       },
              //       radius: 3000,
              //       strokeColor: Colors.amber,
              //       strokeWidth: 1,
              //       visible: true,
              //       zIndex: 10)
              // },

              // Whether the compass icon will be displayed on the screen or not .
              // By default it set's to true .
              compassEnabled: true,

              // According to the official documentation .
              // True if 45 degree imagery should be enabled. Web only.
              // fortyFiveDegreeImageryEnabled: true,

              // According to the official documentation .
              // Which gestures should be consumed by the map.
              // It is possible for other gesture recognizers to be competing with the map on pointer events, e.g if the map is inside a [ListView] the [ListView] will want to handle vertical drags. The map will claim gestures that are recognized by any of the recognizers on this list.
              // When this set is empty, the map will only handle pointer events for gestures that were not claimed by any other gesture recognizer.
              // Here you can specify the type of the gesture which can be used by the maps .
              // gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              //   Factory(() {
              //     return TapGestureRecognizer();
              //   })
              // },

              // According to the official documentation .
              //Enables or disables the indoor view from the map
              // by default it is set to false .
              // indoorViewEnabled: true,

              // Layout direction is used to set the text direction .
              // layoutDirection: TextDirection.ltr,

              // According to the official documentation .
              // True if the map view should be in lite mode. Android only.
              // By default it is set to false .
              // liteModeEnabled: true,

              // According to the official documentation .
              // True if the map should show a toolbar when you interact with the map. Android only.
              // by default set to true .
              // mapToolbarEnabled: false,

              // It is used to set the mib or max zoom .
              // According to the official documentation .
              // Preferred bounds for the camera zoom level.
              // Actual bounds depend on map data and device.
              // minMaxZoomPreference: MinMaxZoomPreference(5,20),

              // Whether my current location is enabled or not
              // According to the official documentation
              // True if a "My Location" layer should be shown on the map.
              // This layer includes a location indicator at the current device location, as well as a My Location button.
              // myLocationEnabled: true,

              // According to the official documentation .
              // Called when camera movement has ended, there are no pending animations and the user has stopped interacting with the map.
              onCameraIdle: () {
                print("Camera is on Idle mode");
              },

              // According to the official documentation .
              // Called repeatedly as the camera continues to move after an onCameraMoveStarted call.
              // This may be called as often as once every frame and should not perform expensive operations

              onCameraMove: (position) {
                print(position);
              },

              // According to the official documentation .
              // Called when the camera starts moving.
              // Note :
              // This can be initiated by the following:
              // Non-gesture animation initiated in response to user actions. For example: zoom buttons, my location button, or marker clicks.
              // Programmatically initiated animation.
              // Camera motion initiated in response to user gestures on the map. For example: pan, tilt, pinch to zoom, or rotate.

              onCameraMoveStarted: () {
                _customInfoWindowController.onCameraMove!;
                print("camera move start's");
              },

              onLongPress: (argument) {
                print("On  Long Tap : $argument");
                print(" Latitude on long tap  : ${argument.latitude}");
                print("Longitude on long tap : ${argument.longitude}");
              },

              onTap: (argument) {
                _customInfoWindowController.hideInfoWindow;
                print("On simple Tap : $argument");
                print(" Latitude on simple tap  : ${argument.latitude}");
                print("Longitude on simple tap : ${argument.longitude}");

                setState(() {
                  _marker.add(Marker(
                      markerId: MarkerId(
                          "${(argument.latitude + argument.longitude) / 4}"),
                      position: LatLng(argument.latitude, argument.longitude)));
                });
                // var addresses ;
                // setState(() async {
                //   final coordinates = new Coordinates(1.10, 45.50);
                //    addresses = await Geocoder.local
                //       .findAddressesFromCoordinates(coordinates);

                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${addresses}")));

                // });
              },

              // padding: EdgeInsets.all(30),

              // According to the official documentation .
              // A polyline is a linear overlay of connected line segments on the map.
              polylines: <Polyline>{
                Polyline(
                    polylineId: PolylineId("P1"),
                    color: Colors.purple.shade400,
                    width: 20,
                    endCap: Cap.roundCap,
                    jointType: JointType.bevel,
                    startCap: Cap.squareCap,
                    visible: true,
                    points: [
                      LatLng(25.774, -80.19),
                      LatLng(18.466, -66.118),
                      LatLng(32.321, -64.757),
                      LatLng(25.774, -80.19),
                    ])
              },

              // Whether the rotate gesture of the map is on or not .
              // According to the official documentation .
              // True if the map view should respond to rotate gestures.
              // by default it is set to true .
              // rotateGesturesEnabled: false ,

              // According to the official documentation .
              // True if the map view should respond to tilt gestures.
              // By default it is set to true .
              // tiltGesturesEnabled: false ,

              // According to the official documentation .
              // A tile overlay, sometimes called a tile layer, is a collection of images that are displayed on top of the base map tiles
              //A TileOverlay defines a set of images that are added on top of the base map tiles.
              // You need to provide the tiles for each zoom level that you want to support. If you have enough tiles at multiple zoom levels, you can supplement Google's map data for the entire map.\\\\\\
              // Tile overlays are useful when you want to add extensive imagery to the map, typically covering large geographical areas. In contrast, ground overlays are useful when you wish to fix a single image at one area on the map.
              tileOverlays: {
                TileOverlay(
                  tileOverlayId: TileOverlayId("T1"),
                  fadeIn: false,
                  tileSize: 800,
                  visible: true,
                )
              },

              // According to the official documentation .
              // Enables or disables the traffic layer of the map
              // by default the traffic is set to false .
              // trafficEnabled: true ,

              // According to the official documentation .
              // True if the map view should show zoom controls. This includes two buttons to zoom in and zoom out. The default value is to show zoom controls.
              // This is only supported on Android. And this field is silently ignored on iOS.
              // By default it is set to true .
              zoomControlsEnabled: false,

              // According to the official documentation .
              // This setting controls how the API handles gestures on the map. Web only.
              // WebGestureHandling is used to set the web gesture handling property .
              // this enum have only four constant values .
              webGestureHandling: WebGestureHandling.auto,

              // According to the official documentation .
              // True if the map view should respond to zoom gestures.
              // by default it is set to true .
              //  zoomGesturesEnabled: false,

              // According to the official documentation .
              // A polygon (like a polyline) defines a series of connected coordinates in an ordered sequence. Additionally, polygons form a closed loop and define a filled region.
              // polygons: <Polygon>{
              //   // Polygon is same as the circle but it is used to draw the multi sided shape on the map .
              //   // Polygon on the bermuda triangle .
              //   Polygon(
              //       polygonId: PolygonId("P1"),
              //       fillColor: Colors.red.shade200,
              //       points: [
              //         LatLng(25.774, -80.19),
              //         LatLng(18.466, -66.118),
              //         LatLng(32.321, -64.757),
              //         LatLng(25.774, -80.19),
              //       ],
              //       strokeColor: Colors.amber.shade100,
              //       visible: true,
              //       strokeWidth: 2,
              //       zIndex: 20)
              // },

              // Used to set the padding around the map
              // padding: EdgeInsets.all(20),

              // According to the official documentation .
              // Geographical bounding box for the camera target.
              // According to the official documentation .
              // Creates a camera target bounds with the specified bounding box, or null to indicate that the camera target is not bounded.
              // Used to set the position of the camera .
              // cameraTargetBounds: CameraTargetBounds(
              //     //     // According to the official documentation .
              //     //     // Creates a new bounds based on a southwest and a northeast corner.
              //     LatLngBounds(
              //         southwest:
              //             LatLng(initialLatitudeValue, initialLongitudeValue),
              //         northeast:
              //             LatLng(initialLongitudeValue, initialLatitudeValue))),

              // circles: <Circle>{
              //   Circle(circleId: CircleId("Circle"),center: )
              // },

              // Maker's are used to add the icon on the map to indicate the place .
              markers: _marker,
              // The camera position class is used as the initial camera position in the flutter google map widget .

              // initialCameraPosition: CameraPosition(target: LatLng(initialLatitudeValue, initialLongitudeValue) )),
              initialCameraPosition: _initialCameraPosition,
              // According to the official documentation .
              /// [AssertionError] is thrown if [bearing], [target], [tilt], or [zoom] are null.
              // Whether the current location of the user is enabled or not by button .
              // By default it is set to true .
              // According to the official documentation .
              // Enables or disables the my-location button.
              // The my-location button causes the camera to move such that the user's location is in the center of the map. If the button is enabled, it is only shown when the my-location layer is enabled.
              myLocationButtonEnabled: true,
              onMapCreated: _onMapCreated,
              // Map type is used to set the type of the map
              // Normal displays the default road map view. This is the default map type.
              // satellite displays Google Earth satellite images.
              // hybrid displays a mixture of normal and satellite views.
              // terrain displays a physical map based on terrain information.
              mapType: _mapType,
              // For detailed information kindly read it from the official documentation .
              // https://developers.google.com/maps/documentation/javascript/maptypes
            ),
          ),
          Positioned(
              left: 20,
              bottom: 70,
              child: Row(
                children: [
                  TextButton(
                      onPressed: changeMapThemeToAubergine, child: Text("a")),
                  TextButton(onPressed: changeMapThemeToDark, child: Text("d")),
                  TextButton(
                      onPressed: changeMapThemeToNight, child: Text("n")),
                  TextButton(
                      onPressed: changeMapThemeToRetro, child: Text("r")),
                  TextButton(
                      onPressed: changeMapThemeToSilver, child: Text("s"))
                ],
              )),
          Positioned(
              left: 50,
              bottom: 0,
              child: Row(
                children: [
                  TextButton(
                      onPressed: changeMapTypeToHybrid, child: Text("H")),
                  TextButton(onPressed: changeMapTypeToNone, child: Text("N")),
                  TextButton(
                      onPressed: changeMapTypeToSatellite, child: Text("S")),
                  TextButton(
                      onPressed: changeMapTypeToTerrain, child: Text("T"))
                ],
              )),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 100,
            width: 200,
            offset: 10,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: checkForPermission,
        child: Icon(Icons.mode_of_travel_outlined),
      ),
    );
  }
}
