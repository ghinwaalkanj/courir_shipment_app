import 'package:courir_shipment_app/features/shipments/screens/widgets/active_shipmetn_widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../controller/new_shipment_mp_controller.dart';

class ShipmentToCustomerScreen extends StatelessWidget {
  final LatLng recipientLocation;
  final LatLng deliveryLocation;

  ShipmentToCustomerScreen({required this.recipientLocation, required this.deliveryLocation});

  Future<void> _initializeMap(NewShipmentsMapController mapController) async {
    await mapController.initialize(recipientLocation, deliveryLocation);
  }

  @override
  Widget build(BuildContext context) {
    final NewShipmentsMapController mapController = Get.put(NewShipmentsMapController());

    return FutureBuilder<void>(
      future: _initializeMap(mapController),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

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
              child: Obx(
                    () => GoogleMap(
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  onMapCreated: mapController.onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: recipientLocation,
                    zoom: 15,
                  ),
                  markers: mapController.markers.value,
                  polylines: mapController.polylines.value,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
