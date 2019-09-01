import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowMap extends StatefulWidget {
  @override
  _ShowMapState createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  //Explicit
  static const LatLng centerMap = const LatLng(13.711870, 100.599702);
  CameraPosition cameraPosition = CameraPosition(target: centerMap, zoom: 16.0);

  //Method
  Widget showMyMap() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: cameraPosition,
      onMapCreated: (GoogleMapController googleMapController) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return showMyMap();
  }
}
