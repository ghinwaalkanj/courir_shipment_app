import 'package:courir_shipment_app/common/widgets/app_bar.dart';
import 'package:courir_shipment_app/features/shipments/screens/order_detail_screen.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/shipments_widgets/shipment_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants/colors.dart';

class NewShipmentsScreen extends StatelessWidget {
  const NewShipmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: TAppBar(title: 'الشحنات الجديدة'),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              ListView.builder(
                padding: EdgeInsets.all(5.w),
                itemCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ShipmentItem(onTap: (){Get.to(OrderDetailScreen());},);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
