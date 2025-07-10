// lib/pages/course/unit_detail_page.dart - BULLETPROOF VERSION
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../network/lesson_service.dart';
import '../../utils/safe_navigator.dart'; // Import our safe navigator

class UnitDetailPage extends StatefulWidget {
  final String unitId;
  final String unitTitle;
  
  const UnitDetailPage({
    super.key,
    required this.unitId,
    required this.unitTitle,
  });

  @override
  State<UnitDetailPage> createState() => _UnitDetailPageState();
}

class _UnitDetailPageState extends State<UnitDetailPage> {
  List<Map<String, dynamic>> lessons = [];
  bool isLoading = true;
  String errorMessage = '';
  
  // 🔥 SIMPLIFIED: Remove complex navigation state
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _loadLessons();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  // 🔥 BULLETPROOF: Handle lesson tap with SafeNavigator
  Future<void> _handleLessonTap(Map<String, dynamic> lesson) async {
    final lessonId = lesson['id'] ?? '';
    final lessonTitle = lesson['title'] ?? 'Lesson';
    
    if (lessonId.isEmpty) {
      _showError('Lesson ID not found');
      return;
    }

    final route = '/lesson/$lessonId?title=${Uri.encodeComponent(lessonTitle)}';
    await SafeNavigator.safePush(
      context, 
      route,
      debugName: 'lesson_$lessonId',
    );
  }

  // 🔥 BULLETPROOF: Handle back navigation
  Future<void> _handleBackTap() async {
    // Try GoRouter first, then Navigator
    if (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    } else if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      // Last resort: go to courses page
      context.go('/courses');
    }
  }

  void _showError(String message) {
    if (!mounted || _isDisposed) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _loadLessons() async {
    try {
      if (!mounted) return;
      
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      print('🔥 Loading lessons for unit: ${widget.unitId}');

      final lessonsData = await LessonService.getUnitLessons(widget.unitId);
      
      if (!mounted || _isDisposed) return;
      
      if (lessonsData != null) {
        setState(() {
          lessons = lessonsData;
          isLoading = false;
        });
        print('✅ Loaded ${lessons.length} lessons for unit ${widget.unitId}');
      } else {
        setState(() {
          errorMessage = 'Failed to load lessons';
          isLoading = false;
        });
        print('❌ Failed to load lessons for unit ${widget.unitId}');
      }
    } catch (e) {
      if (!mounted || _isDisposed) return;
      
      setState(() {
        errorMessage = 'Error loading lessons: $e';
        isLoading = false;
      });
      print('❌ Error loading lessons: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(widget.unitTitle),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        // 🔥 BULLETPROOF: Safe back button with SafeTapWidget
        leading: SafeTapWidget(
          onTap: _handleBackTap,
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              errorMessage,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadLessons,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUnitHeader(),
          const SizedBox(height: 24),
          _buildLessonsSection(),
        ],
      ),
    );
  }

  Widget _buildUnitHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.unitTitle,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Complete ${lessons.length} lessons to master this unit',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lessons (${lessons.length})',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        
        if (lessons.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Text(
                'No lessons available yet',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: lessons.length,
            itemBuilder: (context, index) => _buildLessonCard(lessons[index], index),
          ),
      ],
    );
  }

  Widget _buildLessonCard(Map<String, dynamic> lesson, int index) {
    final type = lesson['type'] ?? 'lesson';
    final isUnlocked = lesson['isUnlocked'] ?? (index == 0);
    final isCompleted = lesson['isCompleted'] ?? false;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: SafeTapWidget(
        // 🔥 BULLETPROOF: Safe tap with built-in debouncing
        onTap: isUnlocked ? () => _handleLessonTap(lesson) : null,
        enabled: isUnlocked,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isUnlocked 
              ? (isCompleted ? Colors.green.shade50 : Theme.of(context).colorScheme.surface)
              : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isCompleted 
                ? Colors.green.shade300
                : (isUnlocked 
                    ? Theme.of(context).primaryColor.withOpacity(0.3)
                    : Colors.grey.shade300),
            ),
          ),
          child: Row(
            children: [
              // Lesson Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: _getLessonColor(type, isUnlocked, isCompleted),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  _getLessonIcon(type, isCompleted),
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              
              // Lesson Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            lesson['title'] ?? 'Lesson ${index + 1}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isUnlocked ? null : Colors.grey.shade600,
                            ),
                          ),
                        ),
                        if (isCompleted)
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 20,
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lesson['description'] ?? 'Complete this lesson to continue',
                      style: TextStyle(
                        fontSize: 14,
                        color: isUnlocked 
                          ? Colors.grey.shade600 
                          : Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.quiz_outlined,
                          size: 16,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${lesson['totalExercises'] ?? 0} exercises',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.access_time_outlined,
                          size: 16,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${lesson['estimatedDuration'] ?? 5} min',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.star_outline,
                          size: 16,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '+${lesson['xpReward'] ?? 0} XP',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Status Icon
              const SizedBox(width: 8),
              Icon(
                isCompleted 
                  ? Icons.check_circle
                  : (isUnlocked ? Icons.play_circle_fill : Icons.lock),
                color: isCompleted 
                  ? Colors.green
                  : (isUnlocked 
                      ? Theme.of(context).primaryColor 
                      : Colors.grey.shade400),
                size: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getLessonColor(String type, bool isUnlocked, bool isCompleted) {
    if (!isUnlocked) return Colors.grey.shade400;
    if (isCompleted) return Colors.green;
    
    switch (type.toLowerCase()) {
      case 'vocabulary':
        return Colors.blue;
      case 'grammar':
        return Colors.purple;
      case 'conversation':
        return Colors.orange;
      case 'listening':
        return Colors.teal;
      case 'reading':
        return Colors.indigo;
      default:
        return Theme.of(context).primaryColor;
    }
  }

  IconData _getLessonIcon(String type, bool isCompleted) {
    if (isCompleted) return Icons.check;
    
    switch (type.toLowerCase()) {
      case 'vocabulary':
        return Icons.book;
      case 'grammar':
        return Icons.edit;
      case 'conversation':
        return Icons.chat;
      case 'listening':
        return Icons.headphones;
      case 'reading':
        return Icons.article;
      default:
        return Icons.school;
    }
  }
}