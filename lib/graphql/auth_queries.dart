// lib/core/graphql/auth_queries.dart

class AuthQueries {
  // Login mutation - sử dụng input object
  static const String login = '''
    mutation Login(\$input: LoginInput!) {
      login(input: \$input) {
        user {
          id
          username
          email
          displayName
          currentLevel
          totalXP
          hearts
          currentStreak
          subscriptionType
          isPremium
          isActive
        }
        token
      }
    }
  ''';

  // Register mutation - sử dụng input object
  static const String register = '''
    mutation Register(\$input: RegisterInput!) {
      register(input: \$input) {
        user {
          id
          username
          email
          displayName
          currentLevel
          totalXP
          hearts
          currentStreak
          subscriptionType
          isPremium
          isActive
        }
        token
      }
    }
  ''';

  // Get current user query
  static const String getCurrentUser = '''
    query GetCurrentUser {
      me {
        id
        username
        email
        displayName
        currentLevel
        totalXP
        hearts
        currentStreak
        subscriptionType
        isPremium
        isActive
      }
    }
  ''';
}