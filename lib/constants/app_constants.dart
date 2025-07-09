// lib/core/constants/app_constants.dart

class AppConstants {
  static const String appName = 'LinguaLeap';
  static const String baseUrl = 'https://lingualeap-f3bh.onrender.com';
  
  // Test endpoint
  static const String healthCheck = '$baseUrl/health';
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String userDataKey = 'user_data';
}