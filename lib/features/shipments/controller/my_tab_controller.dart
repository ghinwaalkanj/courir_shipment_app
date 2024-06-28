import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_shipments_controller.dart';

class MyTabController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  var tabIndex = 0.obs;
  var tabs = <String>[].obs;
  final MyShipmentsController myShipmentsController = Get.put(MyShipmentsController());

  @override
  void onInit() {
    super.onInit();
    myShipmentsController.fetchMyShipments().then((_) {
      updateTabs();
      tabController = TabController(length: tabs.length, vsync: this);
      int initialIndex = getInitialTabIndex();
      tabController.animateTo(initialIndex);
      changeTabIndex(initialIndex);
    });
  }

  void updateTabs() {
    var filteredShipments = myShipmentsController.getActiveShipments();
    tabs.value = filteredShipments.map((shipment) => 'شحنة ${shipment.shipmentInfo.shipmentNumber}').toList();
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  int getInitialTabIndex() {
    var filteredShipments = myShipmentsController.getActiveShipments();
    return filteredShipments.indexWhere((shipment) => shipment.shipmentInfo.shipmentStatus == 1 || shipment.shipmentInfo.shipmentStatus == 2);
  }

  int getTabIndexByShipmentNumber(String shipmentNumber) {
    return tabs.indexWhere((tab) => tab.contains(shipmentNumber));
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
