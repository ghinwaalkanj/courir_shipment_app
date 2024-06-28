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

class Vehicle {
  final int id;
  final int userId;
  final String vehicleType;
  final String vehiclePlateNumber;
  final String vehicleModel;
  final String vehicleColor;
  final String createdAt;
  final String updatedAt;

  Vehicle({
    required this.id,
    required this.userId,
    required this.vehicleType,
    required this.vehiclePlateNumber,
    required this.vehicleModel,
    required this.vehicleColor,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      userId: json['user_id'],
      vehicleType: json['vehicle_type'],
      vehiclePlateNumber: json['vehicle_plate_number'],
      vehicleModel: json['vehicle_model'],
      vehicleColor: json['vehicle_color'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class UserProfile {
  final String name;
  final String phone;
  final String gender;
  final List<Vehicle> vehicles;
  final List<City> cities;
  final int completedShipments;

  UserProfile({
    required this.name,
    required this.phone,
    required this.gender,
    required this.vehicles,
    required this.cities,
    required this.completedShipments,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    var vehiclesFromJson = json['vehicles'] as List;
    List<Vehicle> vehicleList = vehiclesFromJson.map((vehicleJson) => Vehicle.fromJson(vehicleJson)).toList();

    var citiesFromJson = json['cities'] as List;
    List<City> cityList = citiesFromJson.map((cityJson) => City.fromJson(cityJson)).toList();

    return UserProfile(
      name: json['name'],
      phone: json['phone'],
      gender: json['gender'],
      vehicles: vehicleList,
      cities: cityList,
      completedShipments: json['completed_shipments'],
    );
  }
}
