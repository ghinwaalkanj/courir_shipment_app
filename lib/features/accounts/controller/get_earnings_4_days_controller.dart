import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/integration/crud.dart';
import '../../../core/services/storage_service.dart';
import '../models/get_earnings_4_days_model.dart';

class Earnings4DaysController extends GetxController {
  var isLoading = false.obs;
  var earnings4DaysResponse = Earnings4DaysResponse(
    status: false,
    data: [],
    totalCourierIncome: 0,
    totalAdminIncome: 0,
    maxEarningsLimit: '',
  ).obs;

  final Crud crud = Get.find<Crud>();

  @override
  void onInit() {
    super.onInit();
    fetchEarnings4Days();
  }

  Future<void> fetchEarnings4Days() async {
    isLoading.value = true;
    var deliveryId = await SharedPreferencesHelper.getInt('user_id');
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    var response = await crud.postData(
      'https://api.wasenahon.com/Kwickly/delivery/get_earnings_4_days.php',
      {
        'delivery_id': deliveryId.toString(),
        'date': currentDate,
      },
      {},
    );

    isLoading.value = false;

    response.fold(
          (failure) {
        Get.snackbar(
          'خطأ',
          'فشل في جلب البيانات للأيام الأربعة',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          icon: Icon(Icons.error_outline, color: Colors.white),
          duration: Duration(seconds: 5),
        );
      },
          (data) {
        earnings4DaysResponse.value = Earnings4DaysResponse.fromJson(data);
      },
    );
  }
}
