// lib/models/vocabulary_model.dart
class VocabularyWord {
  final String id;
  final String word;
  final String meaning;
  final String? pronunciation;
  final String? example;
  final bool isLearned;
  final DateTime createdAt;
  final DateTime? learnedAt;
  final String category;
  final List<String> tags;
  final int difficulty;
  final int reviewCount;
  final String source;

  VocabularyWord({
    required this.id,
    required this.word,
    required this.meaning,
    this.pronunciation,
    this.example,
    this.isLearned = false,
    required this.createdAt,
    this.learnedAt,
    this.category = 'general',
    this.tags = const [],
    this.difficulty = 1,
    this.reviewCount = 0,
    this.source = 'manual',
  });

  // Create from API JSON response
  factory VocabularyWord.fromJson(Map<String, dynamic> json) {
    return VocabularyWord(
      id: json['id']?.toString() ?? '',
      word: json['word'] ?? '',
      meaning: json['meaning'] ?? '',
      pronunciation: json['pronunciation'],
      example: json['example'],
      isLearned: json['isLearned'] ?? false,
      createdAt: _parseDateTime(json['createdAt']) ?? DateTime.now(),
      learnedAt: _parseDateTime(json['learnedAt']),
      category: json['category'] ?? 'general',
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      difficulty: json['difficulty'] ?? 1,
      reviewCount: json['reviewCount'] ?? 0,
      source: json['source'] ?? 'manual',
    );
  }

  // Helper method to parse different date formats from backend
  static DateTime? _parseDateTime(dynamic dateStr) {
    if (dateStr == null) return null;
    
    try {
      // Handle timestamp string (from backend)
      if (dateStr is String) {
        // Check if it's a timestamp in milliseconds
        if (RegExp(r'^\d+$').hasMatch(dateStr)) {
          return DateTime.fromMillisecondsSinceEpoch(int.parse(dateStr));
        }
        // Otherwise try to parse as ISO string
        return DateTime.parse(dateStr);
      }
      
      // Handle direct timestamp number
      if (dateStr is int) {
        return DateTime.fromMillisecondsSinceEpoch(dateStr);
      }
      
      return null;
    } catch (e) {
      print('Error parsing date: $dateStr, error: $e');
      return null;
    }
  }

  @override
  String toString() {
    return 'VocabularyWord(word: $word, meaning: $meaning, isLearned: $isLearned)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VocabularyWord && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

// Filter enum for vocabulary list
enum VocabularyFilter {
  all,
  unlearned,
  learned,
}

extension VocabularyFilterExtension on VocabularyFilter {
  String get displayName {
    switch (this) {
      case VocabularyFilter.all:
        return 'All Words';
      case VocabularyFilter.unlearned:
        return 'Unlearned';
      case VocabularyFilter.learned:
        return 'Learned';
    }
  }

  String get shortName {
    switch (this) {
      case VocabularyFilter.all:
        return 'All';
      case VocabularyFilter.unlearned:
        return 'New';
      case VocabularyFilter.learned:
        return 'Learned';
    }
  }
}