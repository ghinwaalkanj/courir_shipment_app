import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/integration/crud.dart';
import '../../../core/services/storage_service.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/colors.dart';
import '../model/personal_info_model.dart';
import '../screen/id_upload_screen.dart';

class PersonalInfoController extends GetxController {
  var fullName = ''.obs;
  var phoneNumber = ''.obs;
  var nationalId = ''.obs;
  var businessName = ''.obs;
  var gender = ''.obs;
  var isFormValid = false.obs;
  var isLoading = false.obs;

  late TextEditingController fullNameController;
  late TextEditingController idController;
  late TextEditingController shopController;
  late TextEditingController genderController;

  final Crud crud = Get.find<Crud>();

  @override
  void onInit() {
    print(Get.arguments);
    super.onInit();
    if (Get.arguments != null) {
      fullName.value = Get.arguments['name'] ?? '';
      nationalId.value = Get.arguments['national_id'] ?? '';
      businessName.value = Get.arguments['business_name'] ?? '';
      gender.value = Get.arguments['gender'] ?? '';
      validateForm();
    }

    fullNameController = TextEditingController(text: fullName.value);
    idController = TextEditingController(text: nationalId.value);
    shopController = TextEditingController(text: businessName.value);
    genderController = TextEditingController(text: gender.value);
  }

  void validateForm() {
    if (fullName.value.isNotEmpty &&
        nationalId.value.isNotEmpty &&
        businessName.value.isNotEmpty &&
        gender.value.isNotEmpty &&
        nationalId.value.length == 10) {
      isFormValid.value = true;
    } else {
      isFormValid.value = false;
    }
  }

  void submitPersonalInfo() async {
    if (fullName.value.isEmpty ||
        nationalId.value.isEmpty ||
        gender.value.isEmpty ||
        nationalId.value.length != 10) {
      Get.snackbar(
        'خطأ',
        'يرجى تعبئة جميع المعلومات وتأكد من أن الرقم الوطني يحتوي على 10 أرقام',
        backgroundColor: TColors.error,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(10),
        borderRadius: 10,
        icon: Icon(Icons.error_outline, color: Colors.white),
        duration: Duration(seconds: 5),
      );
      return;
    }

    isLoading.value = true;
    var token = await SharedPreferencesHelper.getString('token');
    var userId = await SharedPreferencesHelper.getInt('user_id');
    print("personl$token");
    print(userId);
    var response = await crud.postData(
      PersonalInfoEndpoint,
      {
        'user_id': userId.toString(),
        'name': fullName.value,
        'national_id': nationalId.value,
        'gender': gender.value,
      },
      {},
    );
    isLoading.value = false;

    response.fold(
          (failure) {
        Get.snackbar(
          'خطأ',
          'فشل في تحديث الملف الشخصي',
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
        try {
          PersonalInfoResponseModel responseModel =
          PersonalInfoResponseModel.fromJson(data);
          if (responseModel.status) {
            print(responseModel.status);
            print(responseModel.message);
            Get.to(() => IDUploadScreen(), arguments: {
              'id_front_image': responseModel.idFrontImage,
              'id_back_image': responseModel.idBackImage,
            });
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
        } catch (e) {
          Get.snackbar(
            'خطأ',
            'خطأ في معالجة الاستجابة',
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
