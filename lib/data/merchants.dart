class MerchantResponse {
  final int status;
  final String message;
  final Merchants merchants;

  MerchantResponse({required this.status, required this.message, required this.merchants});

  factory MerchantResponse.fromJson(Map<String, dynamic> json) {
    return MerchantResponse(
      status: json['status'],
      message: json['message'],
      merchants: Merchants.fromJson(json['merchants']),
    );
  }
}

class Merchants {
  final int currentPage;
  final List<MerchantData> data;

  Merchants({required this.currentPage, required this.data});

  factory Merchants.fromJson(Map<String, dynamic> json) {
    var merchantList = (json['data'] as List).map((item) => MerchantData.fromJson(item)).toList();
    return Merchants(
      currentPage: json['current_page'],
      data: merchantList,
    );
  }
}

class MerchantData {
  final String serviceName;
  final String role;
  final String shopUrl;
  final Permissions permissions; // Add Permissions field

  MerchantData({
    required this.serviceName,
    required this.role,
    required this.shopUrl,
    required this.permissions,
  });

  factory MerchantData.fromJson(Map<String, dynamic> json) {
    return MerchantData(
      serviceName: json['service_name'],
      role: json['role'],
      shopUrl: json['shop_url'],
      permissions: Permissions.fromJson(json['permissions']),
    );
  }
}

// Define Permissions Model
class Permissions {
  final int claims;
  final int orders;
  final int upgrade;
  final int settings;
  final int integrations;

  Permissions({
    required this.claims,
    required this.orders,
    required this.upgrade,
    required this.settings,
    required this.integrations,
  });

  factory Permissions.fromJson(Map<String, dynamic> json) {
    return Permissions(
      claims: json['claims'],
      orders: json['orders'],
      upgrade: json['upgrade'],
      settings: json['settings'],
      integrations: json['integrations'],
    );
  }
}
