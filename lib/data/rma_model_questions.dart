import 'package:scanpackage/data/question_model.dart';

class RmaModel {
  final int id;
  final String shopUrl;
  final int returnId;
  final String fulfillmentLineItemId;
  final String lineItemId;
  final String returnLineItemId;
  final String returnPolicy;
  final int quantity;
  final String reason;
  final String customerNote;
  final String resolution;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double price;
  final String storeCredit;
  final List<QuestionModel> questions;

  RmaModel({
    required this.id,
    required this.shopUrl,
    required this.returnId,
    required this.fulfillmentLineItemId,
    required this.lineItemId,
    required this.returnLineItemId,
    required this.returnPolicy,
    required this.quantity,
    required this.reason,
    required this.customerNote,
    required this.resolution,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.price,
    required this.storeCredit,
    required this.questions,
  });

  factory RmaModel.fromJson(Map<String, dynamic> json) {
    return RmaModel(
      id: json['id'],
      shopUrl: json['shop_url'],
      returnId: json['return_id'],
      fulfillmentLineItemId: json['fulfillment_lineItem_id'],
      lineItemId: json['lineItem_id'],
      returnLineItemId: json['return_lineItem_id'],
      returnPolicy: json['return_policy'],
      quantity: json['quantity'],
      reason: json['reason'],
      customerNote: json['customer_note'],
      resolution: json['resolution'],
      imageUrl: json['image_url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      price: json['price'].toDouble(),
      storeCredit: json['store_credit'],
      questions: (json['questions'] as List)
          .map((questionJson) => QuestionModel.fromJson(questionJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shop_url': shopUrl,
      'return_id': returnId,
      'fulfillment_lineItem_id': fulfillmentLineItemId,
      'lineItem_id': lineItemId,
      'return_lineItem_id': returnLineItemId,
      'return_policy': returnPolicy,
      'quantity': quantity,
      'reason': reason,
      'customer_note': customerNote,
      'resolution': resolution,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'price': price,
      'store_credit': storeCredit,
      'questions': questions.map((question) => question.toJson()).toList(),
    };
  }
}
