import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  var tabIndex = 0.obs;
  var tabs = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Example JSON data
    List<Map<String, dynamic>> jsonData = [
      {"title": "شحنة رقم 121564563"},
      {"title": "شحنة رقم 1554564563"},
    ];

    tabs.value = jsonData.map((data) => data['title'] as String).toList();


    tabController = TabController(length: tabs.length, vsync: this);
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
