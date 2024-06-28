import 'cities_model.dart';

class VehicleResponseModel {
  final bool status;
  final String message;
  final List<City> cities;

  VehicleResponseModel({
    required this.status,
    required this.message,
    required this.cities,
  });

  factory VehicleResponseModel.fromJson(Map<dynamic, dynamic> json) {
    var citiesList = (json['cities'] as List).map((i) => City.fromJson(i)).toList();
    return VehicleResponseModel(
      status: json['status'],
      message: json['message'],
      cities: citiesList,
    );
  }
}
