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

class MyShipmentsScreen extends StatelessWidget {
  final selectedFilterIndex = 0.obs;

  void _onFilterTap(int index) {
    selectedFilterIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
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
                      icon: Icons.qr_code_scanner,
                      color: TColors.primary,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              Obx(() => FilterButtonRow(
                selectedFilterIndex: selectedFilterIndex.value,
                onTap: _onFilterTap,
              )),
              ListView.builder(
                padding: EdgeInsets.all(5.w),
                itemCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ShipmentItem();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
