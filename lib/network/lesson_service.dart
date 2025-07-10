// lib/network/lesson_service.dart - FIXED
import 'api_service.dart';

class LessonService {
  // ===============================================
  // GET LESSONS FOR UNIT
  // ===============================================
  static Future<List<Map<String, dynamic>>?> getUnitLessons(String unitId) async {
    try {
      print('🔥 Fetching lessons for unit: $unitId');

      // For now, use sample data since backend integration is still in development
      print('⚠️ Using sample data for development - unit: $unitId');
      return _generateSampleLessonsData(unitId);

      /* TODO: Uncomment when backend is ready
      final response = await ApiService.post('/graphql', {
        'query': '''
          query GetUnitLessons(\$unitId: ID!) {
            unitLessons(unitId: \$unitId) {
              id
              title
              description
              unitId
              courseId
              objective
              estimatedDuration
              totalExercises
              difficulty
              xpReward
              isPremium
              isPublished
              sortOrder
              unlockRequirements {
                previousLessonId
                minimumScore
              }
              createdAt
              updatedAt
            }
          }
        ''',
        'variables': {'unitId': unitId},
      });

      if (response != null && response['data']?['unitLessons'] != null) {
        final lessons = List<Map<String, dynamic>>.from(response['data']['unitLessons']);
        print('✅ Found ${lessons.length} lessons for unit $unitId');
        return lessons;
      }
      */

    } catch (e) {
      print('❌ Error fetching unit lessons: $e');
      print('🎯 Fallback to sample data for development');
      return _generateSampleLessonsData(unitId);
    }
  }

  // ===============================================
  // GET SINGLE LESSON
  // ===============================================
  static Future<Map<String, dynamic>?> getLesson(String lessonId) async {
    try {
      print('🔥 Fetching lesson: $lessonId');

      // For now, generate sample lesson data
      return _generateSampleLessonData(lessonId);

      /* TODO: Uncomment when backend is ready
      final response = await ApiService.post('/graphql', {
        'query': '''
          query GetLesson(\$id: ID!) {
            lesson(id: \$id) {
              id
              title
              description
              unitId
              courseId
              objective
              estimatedDuration
              totalExercises
              difficulty
              xpReward
              isPremium
              isPublished
              sortOrder
              unlockRequirements {
                previousLessonId
                minimumScore
              }
              createdAt
              updatedAt
            }
          }
        ''',
        'variables': {'id': lessonId},
      });

      if (response != null && response['data']?['lesson'] != null) {
        print('✅ Lesson found: ${response['data']['lesson']['title']}');
        return Map<String, dynamic>.from(response['data']['lesson']);
      }
      */

    } catch (e) {
      print('❌ Error fetching lesson: $e');
      return _generateSampleLessonData(lessonId);
    }
  }

