// lib/core/network/auth_service.dart
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../graphql/auth_queries.dart';
import '../constants/app_constants.dart';
import 'graphql_client.dart';

class AuthService {
  // Test login với GraphQL
  static Future<Map<String, dynamic>?> testLogin(String email, String password) async {
    try {
      final MutationOptions options = MutationOptions(
        document: gql(AuthQueries.login),
        variables: {
          'input': {
            'email': email,
            'password': password,
          }
        },
      );

      final QueryResult result = await GraphQLService.client.mutate(options);
      
      print('Login result: ${result.data}');
      print('Login errors: ${result.exception}');
      
      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      return result.data?['login'];
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  // Test register với GraphQL
  static Future<Map<String, dynamic>?> testRegister(String email, String password, String username, String displayName) async {
    try {
      final MutationOptions options = MutationOptions(
        document: gql(AuthQueries.register),
        variables: {
          'input': {
            'email': email,
            'password': password,
            'username': username,
            'displayName': displayName,
          }
        },
      );

      final QueryResult result = await GraphQLService.client.mutate(options);
      
      print('Register result: ${result.data}');
      print('Register errors: ${result.exception}');
      
      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      return result.data?['register'];
    } catch (e) {
      print('Register error: $e');
      return null;
    }
  }

  // Save token to SharedPreferences
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.tokenKey, token);
  }

  // Get token from SharedPreferences
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.tokenKey);
  }

  // Clear token (logout)
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.tokenKey);
  }

  // Get current user từ backend
  static Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      final token = await getToken();
      if (token == null) return null;

      final QueryOptions options = QueryOptions(
        document: gql(AuthQueries.getCurrentUser),
        fetchPolicy: FetchPolicy.networkOnly, // Luôn lấy data mới
      );

      final QueryResult result = await GraphQLService.client.query(options);
      
      print('Get current user result: ${result.data}');
      print('Get current user errors: ${result.exception}');
      
      if (result.hasException) {
        print('getCurrentUser error: ${result.exception}');
        return null;
      }

      return result.data?['me'];
    } catch (e) {
      print('getCurrentUser error: $e');
      return null;
    }
  }
}