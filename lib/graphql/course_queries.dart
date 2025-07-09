// lib/core/graphql/course_queries.dart

class CourseQueries {
  // Get all courses
  static const String getAllCourses = '''
    query GetAllCourses {
      courses {
        id
        title
        description
        level
        category
        thumbnail
        color
        estimatedDuration
        totalUnits
        totalLessons
        totalExercises
        isPremium
        isPublished
        learningObjectives
        prerequisites
        difficulty
        completionRate
      }
    }
  ''';

  // Get single course by ID
  static const String getCourse = '''
    query GetCourse(\$id: ID!) {
      course(id: \$id) {
        id
        title
        description
        level
        category
        thumbnail
        color
        estimatedDuration
        totalUnits
        totalLessons
        totalExercises
        isPremium
        isPublished
        learningObjectives
        prerequisites
        difficulty
        completionRate
      }
    }
  ''';

  // Get course units
  static const String getCourseUnits = '''
    query GetCourseUnits(\$courseId: ID!) {
      courseUnits(courseId: \$courseId) {
        id
        title
        description
        theme
        icon
        color
        totalLessons
        totalExercises
        estimatedDuration
        isPremium
        isPublished
      }
    }
  ''';

  // Get unit lessons
  static const String getUnitLessons = '''
    query GetUnitLessons(\$unitId: ID!) {
      unitLessons(unitId: \$unitId) {
        id
        title
        description
        type
        estimatedDuration
        vocabularyCount
        grammarPointsCount
        isPremium
        isPublished
      }
    }
  ''';
}