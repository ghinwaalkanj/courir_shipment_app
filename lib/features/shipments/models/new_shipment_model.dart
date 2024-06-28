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
  final String acceptedAt;
  final String createdAt;
  final String updatedAt;
  final String estimatedDeliveryTime;
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
    required this.acceptedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.estimatedDeliveryTime,
    required this.courierEarnings,
  });

  factory ShipmentInfo.fromJson(Map<String, dynamic> json) {
    return ShipmentInfo(
      shipmentId: json['shipment_id'] ?? 0,
      shipmentStatus: json['shipment_status'] ?? 0,
      shipmentType: json['shipment_type'] ?? '',
      shipmentWeight: json['shipment_weight'] ?? '',
      shipmentQuantity: json['shipment_quantity'] ?? 0,
      shipmentValue: json['shipment_value'] ?? '',
      shipmentFee: json['shipment_fee'] ?? '',
      shipmentNote: json['shipment_note'] ?? '',
      shipmentContents: json['shipment_contents'] ?? '',
      shipmentNumber: json['shipment_number'] ?? '',
      acceptedAt: json['accepted_at'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      estimatedDeliveryTime: json['estimated_delivery_time'] ?? '',
      courierEarnings: json['courier_earnings'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'shipment_id': shipmentId,
    'shipment_status': shipmentStatus,
    'shipment_type': shipmentType,
    'shipment_weight': shipmentWeight,
    'shipment_quantity': shipmentQuantity,
    'shipment_value': shipmentValue,
    'shipment_fee': shipmentFee,
    'shipment_note': shipmentNote,
    'shipment_contents': shipmentContents,
    'shipment_number': shipmentNumber,
    'accepted_at': acceptedAt,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'estimated_delivery_time': estimatedDeliveryTime,
    'courier_earnings': courierEarnings,
  };
}

class UserInfo {
  final String name;
  final String businessName;
  final String fromAddressDetails;
  final String fromAddressLat;
  final String fromAddressLong;
  final String city;

  UserInfo({
    required this.name,
    required this.businessName,
    required this.fromAddressDetails,
    required this.fromAddressLat,
    required this.fromAddressLong,
    required this.city,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      name: json['name'],
      businessName: json['business_name'],
      fromAddressDetails: json['from_address_details'],
      fromAddressLat: json['from_address_lat'],
      fromAddressLong: json['from_address_long'],
      city: json['city'],
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

class Shipment {
  final RecipientInfo recipientInfo;
  final ShipmentInfo shipmentInfo;
  final UserInfo userInfo;
  final List<Announcement> announcements;

  Shipment({
    required this.recipientInfo,
    required this.shipmentInfo,
    required this.userInfo,
    required this.announcements,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {
    var announcementList = json['announcements'] as List;
    List<Announcement> announcements =
    announcementList.map((i) => Announcement.fromJson(i)).toList();

    return Shipment(
      recipientInfo: RecipientInfo.fromJson(json['recipient_info']),
      shipmentInfo: ShipmentInfo.fromJson(json['shipment_info']),
      userInfo: UserInfo.fromJson(json['user_info']),
      announcements: announcements,
    );
  }
}
