class HomeResponse {
  final bool? status;
  final int? online;
  final List<City>? cities;
  final CenterCoordinates? center;
  final int? radius;

  HomeResponse({
    required this.status,
    required this.online,
     this.cities,
     this.center,
    required this.radius,
  });

  factory HomeResponse.fromJson(Map<dynamic, dynamic> json) {
    return HomeResponse(
      status: json['status'],
      online: json['online'],
      cities: (json['cities'] as List).map((e) => City.fromJson(e)).toList(),
      center: CenterCoordinates.fromJson(json['center']),
      radius: json['radius'],
    );
  }
}

class City {
  final String cityName;

  City({required this.cityName});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      cityName: json['city_name'],
    );
  }
}

class CenterCoordinates {
  final double lat;
  final double lng;

  CenterCoordinates({required this.lat, required this.lng});

  factory CenterCoordinates.fromJson(Map<String, dynamic> json) {
    return CenterCoordinates(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
