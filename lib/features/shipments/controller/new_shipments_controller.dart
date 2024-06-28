import 'package:get/get.dart';
import '../../../core/integration/crud.dart';
import '../../../core/services/storage_service.dart';
import '../models/new_shipment_model.dart';

class NewShipmentsController extends GetxController {
  var isLoading = false.obs;
  var shipments = <Shipment>[].obs;
  final Crud crud = Get.find<Crud>();

  @override
  void onInit() {
    super.onInit();
    fetchNewShipments();
  }

   fetchNewShipments() async {
    isLoading.value = true;
    int? deliveryId = await SharedPreferencesHelper.getInt('user_id');
    print("Fetching shipments for delivery_id: $deliveryId");

    var response = await crud.postData(
      'https://api.wasenahon.com/Kwickly/delivery/shipments/get_new_shipments.php',
      {
        'delivery_id': deliveryId.toString(),
      },
      {},
    );
    isLoading.value = false;

    response.fold(
          (failure) {},
          (data) {
        if (data != null && data['data'] != null) {
          var shipmentList = (data['data'] as List)
              .map((shipmentJson) => Shipment.fromJson(shipmentJson))
              .toList();
          shipments.assignAll(shipmentList);
        } else {
          print('No shipments found or data is null');
          shipments.clear();
        }
      },
    );
  }
}
