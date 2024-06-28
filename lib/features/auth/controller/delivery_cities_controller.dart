import 'package:courir_shipment_app/common/widgets/snack_bars/error_snack_bar.dart';
import 'package:courir_shipment_app/common/widgets/snack_bars/success_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../core/integration/crud.dart';
import '../../../core/services/storage_service.dart';
import '../../../navigation_menu.dart';
import '../../../utils/constants/colors.dart';
import '../../personalization/model/city_model.dart';
import '../model/cities_model.dart';

class DeliveryCitiesController extends GetxController {
  var isLoading = false.obs;
  var selectedGovernorates = <String>[].obs;
  var cities = <City>[].obs;
  var deliveryCities = <DeliveryCity>[].obs;

  final Crud crud = Get.find<Crud>();

  @override
  void onInit() {
    super.onInit();
    fetchCities();
    fetchDeliveryCities();
  }

  void toggleSelection(String city) {
    if (selectedGovernorates.contains(city)) {
      selectedGovernorates.remove(city);
    } else {
      selectedGovernorates.add(city);
    }
  }

  void validateForm() {
    if (selectedGovernorates.isEmpty) {
      ErrorSnackbar.show('يرجى اختيار منطقة واحدة على الأقل');
    } else {
      addDeliveryCities();
    }
  }

  void fetchCities() async {
    isLoading.value = true;
    var response = await crud.getData('https://api.wasenahon.com/Kwickly/delivery/auth/get_cities.php', {});
    isLoading.value = false;

    response.fold(
          (failure) {
        // handle failure
      },
          (data) {
        var cityList = (data['data'] as List)
            .map((cityJson) => City.fromJson(cityJson))
            .toList();
        cities.assignAll(cityList);
        updateSelectedGovernorates();
      },
    );
  }

  Future<Map<String, dynamic>> postDataList(String url, Map<String, dynamic> data) async {
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void addDeliveryCities() async {
    isLoading.value = true;
    var userId = await SharedPreferencesHelper.getInt('user_id');
    var cityIds = selectedGovernorates.map((cityName) {
      return cities.firstWhere((city) => city.name == cityName).id.toString();
    }).toList();

    var requestBody = {
      'user_id': userId,
      'city_ids': cityIds,
    };
    print("$requestBody");

    try {
      var response = await postDataList(
        'https://api.wasenahon.com/Kwickly/delivery/auth/add_delivery_cities.php',
        requestBody,
      );
      var responseModel = AddDeliveryCitiesResponse.fromJson(response);
      SuccessSnackbar.show('تم إضافة المناطق بنجاح');
      if (responseModel.status) {
        Get.offAll(NavigationMenu());
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
      print("$requestBody");
      print(userId);
      print(cityIds);
      print(e.toString());
      Get.snackbar(
        'خطأ',
        e.toString(),
        backgroundColor: TColors.error,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(10),
        borderRadius: 10,
        icon: Icon(Icons.error_outline, color: Colors.white),
        duration: Duration(seconds: 5),
      );
    } finally {
      isLoading.value = false;
    }
  }
  void setSelectedCities(List<City> selectedCities) {
    for (var city in selectedCities) {
      if (!selectedGovernorates.contains(city.name)) {
        selectedGovernorates.add(city.name);
      }
    }
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
        updateSelectedGovernorates();
      },
    );
  }

  void updateSelectedGovernorates() {
    selectedGovernorates.clear();
    for (var deliveryCity in deliveryCities) {
      selectedGovernorates.add(deliveryCity.cityName);
    }
  }
}

class DeliveryCity {
  final int id;
  final int userId;
  final int cityId;
  final String cityName;
  final String createdAt;
  final String updatedAt;

  DeliveryCity({
    required this.id,
    required this.userId,
    required this.cityId,
    required this.cityName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DeliveryCity.fromJson(Map<String, dynamic> json) {
    return DeliveryCity(
      id: json['id'],
      userId: json['user_id'],
      cityId: json['city_id'],
      cityName: json['city_name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
