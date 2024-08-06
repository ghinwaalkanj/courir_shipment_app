import 'package:courir_shipment_app/common/widgets/snack_bars/success_snack_bar.dart';
import 'package:courir_shipment_app/features/Qr_code/screen/Qr_code_display_screen.dart';
import 'package:courir_shipment_app/features/Qr_code/screen/Qr_code_scan.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/active_shipmetn_widgets/rating_dialog.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/active_shipmetn_widgets/rating_return_dialog.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/active_shipmetn_widgets/return_to_merchant_dialog.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/active_shipmetn_widgets/shipment_customer_dialog.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/active_shipmetn_widgets/shipment_merchant_dialog.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/active_shipmetn_widgets/shipment_to_customer_sub_screen.dart';
import 'package:courir_shipment_app/features/shipments/screens/widgets/active_shipmetn_widgets/shipment_to_merchant_sub_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/services/storage_service.dart';
import '../../../../../navigation_menu.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../personalization/controller/rating_controller.dart';
import '../../../controller/my_shipments_controller.dart';
import '../../../controller/page_controller.dart';
import '../../../controller/update_status_controller.dart';
import 'contact_info_widget.dart';
import 'draggable_button.dart';

class ActiveShipmentsTab extends StatelessWidget {
  final int tabIndex;
  final int id;
  final int shipmentId;
  final String shipmentNumber;
  final String merchantName;
  final String merchantPhone;
  final String customerName;
  final String customerPhone;
  final double shipmentAmount;
  final double deliveryFee;
  final int initialStatus;
  final LatLng recipientLocation;
  final LatLng merchentLocation;

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
    required this.merchentLocation,
    required this.shipmentId,
    required this.id,
  });

  void _showRatingDialog(BuildContext context, int shipmentId, int raterId,
      int rateeId) {
    final RatingController ratingController = Get.put(RatingController());

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return RatingDialog(
          onSubmit: (rating, comment) async {
            final response = await ratingController.submitRating(
              shipmentId: shipmentId,
              raterId: raterId,
              rateeId: rateeId,
              rating: rating,
              comment: comment,
            );

            if (response != null && response.status) {
              SuccessSnackbar.show('لقد قمت بتقديم التقييم بنجاح');
            } else {
              Get.snackbar(
                'خطأ',
                'فشل في تقديم التقييم',
                backgroundColor: Colors.red,
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
                margin: EdgeInsets.all(10),
                borderRadius: 10,
                icon: Icon(Icons.error_outline, color: Colors.white),
                duration: Duration(seconds: 5),
              );
            }
          },
        );
      },
    );
  }

  void _showRatingReturnDialog(BuildContext context, int shipmentId,
      int raterId, int rateeId) {
    Get.lazyPut(() => RatingController());

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return RatingReturnDialog(
          onSubmit: (rating, comment) async {
            final ratingController = Get.find<RatingController>();
            final response = await ratingController.submitRating(
              shipmentId: shipmentId,
              raterId: raterId,
              rateeId: rateeId,
              rating: rating,
              comment: comment,
            );

            if (response != null && response.status) {
              SuccessSnackbar.show('لقد قمت بتقديم التقييم بنجاح');
            } else {
              Get.snackbar(
                'خطأ',
                'فشل في تقديم التقييم',
                backgroundColor: Colors.red,
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
                margin: EdgeInsets.all(10),
                borderRadius: 10,
                icon: Icon(Icons.error_outline, color: Colors.white),
                duration: Duration(seconds: 5),
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final TPageController pageController =
    Get.put(TPageController(), tag: 'tab$tabIndex');
    final controller = Get.put(UpdateShipmentStatusController());
    final MyShipmentsController myShipmentsController =
    Get.put(MyShipmentsController());

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
          pageController.changePage(4);
          showShipmentCustomerDialog(
              context, shipmentAmount + deliveryFee, tabIndex, () async {
            final success = await controller.updateShipmentStatus(
                shipmentNumber: shipmentNumber, newStatus: 7);
            if (success) {
              var rater = await SharedPreferencesHelper.getInt('user_id');
              await myShipmentsController.fetchMyShipments();

              Get.to(NavigationMenu());

              SuccessSnackbar.show('لقد قمت بتسليم الشحنة بنجاح');
              print(shipmentId);
              print(rater);
              print(id);
              _showRatingReturnDialog(context, shipmentId, rater!, id);
            }
          }, () {

            Navigator.of(context).pop();
          });
          break;
        case 8:
          pageController.changePage(5);
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
              ShipmentToMerchantScreen(
                recipientLocation: recipientLocation, deliveryLocation:merchentLocation,),
              ShipmentToMerchantScreen(
                recipientLocation: recipientLocation, deliveryLocation:merchentLocation,),
              BarcodeScanScreen(
                onBarcodeScanned: (barcode) {
                  if (barcode == shipmentNumber) {
                    controller
                        .updateShipmentStatus(
                        shipmentNumber: barcode, newStatus: 4)
                        .then((success) {
                      if (success) {
                        pageController.changePage(3);
                      }
                    });
                  } else {
                    // Get.snackbar(
                    //   'خطأ',
                    //   'رقم الشحنة غير صحيح',
                    //   backgroundColor: Colors.red,
                    //   colorText: Colors.white,
                    //   snackPosition: SnackPosition.TOP,
                    //   margin: EdgeInsets.all(10),
                    //   borderRadius: 10,
                    //   icon: Icon(Icons.error_outline, color: Colors.white),
                    //   duration: Duration(seconds: 5),
                    // );
                  }
                },
              ),
              ShipmentToCustomerScreen(
                recipientLocation: recipientLocation, deliveryLocation:merchentLocation,),
              ShipmentToCustomerScreen(
                recipientLocation: recipientLocation, deliveryLocation:merchentLocation,),
              QrCodeDisplayScreen(
                shipmentNumber: shipmentNumber,
                onPressed: () async {
                  await controller.updateShipmentStatus(
                      shipmentNumber: shipmentNumber, newStatus: 9);

                  var rater = await SharedPreferencesHelper.getInt('user_id');
                  Get.to(NavigationMenu());
                  SuccessSnackbar.show('تم إرجاع الشحنة بنجاح');
                  // _showRatingDialog(context, shipmentId, rater!, id);
                },
              ),

            ],
          ),
          if (pageController.currentPage.value != 2 &&
              pageController.currentPage.value != 5)
            ContactInfoWidget(
              name: pageController.currentPage.value < 3
                  ? merchantName
                  : customerName,
              phoneNumber: pageController.currentPage.value < 3
                  ? merchantPhone
                  : customerPhone,
            ),
          if (pageController.currentPage.value != 2 &&
              pageController.currentPage.value != 5)
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
                    controller
                        .updateShipmentStatus(
                        shipmentNumber: shipmentNumber, newStatus: 2)
                        .then((success) {
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
                        controller
                            .updateShipmentStatus(
                            shipmentNumber: shipmentNumber, newStatus: 3)
                            .then((success) {
                          if (success) {
                            pageController.changePage(2);
                          }
                        });
                      },
                    );
                  } else if (pageController.currentPage.value == 2) {
                    controller
                        .updateShipmentStatus(
                        shipmentNumber: shipmentNumber, newStatus: 5)
                        .then((success) {
                      if (success) {
                        pageController.changePage(3);
                      }
                    });
                  } else if (pageController.currentPage.value == 3) {
                    controller
                        .updateShipmentStatus(
                        shipmentNumber: shipmentNumber, newStatus: 5)
                        .then((success) {
                      if (success) {
                        pageController.changePage(4);
                      }
                    });
                  } else {
                    controller
                        .updateShipmentStatus(
                        shipmentNumber: shipmentNumber, newStatus: 6)
                        .then((success) {
                      if (success) {
                        showShipmentCustomerDialog(
                            context, shipmentAmount + deliveryFee, tabIndex,
                                () async {
                              var rater =
                              await SharedPreferencesHelper.getInt('user_id');
                              final success = await controller
                                  .updateShipmentStatus(
                                  shipmentNumber: shipmentNumber, newStatus: 7);
                              if (success) {
                                Navigator.of(context).pop();
                                Get.to(NavigationMenu());
                                _showRatingDialog(
                                    context, shipmentId, rater!, id);
                                SuccessSnackbar.show(
                                    'لقد قمت بتسليم الشحنة بنجاح');
                              }
                            }, () async {
                          final success = await controller.updateShipmentStatus(
                              shipmentNumber: shipmentNumber, newStatus: 8);
                          if (success) {
                            Navigator.of(context).pop();
                            Get.to(
                              QrCodeDisplayScreen(
                                shipmentNumber: shipmentNumber,
                                onPressed: () async {
                                  await controller.updateShipmentStatus(
                                      shipmentNumber: shipmentNumber, newStatus: 9);
                                  var rater =
                                  await SharedPreferencesHelper.getInt(
                                      'user_id');
                                  Get.to(NavigationMenu());
                                  SuccessSnackbar.show('تم إرجاع الشحنة بنجاح');
                                  // _showRatingDialog(
                                  //     context, shipmentId, rater!, id);
                                },
                              ),
                            );
                          }
                        });
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
