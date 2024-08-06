import 'dart:convert';
import 'package:courir_shipment_app/features/shipments/screens/active_shipments_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import '../../../core/services/storage_service.dart';
import '../../../utils/constants/colors.dart';
import '../models/update_status_model.dart';
import '../screens/widgets/active_shipmetn_widgets/shipment_to_merchant_sub_screen.dart';

class UpdateShipmentStatusController extends GetxController {
  var isLoading = false.obs;
  var shipmentDetails = Rxn<ShipmentDetails>();

  Future<bool> updateShipmentStatus({
    required String shipmentNumber,
    required int newStatus,
  }) async {
    isLoading.value = true;

    var url = 'https://darkred-wombat-762943.hostingersite.com/Kwickly/delivery/shipments/update_shipment_status.php';
    int? deliveryId = await SharedPreferencesHelper.getInt('user_id');

    var body = {
      'delivery_id': deliveryId.toString(),
      'shipment_number': shipmentNumber,
      'new_status': newStatus.toString(),
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var updateResponse = UpdateShipmentStatusResponse.fromJson(jsonResponse);

        if (updateResponse.status) {
          shipmentDetails.value = updateResponse.shipmentDetails;
          Get.snackbar(
            'نجاح',
            updateResponse.message,
            backgroundColor: TColors.primary,
            colorText: TColors.white,
            snackPosition: SnackPosition.TOP,
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            icon: Icon(Icons.error_outline, color: TColors.white),
            titleText: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'نجاح',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: TColors.white,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
            messageText: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                updateResponse.message,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: TColors.white,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          );

          return true;
        } else {
          Get.snackbar(
            'خطأ',
            updateResponse.message,
            backgroundColor: TColors.error,
            colorText: TColors.white,
            snackPosition: SnackPosition.TOP,
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            icon: Icon(Icons.error_outline, color: TColors.white),
            titleText: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'خطأ',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: TColors.white,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
            messageText: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                updateResponse.message,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: TColors.white,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          );
          return false;
        }
      } else {
        Get.snackbar('Error', 'Failed to update shipment status',
            backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> checkShipmentReturnStatus(String shipmentNumber) async {
    isLoading.value = true;
    var url = 'https://darkred-wombat-762943.hostingersite.com/Kwickly/delivery/shipments/is_returned.php';

    var body = {
      'shipment_number': shipmentNumber,
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse['status'] as bool;
      } else {
        Get.snackbar('Error', 'Failed to check shipment return status',
            backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void _navigateBasedOnStatus(int status) {
    switch (status) {
      case 1:
        Get.to(ActiveShipmentsScreen());
        break;
      case 2:
      // Get.to(SecondScreen());
        break;
      default:
      // Get.to(DefaultScreen());
    }
  }
}
