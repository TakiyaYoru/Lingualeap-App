// lib/network/exercise_service.dart - FIXED
import 'api_service.dart';

class ExerciseService {
  // ===============================================
  // GET EXERCISES FOR LESSON
  // ===============================================
  static Future<List<Map<String, dynamic>>?> getLessonExercises(String lessonId) async {
    try {
      print('🎮 Fetching exercises for lesson: $lessonId');

      // For now, use sample data since backend integration is still in development
      print('⚠️ Using sample data for development - lesson: $lessonId');
      return _generateSampleExercisesData(lessonId);

      /* TODO: Uncomment when backend is ready
      final response = await ApiService.post('/graphql', {
        'query': '''
          query GetLessonExercises(\$lessonId: ID!) {
            lessonExercises(lessonId: \$lessonId) {
              id
              title
              instruction
              courseId
              unitId
              lessonId
              type
              question {
                text
                audioUrl
                imageUrl
                videoUrl
              }
              content
              maxScore
              difficulty
              xpReward
              timeLimit
              estimatedTime
              isPremium
              isActive
              sortOrder
              feedback {
                correct
                incorrect
                hint
              }
              tags
              createdAt
              updatedAt
            }
          }
        ''',
        'variables': {'lessonId': lessonId},
      });

      if (response != null && response['data']?['lessonExercises'] != null) {
        final exercises = List<Map<String, dynamic>>.from(response['data']['lessonExercises']);
        print('✅ Found ${exercises.length} exercises for lesson $lessonId');
        return exercises;
      }
      */

    } catch (e) {
      print('❌ Error fetching lesson exercises: $e');
      print('🎯 Fallback to sample data for development');
      return _generateSampleExercisesData(lessonId);
    }
  }

  // ===============================================
  // GET SINGLE EXERCISE
  // ===============================================
  static Future<Map<String, dynamic>?> getExercise(String exerciseId) async {
    try {
      print('🎮 Fetching exercise: $exerciseId');

      // For now, generate sample exercise data
      return _generateSampleExerciseData(exerciseId);

      /* TODO: Uncomment when backend is ready
      final response = await ApiService.post('/graphql', {
        'query': '''
          query GetExercise(\$id: ID!) {
            exercise(id: \$id) {
              id
              title
              instruction
              courseId
              unitId
              lessonId
              type
              question {
                text
                audioUrl
                imageUrl
                videoUrl
              }
              content
              maxScore
              difficulty
              xpReward
              timeLimit
              estimatedTime
              isPremium
              isActive
              sortOrder
              feedback {
                correct
                incorrect
                hint
              }
              tags
              createdAt
              updatedAt
            }
          }
        ''',
        'variables': {'id': exerciseId},
      });

      if (response != null && response['data']?['exercise'] != null) {
        print('✅ Exercise found: ${response['data']['exercise']['title']}');
        return Map<String, dynamic>.from(response['data']['exercise']);
      }
      */

    } catch (e) {
      print('❌ Error fetching exercise: $e');
      return _generateSampleExerciseData(exerciseId);
    }
  }

