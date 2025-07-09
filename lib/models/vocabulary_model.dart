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

  VocabularyWord({
    required this.id,
    required this.word,
    required this.meaning,
    this.pronunciation,
    this.example,
    this.isLearned = false,
    required this.createdAt,
    this.learnedAt,
  });

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'word': word,
      'meaning': meaning,
      'pronunciation': pronunciation,
      'example': example,
      'isLearned': isLearned,
      'createdAt': createdAt.toIso8601String(),
      'learnedAt': learnedAt?.toIso8601String(),
    };
  }

  // Create from JSON
  factory VocabularyWord.fromJson(Map<String, dynamic> json) {
    return VocabularyWord(
      id: json['id'],
      word: json['word'],
      meaning: json['meaning'],
      pronunciation: json['pronunciation'],
      example: json['example'],
      isLearned: json['isLearned'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      learnedAt: json['learnedAt'] != null 
          ? DateTime.parse(json['learnedAt']) 
          : null,
    );
  }

  // Copy with modifications
  VocabularyWord copyWith({
    String? id,
    String? word,
    String? meaning,
    String? pronunciation,
    String? example,
    bool? isLearned,
    DateTime? createdAt,
    DateTime? learnedAt,
  }) {
    return VocabularyWord(
      id: id ?? this.id,
      word: word ?? this.word,
      meaning: meaning ?? this.meaning,
      pronunciation: pronunciation ?? this.pronunciation,
      example: example ?? this.example,
      isLearned: isLearned ?? this.isLearned,
      createdAt: createdAt ?? this.createdAt,
      learnedAt: learnedAt ?? this.learnedAt,
    );
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