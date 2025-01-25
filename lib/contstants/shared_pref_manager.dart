import 'package:scanpackage/data/auth_token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static late SharedPreferences _prefs;
  static const String selectedStoreKey = 'selected_store';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
static Future<void> saveSelectedStore(String store) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(selectedStoreKey, store);
  }

  static Future<String?> getSelectedStore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(selectedStoreKey);
  }
  static Future<void> saveAuthToken(AuthToken token) async {
    await _prefs.setString('auth_token', token.accessToken);
    await _prefs.setString('refresh_token', token.refreshToken);
    await _prefs.setString('token_type', token.tokenType);
    await _prefs.setInt('expires_in', token.expiresIn);
  }

  static AuthToken? getAuthToken() {
    final accessToken = _prefs.getString('auth_token');
    final refreshToken = _prefs.getString('refresh_token');
    final tokenType = _prefs.getString('token_type');
    final expiresIn = _prefs.getInt('expires_in');
    
    if (accessToken != null && refreshToken != null && tokenType != null && expiresIn != null) {
      return AuthToken(
        accessToken: accessToken,
        refreshToken: refreshToken,
        tokenType: tokenType,
        expiresIn: expiresIn,
      );
    }
    return null;
  }

  static Future<void> clearToken() async {
    await _prefs.remove('auth_token');
    await _prefs.remove('refresh_token');
    await _prefs.remove('token_type');
    await _prefs.remove('expires_in');
  }
}
