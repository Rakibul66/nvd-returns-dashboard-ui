// Model classes
import 'package:scanpackage/data/retrun_shipping.dart';

class RmaData {
  int id;
  String shopUrl;
  String rmaNumber;
  String name;
  String returnId;
  String status;
  int shipmentRecive;
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

  List<ReturnVariant> returnVariants;

  ReturnShipping? returnShipping;
  RmaData({
    required this.id,
    required this.shopUrl,
    required this.rmaNumber,
    required this.name,
    required this.returnId,
    required this.status,
    required this.shipmentRecive,
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
    required this.returnVariants,
    this.returnShipping,
  });

  factory RmaData.fromJson(Map<String, dynamic> json) {
    return RmaData(
      id: json['id'] ?? 0, // Default value if null
      shopUrl: json['shop_url'] ?? '', // Default value if null
      rmaNumber: json['rma_number'] ?? '', // Default value if null
      name: json['name'] ?? '', // Default value if null
      returnId: json['return_id'] ?? '', // Default value if null
      status: json['status'] ?? '', // Default value if null
      shipmentRecive: json['shipment_received'], // Default value if null
      orderId: json['order_id'] ?? '', // Default value if null
      declineReason: json['decline_reason'],
      declineNote: json['decline_note'],
      refundStatus: json['refund_status'],
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ??
          DateTime.now(), // Default to now if parsing fails
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ??
          DateTime.now(), // Default to now if parsing fails
      customerId: json['customer_id'] ?? '', // Default value if null
      country: json['country'] ?? '', // Default value if null
      isManualProcess: json['is_manual_process'] == 1,
      customerEmail: json['customer_email'] ?? '', // Default value if null

      returnVariants: (json['return_variants'] as List<dynamic>?)
              ?.map((variant) => ReturnVariant.fromJson(variant))
              .toList() ??
          [],
      returnShipping: json['return_shipping'] != null
          ? ReturnShipping.fromJson(json['return_shipping'])
          : null, // Parse ReturnShipping if available
    );
  }
}

class ReturnVariant {
  int id;
  String shopUrl;
  int returnId;
  int? logisticAnswersCount;
  String fulfillmentLineItemId;
  String lineItemId;
  String returnLineItemId;
  String returnPolicy;
  int quantity;
  String reason;
  String resolution;
  String imageUrl;
  double price;
  List<dynamic> attachments;
  Meta? meta;
  ProductInfoMeta? productInfoMeta;

  ReturnVariant({
    required this.id,
    required this.shopUrl,
    required this.returnId,
    this.logisticAnswersCount,
    required this.fulfillmentLineItemId,
    required this.lineItemId,
    required this.returnLineItemId,
    required this.returnPolicy,
    required this.quantity,
    required this.reason,
    required this.resolution,
    required this.imageUrl,
    required this.price,
    required this.attachments,
    this.meta,
    this.productInfoMeta,
  });

  factory ReturnVariant.fromJson(Map<String, dynamic> json) {
    ProductInfoMeta? productInfoMeta;
    if (json['product_info_meta'] != null) {
      productInfoMeta = ProductInfoMeta.fromJson(json['product_info_meta']);
    }

    return ReturnVariant(
      id: json['id'] ?? 0,
      shopUrl: json['shop_url'] ?? '',
      returnId: json['return_id'] ?? 0,
       logisticAnswersCount: json['logistic_answers_count'] ?? 0,
      fulfillmentLineItemId: json['fulfillment_lineItem_id'] ?? '',
      lineItemId: json['lineItem_id'] ?? '',
      returnLineItemId: json['return_lineItem_id'] ?? '',
      returnPolicy: json['return_policy'] ?? '',
      quantity: json['quantity'] ?? 0,
      reason: json['reason'] ?? '',
      resolution: json['resolution'] ?? '',
      imageUrl: json['image_url'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      attachments: json['attachments'] ?? [],
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      productInfoMeta: productInfoMeta,
    );
  }
}

class Meta {
  int id;
  int returnVariantId;
  List<String> metaValue;

  Meta({
    required this.id,
    required this.returnVariantId,
    required this.metaValue,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      id: json['id'] ?? 0,
      returnVariantId: json['return_variant_id'] ?? 0,
      metaValue: List<String>.from(json['meta_value'] ?? []),
    );
  }
}

class ProductInfoMeta {
  int id;
  int returnVariantId;
  String image;
  String title;
  List<Map<String, dynamic>> options;

  ProductInfoMeta({
    required this.id,
    required this.returnVariantId,
    required this.image,
    required this.title,
    required this.options,
  });

  factory ProductInfoMeta.fromJson(Map<String, dynamic> json) {
    var metaValue = json['meta_value'];

    return ProductInfoMeta(
      id: json['id'] ?? 0,
      returnVariantId: json['return_variant_id'] ?? 0,
      image: metaValue['image'] ?? '',
      title: metaValue['title'] ?? '',
      options: List<Map<String, dynamic>>.from(
          metaValue['options'] ?? []), // Accessing options from meta_value
    );
  }
}

class Option {
  String name;
  List<String> values;

  Option({
    required this.name,
    required this.values,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      name: json['name'] ?? '',
      values: List<String>.from(
          json['value'] ?? []), // Assuming `value` is the correct key
    );
  }
}