  // ===============================================
  // SAMPLE DATA GENERATION FOR DEVELOPMENT
  // ===============================================
  static List<Map<String, dynamic>> _generateSampleExercisesData(String lessonId) {
    print('📝 Generating sample exercises for lesson: $lessonId');
    
    return [
      // 1. Multiple Choice Exercise
      {
        'id': 'ex_${lessonId}_mc1',
        'title': 'Choose the Correct Greeting',
        'instruction': 'Select the correct English greeting for "Xin chào"',
        'lessonId': lessonId,
        'type': 'multiple_choice',
        'question': {
          'text': 'What is the English translation of "Xin chào"?',
          'audioUrl': null,
          'imageUrl': null,
          'videoUrl': null,
        },
        'content': {
          'options': ['Hello', 'Goodbye', 'Thank you', 'Sorry'],
          'correctAnswer': 'Hello',
          'explanation': '"Xin chào" means "Hello" in English.',
        },
        'maxScore': 100,
        'difficulty': 'easy',
        'xpReward': 10,
        'timeLimit': null,
        'estimatedTime': 30,
        'isPremium': false,
        'isActive': true,
        'sortOrder': 1,
        'feedback': {
          'correct': 'Perfect! "Xin chào" means "Hello"',
          'incorrect': 'Not quite right. "Xin chào" means "Hello"',
          'hint': 'Think about the most common greeting'
        },
        'tags': ['greeting', 'vocabulary', 'basic'],
        'isCompleted': false,
      },

      // 2. Fill in the Blank Exercise
      {
        'id': 'ex_${lessonId}_fb1',
        'title': 'Complete the Greeting',
        'instruction': 'Fill in the missing word',
        'lessonId': lessonId,
        'type': 'fill_blank',
        'question': {
          'text': 'Hello, my _____ is John.',
          'audioUrl': null,
          'imageUrl': null,
          'videoUrl': null,
        },
        'content': {
          'correctAnswers': ['name'],
          'caseSensitive': false,
          'acceptableAnswers': ['name'],
        },
        'maxScore': 100,
        'difficulty': 'easy',
        'xpReward': 15,
        'timeLimit': null,
        'estimatedTime': 45,
        'isPremium': false,
        'isActive': true,
        'sortOrder': 2,
        'feedback': {
          'correct': 'Excellent! "My name is..." is the correct pattern',
          'incorrect': 'Try again. Think about how you introduce yourself',
          'hint': 'What do you say when telling someone who you are?'
        },
        'tags': ['introduction', 'grammar', 'fill_blank'],
        'isCompleted': false,
      },

      // 3. Word Matching Exercise
      {
        'id': 'ex_${lessonId}_wm1',
        'title': 'Match Greetings',
        'instruction': 'Match the English words with their Vietnamese meanings',
        'lessonId': lessonId,
        'type': 'word_matching',
        'question': {
          'text': 'Match each English greeting with its Vietnamese translation',
          'audioUrl': null,
          'imageUrl': null,
          'videoUrl': null,
        },
        'content': {
          'pairs': [
            {'word': 'Hello', 'meaning': 'Xin chào'},
            {'word': 'Goodbye', 'meaning': 'Tạm biệt'},
            {'word': 'Good morning', 'meaning': 'Chào buổi sáng'},
            {'word': 'Good night', 'meaning': 'Chúc ngủ ngon'},
          ]
        },
        'maxScore': 100,
        'difficulty': 'medium',
        'xpReward': 20,
        'timeLimit': null,
        'estimatedTime': 90,
        'isPremium': false,
        'isActive': true,
        'sortOrder': 3,
        'feedback': {
          'correct': 'Great job matching the greetings!',
          'incorrect': 'Some matches are incorrect. Try again!',
          'hint': 'Think about when you would use each greeting'
        },
        'tags': ['matching', 'vocabulary', 'greetings'],
        'isCompleted': false,
      },

      // 4. Translation Exercise
      {
        'id': 'ex_${lessonId}_tr1',
        'title': 'Translate the Greeting',
        'instruction': 'Translate this Vietnamese sentence to English',
        'lessonId': lessonId,
        'type': 'translation',
        'question': {
          'text': 'Xin chào, tôi là Mary. Rất vui được gặp bạn.',
          'audioUrl': null,
          'imageUrl': null,
          'videoUrl': null,
        },
        'content': {
          'correctAnswers': [
            'Hello, I am Mary. Nice to meet you.',
            'Hi, I am Mary. Nice to meet you.',
            'Hello, I\'m Mary. Nice to meet you.',
            'Hi, I\'m Mary. Nice to meet you.',
          ],
          'fromLanguage': 'vi',
          'toLanguage': 'en',
          'keyPhrases': ['Hello/Hi', 'I am/I\'m Mary', 'Nice to meet you'],
        },
        'maxScore': 100,
        'difficulty': 'medium',
        'xpReward': 25,
        'timeLimit': null,
        'estimatedTime': 120,
        'isPremium': false,
        'isActive': true,
        'sortOrder': 4,
        'feedback': {
          'correct': 'Perfect translation! You got all the key phrases right.',
          'incorrect': 'Good try! Check the key phrases and try again.',
          'hint': 'Remember: "tôi là" = "I am", "rất vui được gặp" = "nice to meet"'
        },
        'tags': ['translation', 'sentence', 'introduction'],
        'isCompleted': false,
      },

      // 5. True/False Exercise
      {
        'id': 'ex_${lessonId}_tf1',
        'title': 'True or False: Greetings',
        'instruction': 'Decide if the statement is true or false',
        'lessonId': lessonId,
        'type': 'true_false',
        'question': {
          'text': '"Good morning" is used to say hello in the afternoon.',
          'audioUrl': null,
          'imageUrl': null,
          'videoUrl': null,
        },
        'content': {
          'correctAnswer': false,
          'explanation': '"Good morning" is used in the morning, not afternoon. Use "Good afternoon" for afternoon greetings.',
        },
        'maxScore': 100,
        'difficulty': 'easy',
        'xpReward': 12,
        'timeLimit': null,
        'estimatedTime': 20,
        'isPremium': false,
        'isActive': true,
        'sortOrder': 5,
        'feedback': {
          'correct': 'Correct! "Good morning" is only for morning time.',
          'incorrect': 'False! "Good morning" is used in the morning, not afternoon.',
          'hint': 'Think about what time of day each greeting is used'
        },
        'tags': ['true_false', 'time', 'greetings'],
        'isCompleted': false,
      },

      // 6. Sentence Building Exercise
      {
        'id': 'ex_${lessonId}_sb1',
        'title': 'Build a Greeting Sentence',
        'instruction': 'Arrange the words to make a correct sentence',
        'lessonId': lessonId,
        'type': 'sentence_building',
        'question': {
          'text': 'Arrange these words to make: "Hello, my name is Sarah"',
          'audioUrl': null,
          'imageUrl': null,
          'videoUrl': null,
        },
        'content': {
          'targetSentence': 'Hello, my name is Sarah',
          'words': ['is', 'Hello,', 'Sarah', 'name', 'my'],
          'translation': 'Xin chào, tên tôi là Sarah',
        },
        'maxScore': 100,
        'difficulty': 'medium',
        'xpReward': 18,
        'timeLimit': null,
        'estimatedTime': 60,
        'isPremium': false,
        'isActive': true,
        'sortOrder': 6,
        'feedback': {
          'correct': 'Perfect sentence! You arranged the words correctly.',
          'incorrect': 'Not quite right. Try again with the word order.',
          'hint': 'Start with the greeting, then "my name is..."'
        },
        'tags': ['sentence_building', 'grammar', 'word_order'],
        'isCompleted': false,
      },

      // 7. Listening Exercise
      {
        'id': 'ex_${lessonId}_ls1',
        'title': 'Listen and Choose',
        'instruction': 'Listen to the audio and choose what you hear',
        'lessonId': lessonId,
        'type': 'listening',
        'question': {
          'text': 'Listen to the greeting and choose the correct option',
          'audioUrl': 'https://example.com/audio/hello.mp3', // Would be real URL in production
          'imageUrl': null,
          'videoUrl': null,
        },
        'content': {
          'options': ['Hello', 'Help', 'Hill', 'Hall'],
          'correctAnswer': 'Hello',
          'transcript': 'Hello',
        },
        'maxScore': 100,
        'difficulty': 'medium',
        'xpReward': 22,
        'timeLimit': null,
        'estimatedTime': 45,
        'isPremium': false,
        'isActive': true,
        'sortOrder': 7,
        'feedback': {
          'correct': 'Great listening! You heard "Hello" correctly.',
          'incorrect': 'Listen again carefully. The word is "Hello".',
          'hint': 'This is a common greeting word'
        },
        'tags': ['listening', 'pronunciation', 'audio'],
        'isCompleted': false,
      },
    ];
  }

