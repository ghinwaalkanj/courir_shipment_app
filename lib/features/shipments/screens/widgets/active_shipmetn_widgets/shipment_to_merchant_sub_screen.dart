import 'package:courir_shipment_app/features/shipments/screens/widgets/active_shipmetn_widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../controller/active_shipment_map_controller.dart';

class ShipmentToMerchantScreen extends StatelessWidget {
  final LatLng recipientLocation;

  ShipmentToMerchantScreen({required this.recipientLocation});

  @override
  Widget build(BuildContext context) {
    final ActiveShipmentsMapController mapController = Get.put(ActiveShipmentsMapController());
    mapController.initialize(recipientLocation);

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
            title: 'في الطريق إلى التاجر',
            subTitle: 'التالي :  استلام الشحنة',
            currentStep: 1,
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
            ),
          ),
        ),
      ],
    );
  }
}
