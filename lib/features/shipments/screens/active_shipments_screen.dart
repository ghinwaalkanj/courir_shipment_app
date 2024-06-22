import 'package:courir_shipment_app/features/shipments/screens/widgets/active_shipmetn_widgets/active_shipments_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants/colors.dart';
import '../controller/my_tab_controller.dart';

class ActiveShipmentsScreen extends StatelessWidget {
  final MyTabController tabController = Get.put(MyTabController());

  @override
  Widget build(BuildContext context) {
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
                child: TabBar(
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
        return TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController.tabController,
          children: tabController.tabs.map((tab) {
            final tabIndex = tabController.tabs.indexOf(tab);
            return ActiveShipmentsTab(
              tabIndex: tabIndex,
              initializeMap: _initializeMap,
            );
          }).toList(),
        );
      }),
    );
  }
}

Future<void> _initializeMap() async {
  await Future.delayed(Duration(seconds: 1));
}