  static Map<String, dynamic> _generateSampleExerciseData(String exerciseId) {
    print('📝 Generating sample exercise data for: $exerciseId');
    
    // Extract lesson ID from exercise ID pattern
    final lessonId = exerciseId.contains('_') ? exerciseId.split('_')[1] : 'unknown';
    
    return {
      'id': exerciseId,
      'title': 'Sample Exercise',
      'instruction': 'This is a sample exercise for development',
      'lessonId': lessonId,
      'type': 'multiple_choice',
      'question': {
        'text': 'Sample question for testing',
        'audioUrl': null,
        'imageUrl': null,
        'videoUrl': null,
      },
      'content': {
        'options': ['Option A', 'Option B', 'Option C', 'Option D'],
        'correctAnswer': 'Option A',
      },
      'maxScore': 100,
      'difficulty': 'easy',
      'xpReward': 10,
      'timeLimit': null,
      'estimatedTime': 60,
      'isPremium': false,
      'isActive': true,
      'sortOrder': 1,
      'feedback': {
        'correct': 'Correct!',
        'incorrect': 'Try again!',
        'hint': 'This is a sample hint'
      },
      'tags': ['sample'],
      'isCompleted': false,
    };
  }

  // ===============================================
  // GET EXERCISES BY TYPE (for Practice Mode)
  // ===============================================
  static Future<List<Map<String, dynamic>>?> getExercisesByType(
    String exerciseType, {
    int limit = 10,
  }) async {
    try {
      print('🎮 Fetching $exerciseType exercises (limit: $limit)');
      
      // For development, return sample data
      await Future.delayed(const Duration(milliseconds: 300));
      return _generateExercisesByType(exerciseType, limit);
    } catch (e) {
      print('❌ Error fetching exercises by type: $e');
      return null;
    }
  }

