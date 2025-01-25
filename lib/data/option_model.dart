class OptionModel {
  final String text;
  final String value;

  OptionModel({required this.text, required this.value});

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      text: json['text'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'value': value,
    };
  }
}
