class UserProfile {
  final String name;
  final String phone;
  final String gender;
  final int completedShipments;

  UserProfile({
    required this.name,
    required this.phone,
    required this.gender,
    required this.completedShipments,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'],
      phone: json['phone'],
      gender: json['gender'],
      completedShipments: json['completed_shipments'],
    );
  }
}
