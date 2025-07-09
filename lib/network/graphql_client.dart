// lib/core/network/graphql_client.dart
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class GraphQLService {
  static GraphQLClient? _client;
  
  static GraphQLClient get client {
    if (_client == null) {
      final HttpLink httpLink = HttpLink(
        '${AppConstants.baseUrl}/graphql',
      );
      
      // Auth link để tự động thêm token vào header
      final AuthLink authLink = AuthLink(
        getToken: () async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString(AppConstants.tokenKey);
          return token != null ? 'Bearer $token' : null;
        },
      );
      
      final Link link = authLink.concat(httpLink);
      
      _client = GraphQLClient(
        link: link,
        cache: GraphQLCache(store: InMemoryStore()),
      );
    }
    return _client!;
  }
  
  // Test query đơn giản
  static const String testQuery = '''
    query {
      hello
    }
  ''';
  
  static Future<bool> testGraphQLConnection() async {
    try {
      final QueryOptions options = QueryOptions(document: gql(testQuery));
      final QueryResult result = await client.query(options);
      
      print('GraphQL response: ${result.data}');
      return !result.hasException;
    } catch (e) {
      print('GraphQL error: $e');
      return false;
    }
  }
}