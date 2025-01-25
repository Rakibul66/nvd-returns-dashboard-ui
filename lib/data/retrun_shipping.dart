import 'package:scanpackage/data/tracking_details.dart';

import 'address.dart';

class ReturnShipping {
  int id;
  int shippingIntegrationId;
  int returnId;
  String shopUrl;
  String carrier;
  String trackingNumber;
  String currency;
  double price;
  String status;
  String downloadLink;
  DateTime createdAt;
  DateTime updatedAt;
  Address from;
  Address to;
  String returnMethod;
  List<TrackingDetail> trackingDetails;

  ReturnShipping({
    required this.id,
    required this.shippingIntegrationId,
    required this.returnId,
    required this.shopUrl,
    required this.carrier,
    required this.trackingNumber,
    required this.currency,
    required this.price,
    required this.status,
    required this.downloadLink,
    required this.createdAt,
    required this.updatedAt,
    required this.from,
    required this.to,
    required this.returnMethod,
    required this.trackingDetails,
  });

  factory ReturnShipping.fromJson(Map<String, dynamic> json) {
    return ReturnShipping(
      id: json['id'],
      shippingIntegrationId: json['shipping_integration_id'],
      returnId: json['return_id'],
      shopUrl: json['shop_url'],
      carrier: json['carrier'],
      trackingNumber: json['tracking_number'],
      currency: json['currency'],
      price: json['price'].toDouble(),
      status: json['status'],
      downloadLink: json['download_link'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      from: Address.fromJson(json['from']),
      to: Address.fromJson(json['to']),
      returnMethod: json['return_method'],
      trackingDetails: (json['tracking_details'] as List)
          .map((detail) => TrackingDetail.fromJson(detail))
          .toList(),
    );
  }
}
