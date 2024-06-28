class BlockStatus {
  final bool status;
  final int isBlocked;

  BlockStatus({
    required this.status,
    required this.isBlocked,
  });

  factory BlockStatus.fromJson(Map<dynamic, dynamic> json) {
    return BlockStatus(
      status: json['status'],
      isBlocked: json['is_blocked'],
    );
  }
}
