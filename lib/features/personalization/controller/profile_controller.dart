import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/integration/crud.dart';
import '../../../core/services/storage_service.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/colors.dart';

class ProfileController extends GetxController {
  // var profile = MerchantInfo.empty().obs;
  var isLoading = false.obs;
  var totalShipments = 0.obs;
  var merchant_rank = 0.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();

  final Crud crud = Get.find<Crud>();

  @override
  void onInit() {
    super.onInit();
    // fetchProfile();
  }
  //
  // void fetchProfile() async {
  //   isLoading.value = true;
  //   var userId = await SharedPreferencesHelper.getInt('user_id');
  //   var response = await crud.postData(
  //     ProfileEndpoint,
  //     {'user_id': userId.toString()},
  //     {},
  //   );
  //   isLoading.value = false;
  //
  //   response.fold(
  //     (failure) {
  //     },
  //     (data) {
  //       ProfileResponseModel responseModel =
  //           ProfileResponseModel.fromJson(data);
  //       profile.value = responseModel.merchantInfo;
  //       totalShipments.value = responseModel.totalShipments;
  //       merchant_rank.value = responseModel.merchantRank;
  //       nameController.text = profile.value.name;
  //       phoneController.text = profile.value.phone;
  //       businessNameController.text = profile.value.businessName;
  //     },
  //   );
  // }
  //
  // void editProfile(String name, String phone, String businessName) async {
  //   isLoading.value = true;
  //   var userId = await SharedPreferencesHelper.getInt('user_id');
  //   var response = await crud.postData(
  //     EditProfileEndpoint,
  //     {
  //       'user_id': userId.toString(),
  //       'name': nameController.text,
  //       'phone': phoneController.text,
  //       'business_name': businessNameController.text,
  //     },
  //     {},
  //   );
  //   isLoading.value = false;
  //
  //   response.fold(
  //     (failure) {
  //       Get.snackbar('Error', 'Failed to update profile');
  //       print(profile.value.name);
  //       print(profile.value.name);
  //     },
  //     (data) {
  //       EditProfileResponseModel responseModel =
  //           EditProfileResponseModel.fromJson(data);
  //       if (responseModel.status) {
  //         Get.snackbar(
  //           'نجاح',
  //           'تم تحديث الملف الشخصي بنجاح',
  //           backgroundColor: TColors.primary,
  //           colorText: Colors.white,
  //           snackPosition: SnackPosition.TOP,
  //           margin: EdgeInsets.all(10),
  //           borderRadius: 10,
  //           icon: Icon(Icons.check_circle_outline, color: Colors.white),
  //           duration: Duration(seconds: 5),
  //         );
  //         fetchProfile();
  //       } else {
  //         Get.snackbar('Error', responseModel.message);
  //       }
  //     },
  //   );
  // }
}
