import 'package:courir_shipment_app/utils/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/integration/crud.dart';
import '../../../core/services/storage_service.dart';
import '../../../utils/constants/colors.dart';
import '../model/switch_model.dart';

class HomeController extends GetxController {
  var isOnline = false.obs;
  var isLoading = false.obs;
  var cityNum = 0.obs;
  var center = Rxn<LatLng>();
  var radius = 0.0.obs;

  final Crud crud = Get.find<Crud>();

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchHomeData();
    print(center);
    print(isOnline);
    print(cityNum.value);
  }

  Future<void> fetchHomeData() async {
    isLoading.value = true;

    var deliveryId = await SharedPreferencesHelper.getInt('user_id');
    var response = await crud.postData(
      'https://api.wasenahon.com/Kwickly/delivery/get_home.php',
      {
        'delivery_id': deliveryId.toString(),
      },
      {},
    );

    isLoading.value = false;

    response.fold(
          (failure) {
        Get.snackbar(
          'خطأ',
          'فشل في جلب بيانات الصفحة الرئيسية',
          backgroundColor: TColors.error,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          icon: Icon(Icons.error_outline, color: Colors.white),
          duration: Duration(seconds: 5),
        );
      },
          (data) {
        isOnline.value = data['online'];
        cityNum.value = (data['cities'] as List).length;
        center.value = LatLng(data['center']['lat'], data['center']['lng']);
        print(cityNum.value);
        print(isOnline.value);
      },
    );
  }

  void toggleOnlineStatus(bool value) async {
    isOnline.value = value;
    isLoading.value = true;

    var deliveryId = await SharedPreferencesHelper.getInt('user_id');
    var status = value ? '1' : '0';

    var response = await crud.postData(
      UpdateStatusEndpoint,
      {
        'delivery_id': deliveryId.toString(),
        'status': status,
      },
      {},
    );

    isLoading.value = false;

    response.fold(
          (failure) {
        Get.snackbar(
          'خطأ',
          'فشل في تحديث حالة العمل',
          backgroundColor: TColors.error,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          icon: Icon(Icons.error_outline, color: Colors.white),
          duration: Duration(seconds: 5),
        );
      },
          (data) async {
        var responseModel = WorkStatusResponseModel.fromJson(data);
        print(responseModel.status);
        print(responseModel.message);
        if (responseModel.status) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isOnline', isOnline.value);
        } else {
          Get.snackbar(
            'خطأ',
            responseModel.message ?? 'خطأ غير معروف',
            backgroundColor: TColors.error,
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
  }
}
