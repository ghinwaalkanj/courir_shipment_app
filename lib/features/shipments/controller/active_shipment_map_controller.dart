import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class ActiveShipmentsMapController extends GetxController {
  var selectedLocation = LatLng(31.9539, 35.9106).obs;
  late BitmapDescriptor recipientCustomIcon;
  late GoogleMapController mapController;
  var markers = Set<Marker>().obs;

  Future<void> initialize(LatLng position) async {
    selectedLocation.value = position;
    await setCustomMarkerIcons();
    addMarker();
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
}
