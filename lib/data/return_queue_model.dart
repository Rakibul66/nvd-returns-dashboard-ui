class ReturnQueueModel {
  int id;
  String shopUrl;
  String rmaNumber;
  String name;
  String returnId;
  String status;
  String orderId;
  String? declineReason;
  String? declineNote;
  String? refundStatus;
  DateTime createdAt;
  DateTime updatedAt;
  String customerId;
  String country;
  bool isManualProcess;
  String customerEmail;
  String? returnMethodId;
  bool shipmentReceived;
  bool protectedStatus;
  String? protectionType;
  int returnPolicyId;
  int historiesCount;

  ReturnQueueModel({
    required this.id,
    required this.shopUrl,
    required this.rmaNumber,
    required this.name,
    required this.returnId,
    required this.status,
    required this.orderId,
    this.declineReason,
    this.declineNote,
    this.refundStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.customerId,
    required this.country,
    required this.isManualProcess,
    required this.customerEmail,
    this.returnMethodId,
    required this.shipmentReceived,
    required this.protectedStatus,
    this.protectionType,
    required this.returnPolicyId,
    required this.historiesCount,
  });

  // Factory constructor to create a ReturnQueueModel instance from JSON
  factory ReturnQueueModel.fromJson(Map<String, dynamic> json) {
  return ReturnQueueModel(
    id: json['id'],
    shopUrl: json['shop_url'],
    rmaNumber: json['rma_number'],
    name: json['name'],
    returnId: json['return_id'].toString(), // Ensure this is a string
    status: json['status'],
    orderId: json['order_id'].toString(), // Ensure this is a string
    declineReason: json['decline_reason'],
    declineNote: json['decline_note'],
    refundStatus: json['refund_status'],
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
    customerId: json['customer_id'].toString(), // Ensure this is a string
    country: json['country'],
    isManualProcess: json['is_manual_process'] == 1,
    customerEmail: json['customer_email'],
    returnMethodId: json['return_method_id']?.toString(), // Convert to string or handle null
    shipmentReceived: json['shipment_received'] == 1,
    protectedStatus: json['protected'] == 1,
    protectionType: json['protection_type'],
    returnPolicyId: json['return_policy_id'],
    historiesCount: json['histories_count'],
  );
}


  // Method to convert ReturnQueueModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shop_url': shopUrl,
      'rma_number': rmaNumber,
      'name': name,
      'return_id': returnId,
      'status': status,
      'order_id': orderId,
      'decline_reason': declineReason,
      'decline_note': declineNote,
      'refund_status': refundStatus,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'customer_id': customerId,
      'country': country,
      'is_manual_process': isManualProcess ? 1 : 0,
      'customer_email': customerEmail,
      'return_method_id': returnMethodId,
      'shipment_received': shipmentReceived ? 1 : 0,
      'protected': protectedStatus ? 1 : 0,
      'protection_type': protectionType,
      'return_policy_id': returnPolicyId,
      'histories_count': historiesCount,
    };
  }
}
