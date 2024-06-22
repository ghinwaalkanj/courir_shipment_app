import 'package:get/get.dart';

class DeliveryCitiesController extends GetxController {
  var selectedGovernorate = ''.obs;
  var isLoading = false.obs;

  void validateForm() {
    if (selectedGovernorate.value.isEmpty) {
      // هنا يمكنك إضافة منطق التحقق الإضافي إذا لزم الأمر
      isLoading.value = true;
      // تنفيذ منطق التحميل هنا
      Future.delayed(Duration(seconds: 2), () {
        isLoading.value = false;
        // تنفيذ ما بعد التحميل
      });
    }
  }
}
