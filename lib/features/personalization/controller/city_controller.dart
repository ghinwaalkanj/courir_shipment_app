import 'package:get/get.dart';
import '../../../core/integration/crud.dart';
import '../../../core/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/city_model.dart';

class DeliveryCitiesSettingsController extends GetxController {
  var isLoading = false.obs;
  var deliveryCities = <DeliveryCity>[].obs;
  final Crud crud = Get.find<Crud>();

  @override
  void onInit() {
    super.onInit();
    fetchDeliveryCities();
  }

  void fetchDeliveryCities() async {
    isLoading.value = true;
    int? userId = await SharedPreferencesHelper.getInt('user_id');
    var response = await crud.postData(
        'https://api.wasenahon.com/Kwickly/delivery/cities/get_delivery_cities.php',
        {
          'user_id': userId.toString(),
        },
        {});
    isLoading.value = false;

    response.fold(
      (failure) {
        // handle failure
      },
      (data) {
        var cityList = (data['data'] as List)
            .map((cityJson) => DeliveryCity.fromJson(cityJson))
            .toList();
        print(cityList);
        deliveryCities.assignAll(cityList);
      },
    );
  }
}
