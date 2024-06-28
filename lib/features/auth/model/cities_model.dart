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

class AddDeliveryCitiesResponse {
  final bool status;
  final String message;
  final int? successCount;

  AddDeliveryCitiesResponse({
    required this.status,
    required this.message,
    required this.successCount,
  });

  factory AddDeliveryCitiesResponse.fromJson(Map<dynamic, dynamic> json) {
    return AddDeliveryCitiesResponse(
      status: json['status'],
      message: json['message'],
      successCount: json['success_count'],
    );
  }
}
