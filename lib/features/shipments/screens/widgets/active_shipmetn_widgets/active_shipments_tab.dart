import 'package:courir_shipment_app/features/Qr_code/screen/Qr_code_scan.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/active_shipmetn_widgets/shipment_customer_dialog.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/active_shipmetn_widgets/shipment_merchant_dialog.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/active_shipmetn_widgets/shipment_to_customer_sub_screen.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/active_shipmetn_widgets/shipment_to_merchant_sub_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/page_controller.dart';
import 'contact_info_widget.dart';
import 'draggable_button.dart';

class ActiveShipmentsTab extends StatelessWidget {
  final int tabIndex;
  final Future<void> Function() initializeMap;

  ActiveShipmentsTab({
    required this.tabIndex,
    required this.initializeMap,
  });

  @override
  Widget build(BuildContext context) {
    final TPageController pageController = Get.put(TPageController(), tag: 'tab$tabIndex');

    return Obx(() {
      return Stack(
        children: [
          IndexedStack(
            index: pageController.currentPage.value,
            children: [
              ShipmentToMerchantScreen(initializeMap: initializeMap),
              ShipmentToMerchantScreen(initializeMap: initializeMap),
              BarcodeScanScreen(onPressed: () {
                pageController.changePage(3);
              }),
              ShipmentToCustomerScreen(initializeMap: initializeMap),
              ShipmentToCustomerScreen(initializeMap: initializeMap),
            ],
          ),
          if (pageController.currentPage.value != 2)
            ContactInfoWidget(
              name: 'توحييييد',
              phoneNumber: '+963964724390',
            ),
          if (pageController.currentPage.value != 2)
            Padding(
              padding: EdgeInsets.only(top:76.2.h),
              child: DraggableConfirmButton(
                text: pageController.currentPage.value == 0
                    ? 'قم بالسحب عند الخروج إلى الطريق'
                    : pageController.currentPage.value == 1
                    ? 'قم بالسحب عند الوصول إلى التاجر'
                    : pageController.currentPage.value == 3
                    ? 'قم بالسحب عند الخروج إلى الزبون'
                    : 'قم بالسحب عند الوصول إلى الزبون',
                onDragEnd: () {
                  if (pageController.currentPage.value == 0) {
                    pageController.changePage(1);
                  } else if (pageController.currentPage.value == 1) {
                    showShipmentMerchantDialog(context, 500, 1500, tabIndex);
                  } else if (pageController.currentPage.value == 3) {
                    pageController.changePage(4);
                  } else {
                    showShipmentCustomerDialog(context, 50000, tabIndex);
                  }
                },
              ),
            ),
        ],
      );
    });
  }
}

