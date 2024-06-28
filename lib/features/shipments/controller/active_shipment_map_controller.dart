import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui' as ui;

class ActiveShipmentsMapController extends GetxController {
  late final LatLng initialPosition;
  var selectedLocation = LatLng(31.9539, 35.9106).obs; // Default coordinates of Amman
  late BitmapDescriptor recipientCustomIcon;
  late GoogleMapController mapController;
  var markers = Set<Marker>().obs;
  var polylines = Set<Polyline>().obs;
  var currentPosition = LatLng(0, 0).obs;

  Future<void> initialize(LatLng position) async {
    initialPosition = position;
    selectedLocation.value = position;
    await setCustomMarkerIcons();
    await getCurrentLocation();
    addMarker();
    drawPolyline();
  }

  Future<void> setCustomMarkerIcons() async {
    recipientCustomIcon = await createCustomMarkerIcon('assets/images/recipent_mark.png');
  }

  Future<BitmapDescriptor> createCustomMarkerIcon(String assetPath) async {
    final ByteData byteData = await rootBundle.load(assetPath);
    final Uint8List imageData = byteData.buffer.asUint8List();

    final ui.Codec codec = await ui.instantiateImageCodec(imageData,
        targetWidth: 70, targetHeight: 100);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ByteData? resizedImageData =
    await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List resizedImageBytes = resizedImageData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(resizedImageBytes);
  }

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition.value = LatLng(position.latitude, position.longitude);
    markers.add(
      Marker(
        markerId: MarkerId('currentLocation'),
        position: currentPosition.value,
        infoWindow: InfoWindow(title: 'My Location'),
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.animateCamera(
      CameraUpdate.newLatLngZoom(selectedLocation.value, 12), // Focus on the selected location with appropriate zoom level
    );
  }

  void addMarker() {
    markers.add(
      Marker(
        markerId: MarkerId('recipientLocation'),
        position: selectedLocation.value,
        icon: recipientCustomIcon,
      ),
    );
  }

  void drawPolyline() {
    polylines.add(
      Polyline(
        polylineId: PolylineId('line1'),
        visible: true,
        points: [currentPosition.value, selectedLocation.value],
        width: 4,
        color: Colors.blue,
      ),
    );
  }
}
