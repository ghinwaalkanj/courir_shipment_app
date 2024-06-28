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
