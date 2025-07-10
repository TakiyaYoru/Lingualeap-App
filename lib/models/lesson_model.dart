// lib/models/lesson_model.dart
class LessonModel {
  final String id;
  final String title;
  final String description;
  final String unitId;
  final String courseId;
  final String objective;
  final int estimatedDuration;
  final int totalExercises;
  final String difficulty;
  final int xpReward;
  final bool isPremium;
  final bool isPublished;
  final int sortOrder;
  final UnlockRequirements? unlockRequirements;
  final DateTime createdAt;
  final DateTime updatedAt;

  LessonModel({
    required this.id,
    required this.title,
    required this.description,
    required this.unitId,
    required this.courseId,
    required this.objective,
    required this.estimatedDuration,
    required this.totalExercises,
    required this.difficulty,
    required this.xpReward,
    required this.isPremium,
    required this.isPublished,
    required this.sortOrder,
    this.unlockRequirements,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      unitId: json['unitId'] ?? '',
      courseId: json['courseId'] ?? '',
      objective: json['objective'] ?? '',
      estimatedDuration: json['estimatedDuration'] ?? 0,
      totalExercises: json['totalExercises'] ?? 0,
      difficulty: json['difficulty'] ?? 'easy',
      xpReward: json['xpReward'] ?? 0,
      isPremium: json['isPremium'] ?? false,
      isPublished: json['isPublished'] ?? false,
      sortOrder: json['sortOrder'] ?? 0,
      unlockRequirements: json['unlockRequirements'] != null
          ? UnlockRequirements.fromJson(json['unlockRequirements'])
          : null,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'unitId': unitId,
      'courseId': courseId,
      'objective': objective,
      'estimatedDuration': estimatedDuration,
      'totalExercises': totalExercises,
      'difficulty': difficulty,
      'xpReward': xpReward,
      'isPremium': isPremium,
      'isPublished': isPublished,
      'sortOrder': sortOrder,
      'unlockRequirements': unlockRequirements?.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class UnlockRequirements {
  final String? previousLessonId;
  final int? minimumScore;

  UnlockRequirements({
    this.previousLessonId,
    this.minimumScore,
  });

  factory UnlockRequirements.fromJson(Map<String, dynamic> json) {
    return UnlockRequirements(
      previousLessonId: json['previousLessonId'],
      minimumScore: json['minimumScore'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'previousLessonId': previousLessonId,
      'minimumScore': minimumScore,
    };
  }
}

// ===============================================
// lib/models/exercise_model.dart
// ===============================================

class ExerciseModel {
  final String id;
  final String title;
  final String instruction;
  final String courseId;
  final String unitId;
  final String lessonId;
  final ExerciseType type;
  final ExerciseQuestion question;
  final Map<String, dynamic> content;
  final int maxScore;
  final String difficulty;
  final int xpReward;
  final int? timeLimit;
  final int estimatedTime;
  final bool isPremium;
  final bool isActive;
  final int sortOrder;
  final ExerciseFeedback feedback;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  ExerciseModel({
    required this.id,
    required this.title,
    required this.instruction,
    required this.courseId,
    required this.unitId,
    required this.lessonId,
    required this.type,
    required this.question,
    required this.content,
    required this.maxScore,
    required this.difficulty,
    required this.xpReward,
    this.timeLimit,
    required this.estimatedTime,
    required this.isPremium,
    required this.isActive,
    required this.sortOrder,
    required this.feedback,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      instruction: json['instruction'] ?? '',
      courseId: json['courseId'] ?? '',
      unitId: json['unitId'] ?? '',
      lessonId: json['lessonId'] ?? '',
      type: ExerciseType.fromString(json['type'] ?? 'multiple_choice'),
      question: ExerciseQuestion.fromJson(json['question'] ?? {}),
      content: Map<String, dynamic>.from(json['content'] ?? {}),
      maxScore: json['maxScore'] ?? 100,
      difficulty: json['difficulty'] ?? 'easy',
      xpReward: json['xpReward'] ?? 10,
      timeLimit: json['timeLimit'],
      estimatedTime: json['estimatedTime'] ?? 60,
      isPremium: json['isPremium'] ?? false,
      isActive: json['isActive'] ?? true,
      sortOrder: json['sortOrder'] ?? 0,
      feedback: ExerciseFeedback.fromJson(json['feedback'] ?? {}),
      tags: List<String>.from(json['tags'] ?? []),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'instruction': instruction,
      'courseId': courseId,
      'unitId': unitId,
      'lessonId': lessonId,
      'type': type.name,
      'question': question.toJson(),
      'content': content,
      'maxScore': maxScore,
      'difficulty': difficulty,
      'xpReward': xpReward,
      'timeLimit': timeLimit,
      'estimatedTime': estimatedTime,
      'isPremium': isPremium,
      'isActive': isActive,
      'sortOrder': sortOrder,
      'feedback': feedback.toJson(),
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

// Exercise Types Enum
enum ExerciseType {
  multipleChoice('multiple_choice'),
  fillBlank('fill_blank'),
  listening('listening'),
  translation('translation'),
  speaking('speaking'),
  reading('reading'),
  wordMatching('word_matching'),
  sentenceBuilding('sentence_building'),
  trueFalse('true_false'),
  dragDrop('drag_drop');

  const ExerciseType(this.name);
  final String name;

  static ExerciseType fromString(String value) {
    return ExerciseType.values.firstWhere(
      (type) => type.name == value,
      orElse: () => ExerciseType.multipleChoice,
    );
  }

  String get displayName {
    switch (this) {
      case ExerciseType.multipleChoice:
        return 'Multiple Choice';
      case ExerciseType.fillBlank:
        return 'Fill in the Blank';
      case ExerciseType.listening:
        return 'Listening';
      case ExerciseType.translation:
        return 'Translation';
      case ExerciseType.speaking:
        return 'Speaking';
      case ExerciseType.reading:
        return 'Reading';
      case ExerciseType.wordMatching:
        return 'Word Matching';
      case ExerciseType.sentenceBuilding:
        return 'Sentence Building';
      case ExerciseType.trueFalse:
        return 'True or False';
      case ExerciseType.dragDrop:
        return 'Drag & Drop';
    }
  }
}

// Exercise Question Model
class ExerciseQuestion {
  final String text;
  final String? audioUrl;
  final String? imageUrl;
  final String? videoUrl;

  ExerciseQuestion({
    required this.text,
    this.audioUrl,
    this.imageUrl,
    this.videoUrl,
  });

  factory ExerciseQuestion.fromJson(Map<String, dynamic> json) {
    return ExerciseQuestion(
      text: json['text'] ?? '',
      audioUrl: json['audioUrl'],
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'audioUrl': audioUrl,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
    };
  }
}

// Exercise Feedback Model
class ExerciseFeedback {
  final String correct;
  final String incorrect;
  final String? hint;

  ExerciseFeedback({
    required this.correct,
    required this.incorrect,
    this.hint,
  });

  factory ExerciseFeedback.fromJson(Map<String, dynamic> json) {
    return ExerciseFeedback(
      correct: json['correct'] ?? 'Correct! Well done!',
      incorrect: json['incorrect'] ?? 'Not quite right. Try again!',
      hint: json['hint'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'correct': correct,
      'incorrect': incorrect,
      'hint': hint,
    };
  }
}