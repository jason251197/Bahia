import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
export 'package:geolocator/geolocator.dart';

class GMapController {
  static final num _zoom = 17.0;

  static Marker marker(LatLng point) => Marker(
        markerId: MarkerId(point.toString()),
        position: point,
      );
  static Marker geoMarker(Position point) => Marker(
        markerId: MarkerId(point.toString()),
        position: LatLng(point.latitude, point.longitude),
        // icon: await markerIcon(image),
      );
  static Future<BitmapDescriptor> markerIcon(String image) async {
    if (image is! String) return null;
    return await BitmapDescriptor.fromAssetImage(ImageConfiguration(), image);
  }

  static Future<Position> get currenLocation async =>
      await Geolocator.getCurrentPosition();
  static CameraPosition cameraPosition(LatLng point) =>
      CameraPosition(target: point, zoom: _zoom);
  static CameraPosition geoCameraPosition(Position point) => CameraPosition(
      target: LatLng(point.latitude, point.longitude), zoom: _zoom);

  static Future<void> redirectToLocation(
      GoogleMapController controller, LatLng point) async {
    if (point is LatLng && controller is GoogleMapController)
      controller
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition(point)));
  }
}
