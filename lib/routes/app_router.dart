// lib/core/routes/app_router.dart
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

// Import các page
import '../../pages/auth/login_page.dart';
import '../../pages/auth/register_page.dart';
import '../../pages/home_page.dart';
import '../../pages/course/courses_page.dart';
import '../../pages/course/course_detail_page.dart';
import '../../pages/practice/practice_page.dart';
import '../../pages/profile_page.dart';
import '../../pages/settings_page.dart';
import '../network/auth_service.dart';
import '../network/course_service.dart';
import '../../models/user_model.dart';

class AppRouter {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String courses = '/courses';
  static const String practice = '/practice';
  static const String profile = '/profile';
  static const String courseDetail = '/course/:courseId';
  
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
      
      // Settings route (no shell)
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
      
      // Main app shell with bottom navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
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

// Custom scaffold with bottom navigation
class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: navigationShell.currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (int index) => _onTap(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Practice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