  static List<Map<String, dynamic>> _generateExercisesByType(String type, int count) {
    final List<Map<String, dynamic>> exercises = [];
    
    for (int i = 1; i <= count; i++) {
      exercises.add(_createSampleExerciseByType(type, i));
    }
    
    return exercises;
  }

  static Map<String, dynamic> _createSampleExerciseByType(String type, int index) {
    final baseId = '${type}_sample_$index';
    
    switch (type) {
      case 'multiple_choice':
        return {
          'id': baseId,
          'title': 'Multiple Choice #$index',
          'instruction': 'Choose the correct answer',
          'type': 'multiple_choice',
          'question': {'text': 'Sample multiple choice question $index'},
          'content': {
            'options': ['Option A', 'Option B', 'Option C', 'Option D'],
            'correctAnswer': 'Option A',
          },
          'difficulty': 'easy',
          'xpReward': 10,
          'estimatedTime': 30,
          'isCompleted': false,
        };
      
      case 'fill_blank':
        return {
          'id': baseId,
          'title': 'Fill in the Blank #$index',
          'instruction': 'Complete the sentence',
          'type': 'fill_blank',
          'question': {'text': 'This is a _____ sentence.'},
          'content': {
            'correctAnswers': ['sample'],
            'caseSensitive': false,
          },
          'difficulty': 'easy',
          'xpReward': 15,
          'estimatedTime': 45,
          'isCompleted': false,
        };
      
      case 'word_matching':
        return {
          'id': baseId,
          'title': 'Word Matching #$index',
          'instruction': 'Match words with their meanings',
          'type': 'word_matching',
          'question': {'text': 'Match the words'},
          'content': {
            'pairs': [
              {'word': 'Hello', 'meaning': 'Xin chào'},
              {'word': 'Goodbye', 'meaning': 'Tạm biệt'},
            ]
          },
          'difficulty': 'medium',
          'xpReward': 20,
          'estimatedTime': 60,
          'isCompleted': false,
        };
      
      default:
        return {
          'id': baseId,
          'title': '${_toTitleCase(type.replaceAll('_', ' '))} #$index',
          'instruction': 'Complete this exercise',
          'type': type,
          'question': {'text': 'Sample $type question $index'},
          'content': {},
          'difficulty': 'easy',
          'xpReward': 10,
          'estimatedTime': 60,
          'isCompleted': false,
        };
    }
  }

  // ===============================================
  // UTILITY METHODS
  // ===============================================
  static String _toTitleCase(String text) {
    return text.split(' ').map((word) => 
      word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}' : ''
    ).join(' ');
  }

  static Future<void> delay({int milliseconds = 500}) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }
}