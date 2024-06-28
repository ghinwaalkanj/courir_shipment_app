import 'package:get/get.dart';
import '../../../core/integration/crud.dart';
import '../../../core/services/storage_service.dart';
import '../models/my_shipments_model.dart';

class MyShipmentsController extends GetxController {
  var isLoading = false.obs;
  var shipments = <Shipment>[].obs;
  final Crud crud = Get.find<Crud>();

  @override
  void onInit() {
    super.onInit();
    fetchMyShipments();
  }

  fetchMyShipments() async {
    isLoading.value = true;
    int? deliveryId = await SharedPreferencesHelper.getInt('user_id');
    print("Fetching shipments for delivery_id: $deliveryId");

    var response = await crud.postData(
        'https://api.wasenahon.com/Kwickly/delivery/shipments/get_my_shipments.php',
        {
          'delivery_id': deliveryId.toString(),
        }, {}
    );
    isLoading.value = false;

    response.fold(
          (failure) {
        // handle failure
        print("Failed to fetch shipments: $failure");
      },
          (data) {
        print("Response status: ${data['status']}");

        if (data['status'] == true && data['data'] != null) {
          var shipmentList = (data['data'] as List)
              .map((shipmentJson) => Shipment.fromJson(shipmentJson))
              .toList();
          shipments.assignAll(shipmentList);
        } else {
          print("No shipments found or status is false");
          shipments.clear();
        }
      },
    );
  }

  List<Shipment> getActiveShipments() {
    return shipments.where((shipment) =>
    shipment.shipmentInfo.shipmentStatus != 7 &&
        shipment.shipmentInfo.shipmentStatus != 9
    ).toList();
  }

  int getActiveShipmentsCount() {
    return getActiveShipments().length;
  }

  List<Shipment> filterShipments(int status) {
    switch (status) {
      case 1:
        return shipments.where((shipment) => shipment.shipmentInfo.shipmentStatus == 1||shipment.shipmentInfo.shipmentStatus == 2||shipment.shipmentInfo.shipmentStatus == 3||shipment.shipmentInfo.shipmentStatus == 4||shipment.shipmentInfo.shipmentStatus == 5||shipment.shipmentInfo.shipmentStatus == 6).toList();
      case 2:
        return shipments.where((shipment) => shipment.shipmentInfo.shipmentStatus == 7).toList();
      case 3:
        return shipments.where((shipment) => shipment.shipmentInfo.shipmentStatus == 8 || shipment.shipmentInfo.shipmentStatus == 9).toList();
      default:
        return [];
    }
  }
}
