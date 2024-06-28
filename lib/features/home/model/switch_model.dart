class WorkStatusResponseModel {
  final bool status;
  final String? message;

  WorkStatusResponseModel({
    required this.status,
    required this.message,
  });

  factory WorkStatusResponseModel.fromJson(Map<dynamic, dynamic> json) {
    return WorkStatusResponseModel(
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }
}
