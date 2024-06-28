class UpdateShipmentStatusResponse {
  final bool status;
  final String message;
  final ShipmentDetails? shipmentDetails; // جعل ShipmentDetails nullable

  UpdateShipmentStatusResponse({
    required this.status,
    required this.message,
    this.shipmentDetails, // لا حاجة لجعل هذا الحقل required بعد الآن
  });

  factory UpdateShipmentStatusResponse.fromJson(Map<String, dynamic> json) {
    return UpdateShipmentStatusResponse(
      status: json['status'],
      message: json['message'],
      shipmentDetails: json['shipment_details'] != null
          ? ShipmentDetails.fromJson(json['shipment_details'])
          : null, // تعيين null إذا لم يكن موجودًا
    );
  }
}

class ShipmentDetails {
  final RecipientInfo recipientInfo;
  final ShipmentInfo shipmentInfo;
  final UserInfo userInfo;
  final DeliveryUserInfo deliveryUserInfo;
  final List<Announcement> announcements;

  ShipmentDetails({
    required this.recipientInfo,
    required this.shipmentInfo,
    required this.userInfo,
    required this.deliveryUserInfo,
    required this.announcements,
  });

  factory ShipmentDetails.fromJson(Map<dynamic, dynamic> json) {
    var announcementList = json['announcements'] as List;
    List<Announcement> announcements = announcementList
        .map((i) => Announcement.fromJson(i))
        .toList();

    return ShipmentDetails(
      recipientInfo: RecipientInfo.fromJson(json['recipient_info']),
      shipmentInfo: ShipmentInfo.fromJson(json['shipment_info']),
      userInfo: UserInfo.fromJson(json['user_info']),
      deliveryUserInfo: DeliveryUserInfo.fromJson(json['delivery_user_info']),
      announcements: announcements,
    );
  }
}

class RecipientInfo {
  final String name;
  final String phone;
  final String address;
  final String lat;
  final String long;
  final String city;

  RecipientInfo({
    required this.name,
    required this.phone,
    required this.address,
    required this.lat,
    required this.long,
    required this.city,
  });

  factory RecipientInfo.fromJson(Map<String, dynamic> json) {
    return RecipientInfo(
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      lat: json['lat'],
      long: json['long'],
      city: json['city'],
    );
  }
}

class ShipmentInfo {
  final int shipmentId;
  final int shipmentStatus;
  final String shipmentType;
  final String shipmentWeight;
  final int shipmentQuantity;
  final String shipmentValue;
  final String shipmentFee;
  final String shipmentNote;
  final String shipmentContents;
  final String shipmentNumber;
  final String? acceptedAt;
  final String createdAt;
  final String updatedAt;
  final String? estimatedDeliveryTime;
  final int courierEarnings;

  ShipmentInfo({
    required this.shipmentId,
    required this.shipmentStatus,
    required this.shipmentType,
    required this.shipmentWeight,
    required this.shipmentQuantity,
    required this.shipmentValue,
    required this.shipmentFee,
    required this.shipmentNote,
    required this.shipmentContents,
    required this.shipmentNumber,
    this.acceptedAt,
    required this.createdAt,
    required this.updatedAt,
    this.estimatedDeliveryTime,
    required this.courierEarnings,
  });

  factory ShipmentInfo.fromJson(Map<String, dynamic> json) {
    return ShipmentInfo(
      shipmentId: json['shipment_id'],
      shipmentStatus: json['shipment_status'],
      shipmentType: json['shipment_type'],
      shipmentWeight: json['shipment_weight'],
      shipmentQuantity: json['shipment_quantity'],
      shipmentValue: json['shipment_value'],
      shipmentFee: json['shipment_fee'],
      shipmentNote: json['shipment_note'],
      shipmentContents: json['shipment_contents'],
      shipmentNumber: json['shipment_number'],
      acceptedAt: json['accepted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      estimatedDeliveryTime: json['estimated_delivery_time'],
      courierEarnings: json['courier_earnings'] ?? 0,
    );
  }
}

class UserInfo {
  final String name;
  final String businessName;
  final String phone;
  final String fromAddressDetails;
  final String fromAddressLat;
  final String fromAddressLong;
  final String city;

  UserInfo({
    required this.name,
    required this.businessName,
    required this.phone,
    required this.fromAddressDetails,
    required this.fromAddressLat,
    required this.fromAddressLong,
    required this.city,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      name: json['name'],
      businessName: json['business_name'],
      phone: json['phone'],
      fromAddressDetails: json['from_address_details'],
      fromAddressLat: json['from_address_lat'],
      fromAddressLong: json['from_address_long'],
      city: json['city'],
    );
  }
}

class DeliveryUserInfo {
  final String? name;
  final String? phone;
  final double? averageRating;

  DeliveryUserInfo({
    this.name,
    this.phone,
    this.averageRating,
  });

  factory DeliveryUserInfo.fromJson(Map<String, dynamic> json) {
    return DeliveryUserInfo(
      name: json['name'],
      phone: json['phone'],
      averageRating: json['average_rating']?.toDouble(),
    );
  }
}

class Announcement {
  final int id;
  final int shipmentId;
  final int deliveryUserId;
  final String announcementsText;
  final String createdAt;
  final String updatedAt;

  Announcement({
    required this.id,
    required this.shipmentId,
    required this.deliveryUserId,
    required this.announcementsText,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'],
      shipmentId: json['shipment_id'],
      deliveryUserId: json['delivery_user_id'],
      announcementsText: json['announcements_text'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
