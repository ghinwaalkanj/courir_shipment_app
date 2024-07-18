import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

import '../../../utils/constants/colors.dart';

class NewShipmentsMapController extends GetxController {
  var selectedLocation = LatLng(31.9539, 35.9106).obs;
  var userLocation = LatLng(31.9539, 35.9106).obs;
  late BitmapDescriptor recipientCustomIcon;
  late BitmapDescriptor userCustomIcon;
  late GoogleMapController mapController;
  var markers = Set<Marker>().obs;
  var polylines = Set<Polyline>().obs;

  Future<void> initialize(LatLng recipientPosition, LatLng userPosition) async {
    selectedLocation.value = recipientPosition;
    userLocation.value = userPosition;
    await setCustomMarkerIcons();
    addMarkers();
    await addPolyline();
  }

  Future<void> setCustomMarkerIcons() async {
    recipientCustomIcon = await createCustomMarkerIcon('assets/images/delivery_mark.png');
    userCustomIcon = await createCustomMarkerIcon('assets/images/merchant_mark.png');
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

  void addMarkers() {
    markers.add(
      Marker(
        markerId: MarkerId('recipientLocation'),
        position: selectedLocation.value,
        icon: recipientCustomIcon,
      ),
    );
    markers.add(
      Marker(
        markerId: MarkerId('userLocation'),
        position: userLocation.value,
        icon: userCustomIcon,
      ),
    );
  }

  Future<void> addPolyline() async {
    final String url = 'https://maps.googleapis.com/maps/api/directions/json?origin=${userLocation.value.latitude},${userLocation.value.longitude}&destination=${selectedLocation.value.latitude},${selectedLocation.value.longitude}&key=AIzaSyBJjDpq0S-cRzOkfeC2NtIvch3sVxXmWjs';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['routes'] != null && data['routes'].isNotEmpty) {
        final String encodedPolyline = data['routes'][0]['overview_polyline']['points'];
        final List<LatLng> polylineCoordinates = decodePolyline(encodedPolyline);

        polylines.add(
          Polyline(
            polylineId: PolylineId('route'),
            points: polylineCoordinates,
            color: TColors.primary,
            width: 5,
          ),
        );
      } else {
        print('No routes found in the response.');
      }
    } else {
      print('Failed to load directions: ${response.statusCode}');
    }
  }

  List<LatLng> decodePolyline(String polyline) {
    List<LatLng> polylineCoordinates = [];
    int index = 0, len = polyline.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      LatLng point = LatLng(lat / 1E5, lng / 1E5);
      polylineCoordinates.add(point);
    }

    return polylineCoordinates;
  }
}
