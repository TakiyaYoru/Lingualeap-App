// lib/shared/models/user_model.dart

class UserModel {
  final String id;
  final String username;
  final String email;
  final String displayName;
  final String currentLevel;
  final int totalXP;
  final int hearts;
  final int currentStreak;
  final String subscriptionType;
  final bool isPremium;
  final bool isActive;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.displayName,
    required this.currentLevel,
    required this.totalXP,
    required this.hearts,
    required this.currentStreak,
    required this.subscriptionType,
    required this.isPremium,
    required this.isActive,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      displayName: json['displayName'] ?? '',
      currentLevel: json['currentLevel'] ?? 'A1',
      totalXP: json['totalXP'] ?? 0,
      hearts: json['hearts'] ?? 5,
      currentStreak: json['currentStreak'] ?? 0,
      subscriptionType: json['subscriptionType'] ?? 'free',
      isPremium: json['isPremium'] ?? false,
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'displayName': displayName,
      'currentLevel': currentLevel,
      'totalXP': totalXP,
      'hearts': hearts,
      'currentStreak': currentStreak,
      'subscriptionType': subscriptionType,
      'isPremium': isPremium,
      'isActive': isActive,
    };
  }
}