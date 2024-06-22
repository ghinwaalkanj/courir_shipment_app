import 'package:courir_shipment_app/features/shipments/screens/widgets/active_shipmetn_widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

class ShipmentToCustomerScreen extends StatelessWidget {
  final Future<void> Function() initializeMap;

  ShipmentToCustomerScreen({required this.initializeMap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 3.h,
            left: 6.w,
            right: 6.w,
          ),
          child: HeaderWidget(
            title: 'في الطريق إلى الزبون',
            subTitle: 'التالي :  تسليم الشحنة إلى الزبون',
            currentStep: 2,
            totalSteps: 2,
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
        SizedBox(
          height: 55.h,
          child: FutureBuilder(
            future: initializeMap(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error loading map'));
              } else {
                return GoogleMap(
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(37.7749, -122.4194),
                    zoom: 12,
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
