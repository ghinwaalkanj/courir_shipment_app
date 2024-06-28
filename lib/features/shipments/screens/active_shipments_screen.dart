import 'package:courir_shipment_app/features/shipments/screens/widgets/active_shipmetn_widgets/active_shipments_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants/colors.dart';
import '../controller/my_tab_controller.dart';
import '../controller/my_shipments_controller.dart';

class ActiveShipmentsScreen extends StatelessWidget {
  final MyTabController tabController = Get.put(MyTabController());
  final MyShipmentsController myShipmentsController = Get.put(MyShipmentsController());

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map?;
    final shipmentNumber = arguments?['shipmentNumber'];

    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Obx(() {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Transform.translate(
                offset: Offset(12.w, 0),
                child: tabController.tabs.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : TabBar(
                  isScrollable: tabController.tabs.length > 1,
                  controller: tabController.tabController,
                  tabs: tabController.tabs.map((tab) {
                    return Tab(
                      text: tab,
                    );
                  }).toList(),
                  indicatorColor: TColors.primary,
                  labelColor: TColors.primary,
                  unselectedLabelColor: TColors.grey,
                  labelStyle: TextStyle(fontSize: 16.0),
                  unselectedLabelStyle: TextStyle(fontSize: 14.0),
                ),
              ),
            );
          }),
        ),
      ),
      body: Obx(() {
        if (tabController.tabs.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        if (shipmentNumber != null) {
          final index = tabController.getTabIndexByShipmentNumber(shipmentNumber);
          tabController.tabController.animateTo(index);
        }
        return TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController.tabController,
          children: tabController.tabs.map((tab) {
            final tabIndex = tabController.tabs.indexOf(tab);
            final filteredShipments = myShipmentsController.shipments
                .where((shipment) =>
            shipment.shipmentInfo.shipmentStatus != 7 &&
                shipment.shipmentInfo.shipmentStatus != 9)
                .toList();
            final shipment = filteredShipments[tabIndex];
            return ActiveShipmentsTab(
              tabIndex: tabIndex,
              shipmentNumber: shipment.shipmentInfo.shipmentNumber,
              merchantName: shipment.userInfo.name,
              merchantPhone: shipment.userInfo.phone,
              customerName: shipment.recipientInfo.name,
              customerPhone: shipment.recipientInfo.phone,
              shipmentAmount: double.parse(shipment.shipmentInfo.shipmentValue),
              deliveryFee: double.parse(shipment.shipmentInfo.shipmentFee),
              initialStatus: shipment.shipmentInfo.shipmentStatus, recipientLocation: LatLng(double.parse(shipment.recipientInfo.lat), double.parse(shipment.recipientInfo.long)),
            );
          }).toList(),
        );
      }),
    );
  }
}
