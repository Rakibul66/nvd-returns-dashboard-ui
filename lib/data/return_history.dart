class ReturnHistory {
  int? id;
  String? shopUrl;
  int? userId;
  int? returnId;
  String? type;
  String? message;
  DateTime? createdAt;
  DateTime? updatedAt;
  ReturnData? nvdReturn;
  User? user;

  ReturnHistory({
    this.id,
    this.shopUrl,
    this.userId,
    this.returnId,
    this.type,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.nvdReturn,
    this.user,
  });

  factory ReturnHistory.fromJson(Map<String, dynamic> json) {
    return ReturnHistory(
      id: json['id'],
      shopUrl: json['shop_url'],
      userId: json['user_id'],
      returnId: json['return_id'],
      type: json['type'],
      message: json['message'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      nvdReturn: ReturnData.fromJson(json['nvd_return']),
      user: User.fromJson(json['user']),
    );
  }
}

class ReturnData {
  int? id;
  String? rmaNumber;

  ReturnData({
    this.id,
    this.rmaNumber,
  });

  factory ReturnData.fromJson(Map<String, dynamic> json) {
    return ReturnData(
      id: json['id'],
      rmaNumber: json['rma_number'],
    );
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;

  User({
    this.id,
    this.firstName,
    this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }
}

class HistoryResponse {
  int? status;
  String? message;
  HistoryData? histories;

  HistoryResponse({this.status, this.message, this.histories});

  factory HistoryResponse.fromJson(Map<String, dynamic> json) {
    return HistoryResponse(
      status: json['status'],
      message: json['message'],
      histories: HistoryData.fromJson(json['histories']),
    );
  }
}

class HistoryData {
  int? currentPage;
  List<ReturnHistory>? data;
  String? firstPageUrl;
  int? total;

  HistoryData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.total,
  });

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    return HistoryData(
      currentPage: json['current_page'],
      data: (json['data'] as List).map((i) => ReturnHistory.fromJson(i)).toList(),
      firstPageUrl: json['first_page_url'],
      total: json['total'],
    );
  }
}
