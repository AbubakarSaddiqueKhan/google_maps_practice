import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    // Call set state for rebuild
    // setState(() {});
  }
}