  // ===============================================
  // SAMPLE DATA FOR DEVELOPMENT
  // ===============================================
  static List<Map<String, dynamic>> _generateSampleLessonsData(String unitId) {
    print('📝 Generating sample lessons data for unit: $unitId');
    
    return [
      {
        'id': 'lesson_${unitId}_1',
        'title': 'Basic Greetings',
        'description': 'Learn how to say hello and goodbye in English',
        'unitId': unitId,
        'objective': 'Master basic greeting phrases',
        'estimatedDuration': 15,
        'totalExercises': 7,
        'difficulty': 'easy',
        'xpReward': 50,
        'isPremium': false,
        'isPublished': true,
        'sortOrder': 1,
        'isCompleted': false,
        'isUnlocked': true,
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      },
      {
        'id': 'lesson_${unitId}_2',
        'title': 'Introducing Yourself',
        'description': 'Learn to introduce yourself and ask about others',
        'unitId': unitId,
        'objective': 'Be able to make basic introductions',
        'estimatedDuration': 20,
        'totalExercises': 8,
        'difficulty': 'easy',
        'xpReward': 75,
        'isPremium': false,
        'isPublished': true,
        'sortOrder': 2,
        'isCompleted': false,
        'isUnlocked': true,
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      },
      {
        'id': 'lesson_${unitId}_3',
        'title': 'Common Phrases',
        'description': 'Essential phrases for daily conversation',
        'unitId': unitId,
        'objective': 'Use common phrases in conversation',
        'estimatedDuration': 25,
        'totalExercises': 9,
        'difficulty': 'medium',
        'xpReward': 100,
        'isPremium': false,
        'isPublished': true,
        'sortOrder': 3,
        'isCompleted': false,
        'isUnlocked': false, // Locked until previous lesson completed
        'unlockRequirements': {
          'previousLessonId': 'lesson_${unitId}_2',
          'minimumScore': 80,
        },
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      },
      {
        'id': 'lesson_${unitId}_4',
        'title': 'Numbers and Counting',
        'description': 'Learn numbers from 1 to 100',
        'unitId': unitId,
        'objective': 'Count and use numbers in context',
        'estimatedDuration': 18,
        'totalExercises': 6,
        'difficulty': 'easy',
        'xpReward': 60,
        'isPremium': false,
        'isPublished': true,
        'sortOrder': 4,
        'isCompleted': false,
        'isUnlocked': false,
        'unlockRequirements': {
          'previousLessonId': 'lesson_${unitId}_3',
          'minimumScore': 75,
        },
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      },
      {
        'id': 'lesson_${unitId}_5',
        'title': 'Colors and Shapes',
        'description': 'Learn basic colors and shapes vocabulary',
        'unitId': unitId,
        'objective': 'Identify and name colors and shapes',
        'estimatedDuration': 22,
        'totalExercises': 8,
        'difficulty': 'easy',
        'xpReward': 80,
        'isPremium': false,
        'isPublished': true,
        'sortOrder': 5,
        'isCompleted': false,
        'isUnlocked': false,
        'unlockRequirements': {
          'previousLessonId': 'lesson_${unitId}_4',
          'minimumScore': 70,
        },
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      },
    ];
  }

  static Map<String, dynamic> _generateSampleLessonData(String lessonId) {
    print('📝 Generating sample lesson data for: $lessonId');
    
    // Extract unit ID from lesson ID pattern
    final unitId = lessonId.contains('_') ? lessonId.split('_')[1] : 'unknown';
    
    return {
      'id': lessonId,
      'title': 'Sample Lesson',
      'description': 'This is a sample lesson for development purposes',
      'unitId': unitId,
      'courseId': 'course_1',
      'objective': 'Learn sample content for testing',
      'estimatedDuration': 20,
      'totalExercises': 7,
      'difficulty': 'easy',
      'xpReward': 75,
      'isPremium': false,
      'isPublished': true,
      'sortOrder': 1,
      'isCompleted': false,
      'isUnlocked': true,
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    };
  }

  // ===============================================
  // CHECK LESSON UNLOCK STATUS
  // ===============================================
  static bool isLessonUnlocked(
    Map<String, dynamic> lesson,
    List<Map<String, dynamic>> completedLessons,
  ) {
    // If no unlock requirements, it's unlocked
    if (lesson['unlockRequirements'] == null) {
      return true;
    }

    final requirements = lesson['unlockRequirements'];
    final previousLessonId = requirements['previousLessonId'];
    final minimumScore = requirements['minimumScore'] ?? 0;

    // Check if previous lesson is completed with minimum score
    if (previousLessonId != null) {
      final previousLesson = completedLessons.firstWhere(
        (completed) => completed['lessonId'] == previousLessonId,
        orElse: () => {},
      );

      if (previousLesson.isEmpty) {
        return false; // Previous lesson not completed
      }

      final score = previousLesson['bestScore'] ?? 0;
      return score >= minimumScore;
    }

    return true;
  }

  // ===============================================
  // UTILITY METHODS
  // ===============================================
  static Future<void> delay({int milliseconds = 500}) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }
}