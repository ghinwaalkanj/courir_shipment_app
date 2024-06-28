import 'package:courir_shipment_app/features/Qr_code/screen/Qr_code_scan.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/active_shipmetn_widgets/shipment_customer_dialog.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/active_shipmetn_widgets/shipment_merchant_dialog.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/active_shipmetn_widgets/shipment_to_customer_sub_screen.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/active_shipmetn_widgets/shipment_to_merchant_sub_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../../../navigation_menu.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../controller/page_controller.dart';
import '../../../controller/update_status_controller.dart';
import 'contact_info_widget.dart';
import 'draggable_button.dart';

class ActiveShipmentsTab extends StatelessWidget {
  final int tabIndex;
  final String shipmentNumber;
  final String merchantName;
  final String merchantPhone;
  final String customerName;
  final String customerPhone;
  final double shipmentAmount;
  final double deliveryFee;
  final int initialStatus;
  final LatLng recipientLocation;

  ActiveShipmentsTab({
    required this.tabIndex,
    required this.shipmentNumber,
    required this.merchantName,
    required this.merchantPhone,
    required this.customerName,
    required this.customerPhone,
    required this.shipmentAmount,
    required this.deliveryFee,
    required this.initialStatus,
    required this.recipientLocation,
  });

  @override
  Widget build(BuildContext context) {
    final TPageController pageController =
    Get.put(TPageController(), tag: 'tab$tabIndex');
    final controller = Get.put(UpdateShipmentStatusController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (initialStatus) {
        case 1:
          pageController.changePage(0);
          break;
        case 2:
          pageController.changePage(1);
          break;
        case 3:
          pageController.changePage(2);
          break;
        case 4:
          pageController.changePage(3);
          break;
        case 5:
          pageController.changePage(4);
          break;
        case 6:
          showShipmentCustomerDialog(
            context,
            shipmentAmount + deliveryFee,
            tabIndex,
                () async {
              final success = await controller.updateShipmentStatus(
                  shipmentNumber: shipmentNumber, newStatus: 7);
              if (success) {
                Navigator.of(context).pop();
                Get.to(NavigationMenu());
                Get.snackbar(
                  'نجاح',
                  'لقد قمت بتسليم الشحنة بنجاح',
                  backgroundColor: TColors.primary,
                  colorText: TColors.white,
                  snackPosition: SnackPosition.TOP,
                  margin: EdgeInsets.all(10),
                  borderRadius: 10,
                  icon: Icon(Icons.check_circle_outline, color: TColors.white),
                  duration: Duration(seconds: 5),
                );
              }
            },
          );
          break;
        default:
          pageController.changePage(0);
      }
    });

    return Obx(() {
      return Stack(
        children: [
          IndexedStack(
            index: pageController.currentPage.value,
            children: [
              ShipmentToMerchantScreen(recipientLocation: recipientLocation),
              ShipmentToMerchantScreen(recipientLocation: recipientLocation),
              BarcodeScanScreen(onPressed: () {
                controller.updateShipmentStatus(
                    shipmentNumber: shipmentNumber, newStatus: 4).then((success) {
                  if (success) {
                    pageController.changePage(3);
                  }
                });
              }),
              ShipmentToCustomerScreen(recipientLocation: recipientLocation),
              ShipmentToCustomerScreen(recipientLocation: recipientLocation),
            ],
          ),
          if (pageController.currentPage.value != 2)
            ContactInfoWidget(
              name: pageController.currentPage.value < 3
                  ? merchantName
                  : customerName,
              phoneNumber: pageController.currentPage.value < 3
                  ? merchantPhone
                  : customerPhone,
            ),
          if (pageController.currentPage.value != 2)
            Padding(
              padding: EdgeInsets.only(top: 76.2.h),
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
                    controller.updateShipmentStatus(
                        shipmentNumber: shipmentNumber, newStatus: 2).then((success) {
                      if (success) {
                        pageController.changePage(1);
                      }
                    });
                  } else if (pageController.currentPage.value == 1) {
                    showShipmentMerchantDialog(
                      context,
                      shipmentAmount,
                      deliveryFee,
                      tabIndex,
                          () {
                        Navigator.of(context).pop();
                        controller.updateShipmentStatus(
                            shipmentNumber: shipmentNumber, newStatus: 3).then((success) {
                          if (success) {
                            pageController.changePage(2);
                          }
                        });
                      },
                    );
                  } else if (pageController.currentPage.value == 3) {
                    controller.updateShipmentStatus(
                        shipmentNumber: shipmentNumber, newStatus: 5).then((success) {
                      if (success) {
                        pageController.changePage(4);
                      }
                    });
                  } else {
                    controller.updateShipmentStatus(
                        shipmentNumber: shipmentNumber, newStatus: 6).then((success) {
                      if (success) {
                        showShipmentCustomerDialog(
                          context,
                          shipmentAmount + deliveryFee,
                          tabIndex,
                              () async {
                            final success = await controller.updateShipmentStatus(
                                shipmentNumber: shipmentNumber, newStatus: 7);
                            if (success) {
                              Navigator.of(context).pop();
                              Get.to(NavigationMenu());
                              Get.snackbar(
                                'نجاح',
                                'لقد قمت بتسليم الشحنة بنجاح',
                                backgroundColor: TColors.primary,
                                colorText: TColors.white,
                                snackPosition: SnackPosition.TOP,
                                margin: EdgeInsets.all(10),
                                borderRadius: 10,
                                icon: Icon(Icons.check_circle_outline, color: TColors.white),
                                duration: Duration(seconds: 5),
                              );
                            }
                          },
                        );
                      }
                    });
                  }
                },
              ),
            ),
        ],
      );
    });
  }
}
