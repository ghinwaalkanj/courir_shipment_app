class VehicleInfoModel {
  final String vehicleType;
  final String vehiclePlateNumber;
  final String vehicleModel;
  final String vehicleColor;

  VehicleInfoModel({
    required this.vehicleType,
    required this.vehiclePlateNumber,
    required this.vehicleModel,
    required this.vehicleColor,
  });

  factory VehicleInfoModel.fromJson(Map<dynamic, dynamic> json) {
    return VehicleInfoModel(
      vehicleType: json['vehicle_type'],
      vehiclePlateNumber: json['vehicle_plate_number'],
      vehicleModel: json['vehicle_model'],
      vehicleColor: json['vehicle_color'],
    );
  }
}

class IDUploadResponseModel {
  final bool status;
  final String? error;
  final VehicleInfoModel? vehicleInfo;

  IDUploadResponseModel({
    required this.status,
    this.error,
    this.vehicleInfo,
  });

  factory IDUploadResponseModel.fromJson(Map<dynamic, dynamic> json) {
    return IDUploadResponseModel(
      status: json['status'],
      error: json['error'],
      vehicleInfo: json['vehicle_info'] != null
          ? VehicleInfoModel.fromJson(json['vehicle_info'])
          : null,
    );
  }
}
