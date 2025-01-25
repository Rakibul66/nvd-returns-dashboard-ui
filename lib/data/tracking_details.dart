import 'package:scanpackage/data/tracking_location.dart';

class TrackingDetail {
  String object;
  String source;
  String status;
  String message;
  DateTime datetime;
  String? description;
  String? carrierCode;
  String statusDetail;
  TrackingLocation trackingLocation;

  TrackingDetail({
    required this.object,
    required this.source,
    required this.status,
    required this.message,
    required this.datetime,
    this.description,
    this.carrierCode,
    required this.statusDetail,
    required this.trackingLocation,
  });

  factory TrackingDetail.fromJson(Map<String, dynamic> json) {
    return TrackingDetail(
      object: json['object'],
      source: json['source'],
      status: json['status'],
      message: json['message'],
      datetime: DateTime.parse(json['datetime']),
      description: json['description'],
      carrierCode: json['carrier_code'],
      statusDetail: json['status_detail'],
      trackingLocation: TrackingLocation.fromJson(json['tracking_location']),
    );
  }
}
