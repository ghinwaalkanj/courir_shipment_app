import 'package:courir_shipment_app/common/widgets/app_bar.dart';
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
    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: TAppBar(
        title: 'الشحنة 543148645',
        showBackArrow: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShipmentInfo(),
          SizedBox(height: 2.h),
          Column(
            children: [
              MapWidget(),
              DraggableConfirmButton(
                text: 'قم بالسحب لقبول الشحنة',
                onDragEnd: () {
                  // Handle the drag end action
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
