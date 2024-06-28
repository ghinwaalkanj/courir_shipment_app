class TruckModel {
  final bool status;
  final String message;
  final List<City> cities;

  TruckModel({
    required this.status,
    required this.message,
    required this.cities,
  });

  factory TruckModel.fromJson(Map<dynamic, dynamic> json) {
    return TruckModel(
      status: json['status'],
      message: json['message'],
      cities: (json['cities'] as List).map((i) => City.fromJson(i)).toList(),
    );
  }
}

class City {
  final int id;
  final String name;

  City({
    required this.id,
    required this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
    );
  }
}
