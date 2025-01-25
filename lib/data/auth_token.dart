class AuthToken {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;

  AuthToken({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
  });

  // Factory method to create an AuthToken from JSON with null checks
  factory AuthToken.fromJson(Map<String, dynamic> json) {
    // Using null checks to ensure the required fields are present
    if (json['access_token'] == null ||
        json['refresh_token'] == null ||
        json['token_type'] == null ||
        json['expires_in'] == null) {
      throw Exception('Missing required token fields');
    }

    return AuthToken(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      tokenType: json['token_type'] as String,
      expiresIn: json['expires_in'] as int,
    );
  }

  // Method to convert AuthToken to JSON with null safety
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
    };
  }
}
