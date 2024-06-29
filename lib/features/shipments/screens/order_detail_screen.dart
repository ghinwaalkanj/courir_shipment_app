import 'package:courir_shipment_app/common/widgets/app_bar.dart';
import 'package:courir_shipment_app/features/shipments/controller/update_status_controller.dart';
import 'package:courir_shipment_app/features/shipments/screens/active_shipments_screen.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/active_shipmetn_widgets/draggable_button.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/order_detil_widgets/map_widget.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/order_detil_widgets/shipment_info.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../common/styles/custom_textstyle.dart';
import '../controller/active_shipment_map_controller.dart';

class OrderDetailScreen extends StatelessWidget {
  final LatLng recipientLocation;

  const OrderDetailScreen({super.key, required this.recipientLocation});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map;
    final shipmentNumber = arguments['shipmentNumber'];
    final deliveryPrice = arguments['deliveryPrice'];
    final shipmentPrice = arguments['shipmentPrice'];
    final shipmentDate = arguments['shipmentDate'];
    final shipmentWeight = arguments['shipmentWeight'];
    final shipmentQuantity = arguments['shipmentQuantity'];
    final controller = Get.put(UpdateShipmentStatusController());
    final ActiveShipmentsMapController mapController = Get.put(ActiveShipmentsMapController());
    mapController.initialize(recipientLocation);

    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: TAppBar(
        title: 'الشحنة  $shipmentNumber',
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShipmentInfo(
              price: shipmentPrice,
              date: shipmentDate,
              weight: shipmentWeight.toString(),
              quantity: shipmentQuantity.toString(),
              delivery: deliveryPrice,
            ),
            SizedBox(height: 1.h),
            Column(
              children: [
                SizedBox(
                  height: 57.5.h,
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
                DraggableConfirmButton(
                  text: 'قم بالسحب لقبول الشحنة',
                  onDragEnd: () async {
                    bool success = await controller.updateShipmentStatus(shipmentNumber: shipmentNumber, newStatus: 1);
                    if (success) {
                      Get.off(ActiveShipmentsScreen(), arguments: {'shipmentNumber': shipmentNumber});
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
