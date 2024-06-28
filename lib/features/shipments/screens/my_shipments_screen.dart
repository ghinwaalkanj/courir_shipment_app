import 'package:courir_shipment_app/common/styles/custom_textstyle.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/shipments_widgets/FilterButtonRow.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/shipments_widgets/shipment_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../common/widgets/app_bar.dart';
import '../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../utils/constants/colors.dart';
import '../../home/screens/qrsearch_screen.dart';
import '../../home/screens/search_screen.dart';
import '../controller/my_shipments_controller.dart';

class MyShipmentsScreen extends StatelessWidget {
  final selectedFilterIndex = 1.obs;

  void _onFilterTap(int index, MyShipmentsController controller) {
    selectedFilterIndex.value = index;
    controller.fetchMyShipments();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyShipmentsController());

    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: TAppBar(
        title: 'الشحنات',
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  children: [
                    TSearchContainer(
                      text: "ابحث عن الشحنة",
                      onTap: () {
                        Get.to(SearchScreen());
                      },
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    CircularContainer(
                      onTap: () {
                        Get.to(BarcodeSearchScreen());
                      },
                      icon: Icons.search,
                      color: TColors.primary,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              Obx(() => FilterButtonRow(
                selectedFilterIndex: selectedFilterIndex.value,
                onTap: (index) => _onFilterTap(index, controller),
              )),
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                var filteredShipments = controller.filterShipments(selectedFilterIndex.value);
                if (filteredShipments.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(height: 7.h,),
                        Image(
                          image: AssetImage(
                              'assets/images/sammy-line-man-checking-mailbox.png'),
                          height: 30.h,
                        ),
                        SizedBox(height: 3.h,),
                        Text('لا يوجد شحنات', style: CustomTextStyle.primaryTextStyle,),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.all(5.w),
                  itemCount: filteredShipments.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final shipment = filteredShipments[index];
                    return ShipmentItem(
                      shipmentName: shipment.shipmentInfo.shipmentContents,
                      shipmentNumber: shipment.shipmentInfo.shipmentNumber,
                      senderCity: shipment.userInfo.city,
                      shipmentDate: shipment.shipmentInfo.createdAt,
                      recipientCity: shipment.recipientInfo.city,
                      estimatedDate: shipment.shipmentInfo.estimatedDeliveryTime,
                      courierEarnings: shipment.shipmentInfo.courierEarnings.toString(),
                      onTap: () {},
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
