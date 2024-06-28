class WeeklyIncomeResponse {
  final bool status;
  final String startDate;
  final String endDate;
  final int totalIncome;
  final List<Shipment> shipments;

  WeeklyIncomeResponse({
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.totalIncome,
    required this.shipments,
  });

  factory WeeklyIncomeResponse.fromJson(Map<dynamic, dynamic> json) {
    return WeeklyIncomeResponse(
      status: json['status'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      totalIncome: json['total_income'],
      shipments: (json['shipments'] as List).map((i) => Shipment.fromJson(i)).toList(),
    );
  }
}

class Shipment {
  final int shipmentId;
  final String shipmentNumber;
  final String shipmentFee;
  final int shipmentStatus;
  final String updatedAt;
  final String createdAt;
  final String acceptedAt;
  final String recipientName;
  final String recipientPhone;
  final String recipientAddress;
  final String recipientLat;
  final String recipientLong;
  final String recipientCity;
  final String shipmentType;
  final String shipmentWeight;
  final int shipmentQuantity;
  final String shipmentValue;
  final String shipmentNote;
  final String shipmentContents;
  final String userName;
  final String userBusinessName;
  final String userPhone;
  final String fromAddressDetails;
  final String fromAddressLat;
  final String fromAddressLong;
  final String fromCityName;
  final String courierIncome;

  Shipment({
    required this.shipmentId,
    required this.shipmentNumber,
    required this.shipmentFee,
    required this.shipmentStatus,
    required this.updatedAt,
    required this.createdAt,
    required this.acceptedAt,
    required this.recipientName,
    required this.recipientPhone,
    required this.recipientAddress,
    required this.recipientLat,
    required this.recipientLong,
    required this.recipientCity,
    required this.shipmentType,
    required this.shipmentWeight,
    required this.shipmentQuantity,
    required this.shipmentValue,
    required this.shipmentNote,
    required this.shipmentContents,
    required this.userName,
    required this.userBusinessName,
    required this.userPhone,
    required this.fromAddressDetails,
    required this.fromAddressLat,
    required this.fromAddressLong,
    required this.fromCityName,
    required this.courierIncome,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      shipmentId: json['shipment_id'],
      shipmentNumber: json['shipment_number'],
      shipmentFee: json['shipment_fee'],
      shipmentStatus: json['shipment_status'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      acceptedAt: json['accepted_at'],
      recipientName: json['recipient_name'],
      recipientPhone: json['recipient_phone'],
      recipientAddress: json['recipient_address'],
      recipientLat: json['recipient_lat'],
      recipientLong: json['recipient_long'],
      recipientCity: json['recipient_city'],
      shipmentType: json['shipment_type'],
      shipmentWeight: json['shipment_weight'],
      shipmentQuantity: json['shipment_quantity'],
      shipmentValue: json['shipment_value'],
      shipmentNote: json['shipment_note'],
      shipmentContents: json['shipment_contents'],
      userName: json['user_name'],
      userBusinessName: json['user_business_name'],
      userPhone: json['user_phone'],
      fromAddressDetails: json['from_address_details'],
      fromAddressLat: json['from_address_lat'],
      fromAddressLong: json['from_address_long'],
      fromCityName: json['from_city_name'],
      courierIncome: json['courier_income'],
    );
  }
}
