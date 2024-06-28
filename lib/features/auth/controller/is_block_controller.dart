import 'dart:async';
import 'package:courir_shipment_app/common/widgets/snack_bars/success_snack_bar.dart';
import 'package:get/get.dart';
import '../../../core/integration/crud.dart';
import '../../../core/services/storage_service.dart';
import '../../../common/widgets/snack_bars/error_snack_bar.dart';
import '../model/is_blocked_model.dart';

class BlockStatusController extends GetxController {
  var isLoading = false.obs;
  var isBlocked = false.obs;

  final Crud crud = Get.find<Crud>();

  @override
  void onInit() {
    super.onInit();
    checkBlockStatus();
    // // Check block status every minute
    // Timer.periodic(Duration(minutes: 1), (timer) => checkBlockStatus());
  }

  void checkBlockStatus() async {
    isLoading.value = true;
    var deliveryId = await SharedPreferencesHelper.getInt('user_id');
    var response = await crud.postData(
      'https://api.wasenahon.com/Kwickly/delivery/get_is_blocked.php',
      {
        'delivery_id': deliveryId.toString(),
      },
      {},
    );

    isLoading.value = false;

    response.fold(
          (failure) {
      },
          (data) {
        var blockStatus = BlockStatus.fromJson(data);
        isBlocked.value = blockStatus.isBlocked == 1;
        if (!isBlocked.value) {
          print("you're not Blocked");
        }
      },
    );
  }
}
