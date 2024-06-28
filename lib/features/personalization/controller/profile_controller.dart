import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../core/integration/crud.dart';
import '../../../core/services/storage_service.dart';
import '../../../common/widgets/snack_bars/error_snack_bar.dart';
import '../../../common/widgets/snack_bars/success_snack_bar.dart';
import '../model/profile_model.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var name = ''.obs;
  var phone = ''.obs;
  var gender = ''.obs;
  var totalShipments = 0.obs;

  var vehicleType = ''.obs;
  var vehiclePlate = ''.obs;
  var vehicleModel = ''.obs;
  var vehicleColor = ''.obs;

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController businessNameController;
  late TextEditingController vehicleTypeController;
  late TextEditingController vehiclePlateController;
  late TextEditingController vehicleModelController;
  late TextEditingController vehicleColorController;

  final Crud crud = Get.find<Crud>();

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    businessNameController = TextEditingController();
    vehicleTypeController = TextEditingController();
    vehiclePlateController = TextEditingController();
    vehicleModelController = TextEditingController();
    vehicleColorController = TextEditingController();
    fetchProfile();
  }

  void fetchProfile() async {
    isLoading.value = true;
    var deliveryId = await SharedPreferencesHelper.getInt('user_id');
    var response = await crud.postData(
      'https://api.wasenahon.com/Kwickly/delivery/get_delivery_profile.php',
      {
        'delivery_id': deliveryId.toString(),
      },
      {},
    );

    isLoading.value = false;

    response.fold(
          (failure) {
        ErrorSnackbar.show('فشل في جلب البيانات');
      },
          (data) {
        var userProfile = UserProfile.fromJson(data['user']);
        var vehicle = Vehicle.fromJson(data['user']['vehicles'][0]);

        name.value = userProfile.name;
        phone.value = userProfile.phone;
        gender.value = userProfile.gender;
        totalShipments.value = userProfile.completedShipments;

        nameController.text = userProfile.name;
        phoneController.text = userProfile.phone;

        vehicleType.value = vehicle.vehicleType;
        vehiclePlate.value = vehicle.vehiclePlateNumber;
        vehicleModel.value = vehicle.vehicleModel;
        vehicleColor.value = vehicle.vehicleColor;

        vehicleTypeController.text = vehicle.vehicleType;
        vehiclePlateController.text = vehicle.vehiclePlateNumber;
        vehicleModelController.text = vehicle.vehicleModel;
        vehicleColorController.text = vehicle.vehicleColor;
      },
    );
  }

  void saveProfile() async {
    isLoading.value = true;
    var deliveryId = await SharedPreferencesHelper.getInt('user_id');
    var response = await crud.postData(
      'https://api.wasenahon.com/Kwickly/delivery/update_delivery_profile.php',
      {
        'delivery_id': deliveryId.toString(),
        'name': nameController.text,
        'phone': phoneController.text,
        'business_name': businessNameController.text,
      },
      {},
    );

    isLoading.value = false;

    response.fold(
          (failure) {
        ErrorSnackbar.show('فشل في تحديث البيانات');
      },
          (data) {
        SuccessSnackbar.show('تم تحديث البيانات بنجاح');
        fetchProfile();
      },
    );
  }

  void editProfile(String newName, String newPhone, String newGender) async {
    isLoading.value = true;
    var deliveryId = await SharedPreferencesHelper.getInt('user_id');
    var response = await crud.postData(
      'https://api.wasenahon.com/Kwickly/delivery/edit_delivery_profile.php',
      {
        'delivery_id': deliveryId.toString(),
        'name': newName,
        'phone': newPhone,
        'gender': newGender,
      },
      {},
    );

    isLoading.value = false;

    response.fold(
          (failure) {
        ErrorSnackbar.show('فشل في تحديث البروفايل');
      },
          (data) {
        if (data['status']) {
          SuccessSnackbar.show(data['message'] ?? 'تم تحديث البروفايل بنجاح');
          fetchProfile();
        } else {
          ErrorSnackbar.show(data['message'] ?? 'حدث خطأ ما');
        }
      },
    );
  }
}
