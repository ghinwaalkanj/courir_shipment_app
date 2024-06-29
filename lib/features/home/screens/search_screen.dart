import 'package:courir_shipment_app/features/home/screens/qrsearch_screen.dart';
import 'package:courir_shipment_app/features/home/screens/widgets/search_widgets/no_shipments.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../common/widgets/serch_text_field.dart';
import '../../../../utils/constants/colors.dart';
import '../../../common/styles/custom_textstyle.dart';
import '../../../common/widgets/app_bar.dart';
import '../../../common/widgets/custom_sized_box.dart';
import '../../shipments/screens/active_shipments_screen.dart';
import '../../shipments/screens/widgets/shipments_widgets/shipment_item.dart';
import '../controller/search_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    final TextEditingController searchController = TextEditingController();
    final TSearchController controller = Get.put(TSearchController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });

    void searchShipment() {
      final query = searchController.text;
      if (query.isNotEmpty) {
        controller.searchShipment(query);
      }
    }

    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: TAppBar(
        title: 'نتائج البحث',
        showBackArrow: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: TSearchFormField(
                          iscearch: true,
                          hintText: 'ابحث عن الشحنة',
                          controller: searchController,
                          focusNode: focusNode,
                          onSubmitted: (_) => searchShipment(),
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      CircularContainer(
                        onTap: searchShipment,
                        icon: Icons.search,
                        color: TColors.primary,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  } else if (controller.shipments.isEmpty) {
                    return NoShipmentsWidget();
                  } else {
                    return SizedBox(
                      height: 80.h,
                      child: ListView.builder(
                        padding: EdgeInsets.all(5.w),
                        itemCount: controller.shipments.length,
                        itemBuilder: (context, index) {
                          var shipment = controller.shipments[index];
                          return ShipmentItem(
                            onTap: () {
                              Get.to(ActiveShipmentsScreen(), arguments: {
                                'shipmentNumber':
                                    shipment.shipmentInfo.shipmentNumber
                              });
                            },
                            shipmentName:
                                shipment.shipmentInfo.shipmentContents,
                            shipmentNumber:
                                shipment.shipmentInfo.shipmentNumber,
                            senderCity: shipment.userInfo.city,
                            shipmentDate: shipment.shipmentInfo.createdAt,
                            recipientCity: shipment.recipientInfo.city,
                            estimatedDate:
                                shipment.shipmentInfo.estimatedDeliveryTime,
                          );
                        },
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
