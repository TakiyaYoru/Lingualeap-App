// lib/routes/app_router.dart - COMPLETE với Exercise Container
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

// Import các page
import '../pages/auth/login_page.dart';
import '../pages/auth/register_page.dart';
import '../pages/home_page.dart';
import '../pages/course/courses_page.dart';
import '../pages/course/course_detail_page.dart';
import '../pages/course/unit_detail_page.dart';
import '../pages/course/lesson_detail_page.dart';
import '../pages/exercise/exercise_container_page.dart'; // ← NEW
import '../pages/practice/practice_page.dart';
import '../pages/practice/vocabulary_page.dart';
import '../pages/profile_page.dart';
import '../pages/settings_page.dart';
import '../network/auth_service.dart';
import '../models/user_model.dart';
import '../widgets/main_layout.dart';

class AppRouter {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String courses = '/courses';
  static const String practice = '/practice';
  static const String vocabulary = '/vocabulary';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String courseDetail = '/course/:courseId';
  static const String unitDetail = '/unit/:unitId';
  static const String lessonDetail = '/lesson/:lessonId';
  static const String exerciseContainer = '/exercise/:lessonId'; // ← NEW
  
  static final GoRouter router = GoRouter(
    initialLocation: login,
    routes: [
      // Auth routes (no shell)
      GoRoute(
        path: login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterPage(),
      ),
      
      // Course detail route (no shell)
      GoRoute(
        path: courseDetail,
        builder: (context, state) {
          final courseId = state.pathParameters['courseId']!;
          return CourseDetailPage(courseId: courseId);
        },
      ),
      
      // Unit detail route (no shell)
      GoRoute(
        path: unitDetail,
        builder: (context, state) {
          final unitId = state.pathParameters['unitId']!;
          final unitTitle = state.uri.queryParameters['title'] ?? 'Unit';
          return UnitDetailPage(
            unitId: unitId,
            unitTitle: unitTitle,
          );
        },
      ),
      
      // Lesson detail route (no shell)
      GoRoute(
        path: lessonDetail,
        builder: (context, state) {
          final lessonId = state.pathParameters['lessonId']!;
          final lessonTitle = state.uri.queryParameters['title'] ?? 'Lesson';
          return LessonDetailPage(
            lessonId: lessonId,
            lessonTitle: lessonTitle,
          );
        },
      ),
      
      // Exercise container route (no shell) ← NEW
      GoRoute(
        path: exerciseContainer,
        builder: (context, state) {
          final lessonId = state.pathParameters['lessonId']!;
          
          // Get exercises from extra data
          final exercises = state.extra as List<Map<String, dynamic>>? ?? [];
          
          return ExerciseContainerPage(
            lessonId: lessonId,
            exercises: exercises,
          );
        },
      ),
      
      // Vocabulary route (no shell)
      GoRoute(
        path: vocabulary,
        builder: (context, state) => const VocabularyPage(),
      ),
      
      // Settings route (no shell)
      GoRoute(
        path: settings,
        builder: (context, state) => const SettingsPage(),
      ),
      
      // Main app with shell navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainLayout(navigationShell: navigationShell);
        },
        branches: [
          // Home branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: home,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          
          // Courses branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: courses,
                builder: (context, state) => const CoursesPage(),
              ),
            ],
          ),
          
          // Practice branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: practice,
                builder: (context, state) => const PracticePage(),
              ),
            ],
          ),
          
          // Profile branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: profile,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}