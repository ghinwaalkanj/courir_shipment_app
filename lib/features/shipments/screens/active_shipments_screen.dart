import 'package:courir_shipment_app/common/styles/custom_textstyle.dart';
import 'package:courir_shipment_app/features/shipments/screens/new_shipments_screen.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/active_shipmetn_widgets/active_shipments_tab.dart';
import 'package:courir_shipment_app/navigation_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../common/widgets/snack_bars/success_snack_bar.dart';
import '../../../core/services/storage_service.dart';
import '../../../utils/constants/colors.dart';
import '../controller/announcement_controller.dart';
import '../controller/my_tab_controller.dart';
import '../controller/my_shipments_controller.dart';
import '../controller/new_shipments_controller.dart';

class ActiveShipmentsScreen extends StatelessWidget {
  final MyTabController tabController = Get.put(MyTabController());
  final MyShipmentsController myShipmentsController =
      Get.put(MyShipmentsController());
  final AnnouncementController announcementController =
      Get.put(AnnouncementController());
  final controller = Get.put(NewShipmentsController());

  void _showAnnouncementDialog(
      BuildContext context, int shipmentId, int deliveryId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'إضافة بلاغ',
            style: CustomTextStyle.primaryTextStyle.apply(fontSizeDelta: 5),
            textDirection: TextDirection.rtl,
          ),
          content: Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    textDirection: TextDirection.rtl,
                    controller:
                        announcementController.announcementTextController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'اكتب البلاغ هنا',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: TColors.primary,
                        ),
                      ),
                    ),
                    maxLines: 3,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TColors.primary,
                      ),
                      onPressed: () async {
                        if (announcementController
                            .announcementTextController.text.isEmpty) {
                          Get.snackbar(
                            'خطأ',
                            'يجب عليك كتابة البلاغ',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                            margin: EdgeInsets.all(10),
                            borderRadius: 10,
                            icon:
                                Icon(Icons.error_outline, color: Colors.white),
                            duration: Duration(seconds: 5),
                          );
                        } else {
                          final response =
                              await announcementController.submitAnnouncement(
                            shipmentId: shipmentId,
                            deliveryId: deliveryId,
                            announcementText: announcementController
                                .announcementTextController.text,
                          );

                          if (response != null && response.status) {
                            SuccessSnackbar.show('تم إضافة البلاغ بنجاح');
                            Navigator.of(context).pop();
                          } else {
                            Get.snackbar(
                              'خطأ',
                              'فشل في إضافة البلاغ',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.TOP,
                              margin: EdgeInsets.all(10),
                              borderRadius: 10,
                              icon: Icon(Icons.error_outline,
                                  color: Colors.white),
                              duration: Duration(seconds: 5),
                            );
                          }
                        }
                      },
                      child:
                          Text('تأكيد', style: TextStyle(color: TColors.white)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('إلغاء',
                          style: TextStyle(color: TColors.primary)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map?;
    final shipmentNumber = arguments?['shipmentNumber'];
    final shipmentId = arguments?['shipmentId'];
    final activeShipments = myShipmentsController.getActiveShipments();

    return WillPopScope(
      onWillPop: () async {
        controller.fetchNewShipments();
        myShipmentsController.fetchMyShipments();
       Get.to(NavigationMenu());
       return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: TColors.bg,
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: 7.w, top: 1.8.h),
            child: IconButton(
                onPressed: () async {
                  var delivery =
                      await SharedPreferencesHelper.getInt('user_id');
                  if (activeShipments.isNotEmpty) {
                    _showAnnouncementDialog(context, shipmentId, delivery!);
                  }
                },
                icon: Icon(
                  Iconsax.warning_2,
                  color: TColors.error,
                  size: 25.sp,
                )),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: Obx(() {
              return Directionality(
                textDirection: TextDirection.rtl,
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
              );
            }),
          ),
        ),
        body: Obx(() {
          if (tabController.tabs.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          final filteredShipments = myShipmentsController.getActiveShipments();

          if (shipmentNumber != null) {
            final index =
                tabController.getTabIndexByShipmentNumber(shipmentNumber);
            if (index != -1) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                tabController.tabController.animateTo(index);
              });
            }
          }

          if (filteredShipments.isEmpty) {
            return Center(child: Text('No shipments available.'));
          }

          return TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: tabController.tabController,
            children: tabController.tabs.map((tab) {
              final tabIndex = tabController.tabs.indexOf(tab);

              if (tabIndex >= filteredShipments.length) {
                return Center(child: Text('No shipments available.'));
              }

              final shipment = filteredShipments[tabIndex];
              return ActiveShipmentsTab(
                tabIndex: tabIndex,
                shipmentNumber: shipment.shipmentInfo.shipmentNumber,
                merchantName: shipment.userInfo.name,
                merchantPhone: shipment.userInfo.phone,
                customerName: shipment.recipientInfo.name,
                customerPhone: shipment.recipientInfo.phone,
                shipmentAmount:
                    double.parse(shipment.shipmentInfo.shipmentValue),
                deliveryFee: double.parse(shipment.shipmentInfo.shipmentFee),
                initialStatus: shipment.shipmentInfo.shipmentStatus,
                recipientLocation: LatLng(
                    double.parse(shipment.recipientInfo.lat),
                    double.parse(shipment.recipientInfo.long)),
                merchentLocation: LatLng(
                  double.parse(shipment.userInfo.fromAddressLat),
                  double.parse(shipment.userInfo.fromAddressLong),
                ),
                shipmentId: shipment.shipmentInfo.shipmentId,
                id: shipment.userInfo.id,
              );
            }).toList(),
          );
        }),
      ),
    );
  }
}
