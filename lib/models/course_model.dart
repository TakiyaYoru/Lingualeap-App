// lib/shared/models/course_model.dart

import 'dart:ui';

class CourseModel {
  final String id;
  final String title;
  final String description;
  final String level;
  final String category;
  final String? thumbnail;
  final String color;
  final int estimatedDuration;
  final int totalUnits;
  final int totalLessons;
  final int totalExercises;
  final bool isPremium;
  final bool isPublished;
  final List<String> learningObjectives;
  final List<String> prerequisites;
  final String difficulty;
  final int completionRate;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.category,
    this.thumbnail,
    required this.color,
    required this.estimatedDuration,
    required this.totalUnits,
    required this.totalLessons,
    required this.totalExercises,
    required this.isPremium,
    required this.isPublished,
    required this.learningObjectives,
    required this.prerequisites,
    required this.difficulty,
    required this.completionRate,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      level: json['level'] ?? 'A1',
      category: json['category'] ?? 'general',
      thumbnail: json['thumbnail'],
      color: json['color'] ?? '#4CAF50',
      estimatedDuration: json['estimatedDuration'] ?? 0,
      totalUnits: json['totalUnits'] ?? 0,
      totalLessons: json['totalLessons'] ?? 0,
      totalExercises: json['totalExercises'] ?? 0,
      isPremium: json['isPremium'] ?? false,
      isPublished: json['isPublished'] ?? true,
      learningObjectives: List<String>.from(json['learningObjectives'] ?? []),
      prerequisites: List<String>.from(json['prerequisites'] ?? []),
      difficulty: json['difficulty'] ?? 'beginner',
      completionRate: json['completionRate'] ?? 0,
    );
  }

  // Helper methods
  Color get colorValue {
    try {
      return Color(int.parse(color.replaceFirst('#', '0xFF')));
    } catch (e) {
      return const Color(0xFF4CAF50); // Default green
    }
  }

  String get durationText {
    if (estimatedDuration < 60) {
      return '${estimatedDuration}m';
    } else {
      final hours = estimatedDuration ~/ 60;
      final minutes = estimatedDuration % 60;
      return minutes > 0 ? '${hours}h ${minutes}m' : '${hours}h';
    }
  }

  String get levelDisplay {
    switch (level) {
      case 'A1': return 'Beginner';
      case 'A2': return 'Elementary';
      case 'B1': return 'Intermediate';
      case 'B2': return 'Upper-Intermediate';
      case 'C1': return 'Advanced';
      case 'C2': return 'Proficient';
      default: return level;
    }
  }
}