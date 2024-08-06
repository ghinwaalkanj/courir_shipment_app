import 'package:courir_shipment_app/common/widgets/snack_bars/success_snack_bar.dart';
import 'package:courir_shipment_app/features/auth/screen/add_delivery_areas_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/integration/crud.dart';
import '../../../core/services/storage_service.dart';
import '../model/vehicle_info_model.dart';

class VehicleInfoController extends GetxController {
  var vehicleType = ''.obs;
  var vehiclePlate = ''.obs;
  var vehicleModel = ''.obs;
  var vehicleColor = ''.obs;
  var isLoading = false.obs;

  late TextEditingController vehicleTypeController;
  late TextEditingController vehiclePlateController;
  late TextEditingController vehicleModelController;
  late TextEditingController vehicleColorController;

  var vehicleTypeError = ''.obs;
  var vehiclePlateError = ''.obs;
  var vehicleModelError = ''.obs;
  var vehicleColorError = ''.obs;

  final Crud crud = Get.find<Crud>();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      vehicleType.value = Get.arguments['vehicle_type'] ?? '';
      vehiclePlate.value = Get.arguments['vehicle_plate_number'] ?? '';
      vehicleModel.value = Get.arguments['vehicle_model'] ?? '';
      vehicleColor.value = Get.arguments['vehicle_color'] ?? '';
    }

    vehicleTypeController = TextEditingController(text: vehicleType.value);
    vehiclePlateController = TextEditingController(text: vehiclePlate.value);
    vehicleModelController = TextEditingController(text: vehicleModel.value);
    vehicleColorController = TextEditingController(text: vehicleColor.value);
  }

  bool validateForm() {
    bool isValid = true;

    if (vehicleTypeController.text.isEmpty) {
      vehicleTypeError.value = 'يرجى إدخال نوع المركبة';
      isValid = false;
    } else {
      vehicleTypeError.value = '';
    }

    if (vehiclePlateController.text.isEmpty) {
      vehiclePlateError.value = 'يرجى إدخال لوحة المركبة';
      isValid = false;
    } else {
      vehiclePlateError.value = '';
    }

    if (vehicleModelController.text.isEmpty) {
      vehicleModelError.value = 'يرجى إدخال موديل المركبة';
      isValid = false;
    } else {
      vehicleModelError.value = '';
    }

    if (vehicleColorController.text.isEmpty) {
      vehicleColorError.value = 'يرجى إدخال لون المركبة';
      isValid = false;
    } else {
      vehicleColorError.value = '';
    }

    return isValid;
  }

  void clearError(String field) {
    switch (field) {
      case 'vehicleType':
        vehicleTypeError.value = '';
        break;
      case 'vehiclePlate':
        vehiclePlateError.value = '';
        break;
      case 'vehicleModel':
        vehicleModelError.value = '';
        break;
      case 'vehicleColor':
        vehicleColorError.value = '';
        break;
    }
  }

  void saveVehicleInfo() async {
    isLoading.value = true;

    var userId = await SharedPreferencesHelper.getInt('user_id');
    var response = await crud.postData(
      'https://darkred-wombat-762943.hostingersite.com/Kwickly/delivery/auth/add_vehicles.php',
      {
        'user_id': userId.toString(),
        'vehicle_type': vehicleTypeController.text,
        'vehicle_number': vehiclePlateController.text,
        'vehicle_model': vehicleModelController.text,
        'vehicle_color': vehicleColorController.text,
      },
      {},
    );

    isLoading.value = false;

    response.fold(
          (failure) {
        Get.snackbar(
          'خطأ',
          'فشل في إضافة المركبة',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          icon: Icon(Icons.error_outline, color: Colors.white),
          duration: Duration(seconds: 5),
        );
      },
          (data) async {
        var responseModel = VehicleResponseModel.fromJson(data);
        if (responseModel.status) {
          SuccessSnackbar.show(responseModel.message ?? 'تم تحديث معلومات المركبة بنجاح');
          Get.to(AddDeliveryAreasScreen(), arguments: {'cities': responseModel.cities});
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isVehicleInfo', true);

        } else {
          Get.snackbar(
            'خطأ',
            responseModel.message ?? 'خطأ غير معروف',
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
  }
}
