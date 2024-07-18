class AnnouncementResponse {
  final bool status;
  final String message;

  AnnouncementResponse({required this.status, required this.message});

  factory AnnouncementResponse.fromJson(Map<String, dynamic> json) {
    return AnnouncementResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}
