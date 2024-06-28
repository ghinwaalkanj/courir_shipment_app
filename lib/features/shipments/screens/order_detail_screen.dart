import 'package:courir_shipment_app/common/widgets/app_bar.dart';
import 'package:courir_shipment_app/features/shipments/controller/update_status_controller.dart';
import 'package:courir_shipment_app/features/shipments/screens/active_shipments_screen.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/active_shipmetn_widgets/draggable_button.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/order_detil_widgets/map_widget.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/order_detil_widgets/shipment_info.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../common/styles/custom_textstyle.dart';

class OrderDetailScreen extends StatelessWidget {
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
                MapWidget(),
                DraggableConfirmButton(
                  text: 'قم بالسحب لقبول الشحنة',
                  onDragEnd: () {
                    controller.updateShipmentStatus(shipmentNumber: shipmentNumber, newStatus: 1);
                    Get.off(ActiveShipmentsScreen(), arguments: {'shipmentNumber': shipmentNumber});
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
