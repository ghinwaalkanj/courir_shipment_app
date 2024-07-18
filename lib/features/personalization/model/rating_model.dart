class RatingResponse {
  final bool status;
  final String message;

  RatingResponse({required this.status, required this.message});

  factory RatingResponse.fromJson(Map<String, dynamic> json) {
    return RatingResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}
