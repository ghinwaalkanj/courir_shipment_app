import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/contact_info_model.dart';

class ContactInfoController extends GetxController {
  var isLoading = false.obs;
  var contactInfoList = <ContactInfo>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchContactInfo();
  }

  Future<void> fetchContactInfo() async {
    isLoading.value = true;
    final response = await http.get(
      Uri.parse('https://api.wasenahon.com/Kwickly/admin/contact_info/get_contact_info.php'),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['status']) {
        var contactInfoJson = data['data'] as List;
        contactInfoList.value = contactInfoJson.map((e) => ContactInfo.fromJson(e)).toList();
      }
    } else {
      // Handle error
    }
    isLoading.value = false;
  }
}
