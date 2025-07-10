// lib/pages/course/unit_detail_page.dart - FIXED COMPLETE
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../network/lesson_service.dart';

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

class _UnitDetailPageState extends State<UnitDetailPage> with WidgetsBindingObserver {
  List<Map<String, dynamic>> lessons = [];
  bool isLoading = true;
  String errorMessage = '';
  bool _isNavigating = false; // Prevent multiple navigation
  bool _isDisposed = false;
  bool _isInactive = false;
  DateTime? _lastNavigationTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadLessons();
  }

  @override
  void dispose() {
    _isDisposed = true;
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _isInactive = state != AppLifecycleState.resumed;
  }

  bool _canNavigate() {
    if (_isDisposed || _isNavigating || _isInactive || !mounted) return false;
    
    final now = DateTime.now();
    if (_lastNavigationTime != null) {
      final difference = now.difference(_lastNavigationTime!);
      if (difference.inMilliseconds < 500) {
        return false; // Debounce navigation
      }
    }
    
    return true;
  }

  Future<void> _loadLessons() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      print('🔥 Loading lessons for unit: ${widget.unitId}');

      // Call real backend API to get lessons for this unit
      final lessonsData = await LessonService.getUnitLessons(widget.unitId);
      
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
      setState(() {
        errorMessage = 'Error loading lessons: $e';
        isLoading = false;
      });
      print('❌ Error loading lessons: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !_isNavigating; // Allow back navigation only if not currently navigating
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(widget.unitTitle),
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: _isNavigating ? null : () async {
              if (!_canNavigate()) return;
              
              setState(() {
                _isNavigating = true;
                _lastNavigationTime = DateTime.now();
              });
              
              try {
                await Future.delayed(const Duration(milliseconds: 100));
                
                if (mounted && !_isDisposed && !_isInactive) {
                  Navigator.of(context).pop();
                }
              } finally {
                await Future.delayed(const Duration(milliseconds: 150));
                
                if (mounted && !_isDisposed) {
                  setState(() {
                    _isNavigating = false;
                  });
                }
              }
            },
          ),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
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

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        final lesson = lessons[index];
        return _buildLessonCard(lesson, index);
      },
    );
  }

  Widget _buildLessonCard(Map<String, dynamic> lesson, int index) {
    final bool isUnlocked = lesson['isUnlocked'] ?? lesson['unlockRequirements'] == null;
    final bool isCompleted = lesson['isCompleted'] ?? false;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: isUnlocked 
            ? Theme.of(context).colorScheme.surface
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        elevation: isUnlocked ? 2 : 0,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: isUnlocked ? () => _onLessonTap(lesson) : null,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Lesson Number Circle
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _getLessonStatusColor(isUnlocked, isCompleted),
                  ),
                  child: Center(
                    child: _getLessonStatusIcon(isUnlocked, isCompleted, index + 1),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Lesson Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson['title'] ?? '',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isUnlocked 
                              ? Theme.of(context).colorScheme.onSurface
                              : Colors.grey.shade500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        lesson['description'] ?? lesson['objective'] ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          color: isUnlocked 
                              ? Colors.grey.shade600
                              : Colors.grey.shade400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // XP Reward
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '+${lesson['xpReward'] ?? 0} XP',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.quiz_outlined,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${lesson['totalExercises'] ?? 0} exercises',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${lesson['estimatedDuration'] ?? 0}m',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      // Difficulty badge
                      if (lesson['difficulty'] != null) ...[
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getDifficultyColor(lesson['difficulty']).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            lesson['difficulty'].toString().toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getDifficultyColor(lesson['difficulty']),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                
                // Arrow Icon or Lock Icon
                if (isUnlocked)
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey.shade400,
                  )
                else
                  Icon(
                    Icons.lock_outline,
                    size: 20,
                    color: Colors.grey.shade400,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getLessonStatusColor(bool isUnlocked, bool isCompleted) {
    if (isCompleted) {
      return Theme.of(context).primaryColor;
    } else if (isUnlocked) {
      return Theme.of(context).primaryColor.withOpacity(0.1);
    } else {
      return Colors.grey.shade300;
    }
  }

  Widget _getLessonStatusIcon(bool isUnlocked, bool isCompleted, int lessonNumber) {
    if (isCompleted) {
      return const Icon(
        Icons.check,
        color: Colors.white,
        size: 24,
      );
    } else if (isUnlocked) {
      return Text(
        lessonNumber.toString(),
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      );
    } else {
      return Icon(
        Icons.lock,
        color: Colors.grey.shade500,
        size: 20,
      );
    }
  }

  void _onLessonTap(Map<String, dynamic> lesson) async {
    if (!_canNavigate()) return;
    
    final lessonId = lesson['id'] ?? '';
    final lessonTitle = lesson['title'] ?? 'Lesson';
    
    if (lessonId.isNotEmpty) {
      setState(() {
        _isNavigating = true;
        _lastNavigationTime = DateTime.now();
      });
      
      try {
        print('🎯 Navigating to lesson: $lessonTitle (ID: $lessonId)');
        
        await Future.delayed(const Duration(milliseconds: 100));
        
        if (_canNavigate()) {
          // Navigate to LessonDetailPage
          await context.push('/lesson/$lessonId?title=${Uri.encodeComponent(lessonTitle)}');
        }
      } catch (e) {
        print('❌ Navigation error: $e');
        if (mounted && !_isDisposed && !_isInactive) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Navigation error: $e'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } finally {
        await Future.delayed(const Duration(milliseconds: 150));
        
        if (mounted && !_isDisposed) {
          setState(() {
            _isNavigating = false;
          });
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lesson ID not found'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _showLessonPreview(Map<String, dynamic> lesson) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      lesson['title'] ?? 'Lesson',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Description
                    Text(
                      lesson['description'] ?? lesson['objective'] ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Stats
                    Row(
                      children: [
                        _buildStatChip(
                          Icons.quiz,
                          '${lesson['totalExercises'] ?? 0} Exercises',
                          Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 12),
                        _buildStatChip(
                          Icons.access_time,
                          '${lesson['estimatedDuration'] ?? 0} min',
                          Colors.orange,
                        ),
                        const SizedBox(width: 12),
                        _buildStatChip(
                          Icons.star,
                          '+${lesson['xpReward'] ?? 0} XP',
                          Colors.amber,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    // Difficulty
                    if (lesson['difficulty'] != null) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.trending_up,
                            color: _getDifficultyColor(lesson['difficulty']),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Difficulty: ${lesson['difficulty'].toString().toUpperCase()}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _getDifficultyColor(lesson['difficulty']),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                    
                    const Spacer(),
                    
                    // Start button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _onLessonTap(lesson);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Start Lesson',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}