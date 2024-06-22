import 'package:courir_shipment_app/features/auth/screen/dellivery_cities_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehicleInfoController extends GetxController {
  var isLoading = false.obs;
  var vehicleTypeController = TextEditingController();
  var vehiclePlateController = TextEditingController();
  var vehicleModelController = TextEditingController();
  var vehicleColorController = TextEditingController();

  var vehicleTypeError = ''.obs;
  var vehiclePlateError = ''.obs;
  var vehicleModelError = ''.obs;
  var vehicleColorError = ''.obs;

  void validateForm() {
    vehicleTypeError.value = '';
    vehiclePlateError.value = '';
    vehicleModelError.value = '';
    vehicleColorError.value = '';

    if (vehicleTypeController.text.isEmpty) {
      vehicleTypeError.value = 'هذا الحقل مطلوب';
    }
    if (vehiclePlateController.text.isEmpty) {
      vehiclePlateError.value = 'هذا الحقل مطلوب';
    }
    if (vehicleModelController.text.isEmpty) {
      vehicleModelError.value = 'هذا الحقل مطلوب';
    }
    if (vehicleColorController.text.isEmpty) {
      vehicleColorError.value = 'هذا الحقل مطلوب';
    }

    if (vehicleTypeError.value.isEmpty && vehiclePlateError.value.isEmpty &&
        vehicleModelError.value.isEmpty && vehicleColorError.value.isEmpty) {
      isLoading.value = true;
      Future.delayed(Duration(seconds: 2), () {
        isLoading.value = false;
        Get.to(DelieveryCitiesScreen());
      });
    }
  }
}
