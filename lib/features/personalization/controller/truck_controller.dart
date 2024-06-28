import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../core/integration/crud.dart';
import '../../../core/services/storage_service.dart';
import '../../../common/widgets/snack_bars/error_snack_bar.dart';
import '../../../common/widgets/snack_bars/success_snack_bar.dart';
import '../model/truck_model.dart';

class TruckController extends GetxController {
  var isLoading = false.obs;
  var vehicleTypeController = TextEditingController();
  var vehiclePlateController = TextEditingController();
  var vehicleModelController = TextEditingController();
  var vehicleColorController = TextEditingController();

  final Crud crud = Get.find<Crud>();

  void setVehicleInfo(String type, String plate, String model, String color) {
    vehicleTypeController.text = type;
    vehiclePlateController.text = plate;
    vehicleModelController.text = model;
    vehicleColorController.text = color;
  }

  Future<void> addVehicle(String newType,String newPlate ,String newModel,String newColor) async {
    isLoading.value = true;
    var userId = await SharedPreferencesHelper.getInt('user_id');
    var response = await crud.postData(
      'https://api.wasenahon.com/Kwickly/delivery/auth/add_vehicles.php',
      {
        'user_id': userId.toString(),
        'vehicle_type': newType,
        'vehicle_number': newPlate,
        'vehicle_model': newModel,
        'vehicle_color': newColor,
      },
      {},
    );

    isLoading.value = false;

    response.fold(
          (failure) {
        ErrorSnackbar.show('فشل في إضافة المركبة');
      },
          (data) {
        var truckResponse = TruckModel.fromJson(data);
        if (truckResponse.status) {
          SuccessSnackbar.show(truckResponse.message);
        } else {
          ErrorSnackbar.show(truckResponse.message);
        }
      },
    );
  }
}
