import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../../../core/integration/crud.dart';
import '../../../core/services/storage_service.dart';
import '../models/daily_income_model.dart';

class DailyIncomeController extends GetxController {
  var isLoading = false.obs;
  var dailyIncomeResponse = DailyIncomeResponse(
    status: false,
    date: '',
    totalIncome: 0,
    shipments: [],
  ).obs;

  final Crud crud = Get.find<Crud>();

  @override
  void onInit() {
    super.onInit();
    fetchDailyIncome();
  }

  Future<void> fetchDailyIncome() async {
    isLoading.value = true;
    var deliveryId = await SharedPreferencesHelper.getInt('user_id');
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    var response = await crud.postData(
      'https://api.wasenahon.com/Kwickly/delivery/daily_income.php',
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
          'فشل في جلب البيانات اليومية',
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
        dailyIncomeResponse.value = DailyIncomeResponse.fromJson(data);
      },
    );
  }
}
