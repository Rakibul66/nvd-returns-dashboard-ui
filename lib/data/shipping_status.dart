class ShippingStatus {
  int statusCount;
  String status;

  ShippingStatus({
    required this.statusCount,
    required this.status,
  });

  factory ShippingStatus.fromJson(Map<String, dynamic> json) {
    return ShippingStatus(
      statusCount: json['status_count'] ?? 0, // Default to 0 if null
      status: json['status'] ?? '', // Default to empty string if null
    );
  }
}
