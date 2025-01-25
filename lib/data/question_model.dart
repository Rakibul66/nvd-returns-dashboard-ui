import 'package:scanpackage/data/option_model.dart';

class QuestionModel {
  final int id;
  final String shopUrl;
  final String title;
  final String type; // input, select, checkbox, radio
  final String? placeholder;
  final List<OptionModel>?
      options; // Only applicable for select, checkbox, radio

  QuestionModel({
    required this.id,
    required this.shopUrl,
    required this.title,
    required this.type,
    this.placeholder,
    this.options,
    // Initialize the new field
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      shopUrl: json['shop_url'],
      title: json['title'],
      type: json['type'],
      placeholder: json['placeholder'],
      options: json['option'] != null
          ? (json['option'] as List)
              .map((option) => OptionModel.fromJson(option))
              .toList()
          : null, // Parse answer from JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shop_url': shopUrl,
      'title': title,
      'type': type,
      'placeholder': placeholder,
      'option':
          options?.map((e) => e.toJson()).toList(), // Include answer in JSON
    };
  }
}

class LogisticAnswer {
  final int id;
  final String shopUrl;
  final int returnVariantId;
  final int returnLogisticsQuestionId;
  final String title;
  final List<String> answer;
  final int userId;

  LogisticAnswer({
    required this.id,
    required this.shopUrl,
    required this.returnVariantId,
    required this.returnLogisticsQuestionId,
    required this.title,
    required this.answer,
    required this.userId,
  });

  factory LogisticAnswer.fromJson(Map<String, dynamic> json) {
    return LogisticAnswer(
      id: json['id'],
      shopUrl: json['shop_url'],
      returnVariantId: json['return_variant_id'],
      returnLogisticsQuestionId: json['return_logistics_question_id'],
      title: json['title'],
      answer: List<String>.from(json['answer']),
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shop_url': shopUrl,
      'return_variant_id': returnVariantId,
      'return_logistics_question_id': returnLogisticsQuestionId,
      'title': title,
      'answer': answer,
      'user_id': userId,
    };
  }
}

class QNAModel {
  final List<QuestionModel> questions;
  final List<LogisticAnswer> logisticAnswers;

  QNAModel({
    required this.questions,
    required this.logisticAnswers,
  });
}
