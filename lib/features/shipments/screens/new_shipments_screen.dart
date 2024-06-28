import 'package:courir_shipment_app/common/styles/custom_textstyle.dart';
import 'package:courir_shipment_app/common/widgets/app_bar.dart';
import 'package:courir_shipment_app/features/shipments/screens/order_detail_screen.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/shipments_widgets/shipment_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants/colors.dart';
import '../controller/new_shipments_controller.dart';

class NewShipmentsScreen extends StatelessWidget {
  const NewShipmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewShipmentsController());

    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: TAppBar(title: 'الشحنات الجديدة'),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (controller.shipments.isEmpty) {
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/images/sammy-line-man-checking-mailbox.png')),
                SizedBox(height: 2.h,),
                Text('لا توجد شحنات جديدة',style:CustomTextStyle.primaryTextStyle),
              ],
            ));
          }
          return SingleChildScrollView(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  ListView.builder(
                    padding: EdgeInsets.all(5.w),
                    itemCount: controller.shipments.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final shipment = controller.shipments[index];
                      return ShipmentItem(
                        shipmentName: shipment.shipmentInfo.shipmentContents,
                        shipmentNumber: shipment.shipmentInfo.shipmentNumber,
                        senderCity: shipment.userInfo.city,
                        shipmentDate: shipment.shipmentInfo.createdAt,
                        recipientCity: shipment.recipientInfo.city,
                        estimatedDate:
                            shipment.shipmentInfo.estimatedDeliveryTime,
                        courierEarnings:
                            shipment.shipmentInfo.courierEarnings.toString(),
                        onTap: () {
                          print(shipment.shipmentInfo.courierEarnings);
                          Get.to(
                            OrderDetailScreen(),
                            arguments: {
                              'shipmentNumber':
                                  shipment.shipmentInfo.shipmentNumber,
                              'deliveryPrice':
                                  shipment.shipmentInfo.shipmentFee,
                              'shipmentPrice':
                                  shipment.shipmentInfo.shipmentValue,
                              'shipmentDate': shipment.shipmentInfo.createdAt,
                              'shipmentWeight':
                                  shipment.shipmentInfo.shipmentWeight,
                              'shipmentQuantity': shipment
                                  .shipmentInfo.shipmentQuantity
                                  .toString(),
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
