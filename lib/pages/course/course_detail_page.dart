// lib/pages/course/course_detail_page.dart - CLEAN FIXED VERSION
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../network/course_service.dart';
import '../../models/course_model.dart';

class CourseDetailPage extends StatefulWidget {
  final String courseId;
  
  const CourseDetailPage({
    super.key,
    required this.courseId,
  });

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> with WidgetsBindingObserver {
  CourseModel? course;
  List<Map<String, dynamic>> units = [];
  bool isLoading = true;
  String errorMessage = '';
  bool _isNavigating = false;
  bool _isDisposed = false;
  bool _isInactive = false;
  DateTime? _lastNavigationTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadCourseDetail();
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
        return false;
      }
    }
    
    return true;
  }

  Future<void> _loadCourseDetail() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      // Load course info
      final courseData = await CourseService.getCourse(widget.courseId);
      if (courseData == null) {
        setState(() {
          errorMessage = 'Course not found';
          isLoading = false;
        });
        return;
      }

      // Load course units
      final unitsData = await CourseService.getCourseUnits(widget.courseId);
      
      setState(() {
        course = CourseModel.fromJson(courseData);
        units = unitsData ?? [];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading course: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !_isNavigating;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(course?.title ?? 'Course'),
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
              onPressed: _loadCourseDetail,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (course == null) {
      return const Center(child: Text('Course not found'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course header
          _buildCourseHeader(),
          const SizedBox(height: 24),
          
          // Course description
          _buildSection(
            Icons.description,
            'Description',
            Text(
              course!.description,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
          const SizedBox(height: 24),
          
          // Learning objectives
          if (course!.learningObjectives.isNotEmpty) ...[
            _buildSection(
              Icons.check_circle_outline,
              'What you\'ll learn',
              Column(
                children: course!.learningObjectives
                    .map((objective) => _buildObjectiveItem(objective))
                    .toList(),
              ),
            ),
            const SizedBox(height: 24),
          ],
          
          // Course units
          _buildSection(
            Icons.folder_outlined,
            'Course Units (${units.length})',
            Column(
              children: units.map((unit) => _buildUnitCard(unit)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseHeader() {
    return Row(
      children: [
        // Course icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: course!.colorValue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            Icons.school,
            color: course!.colorValue,
            size: 40,
          ),
        ),
        const SizedBox(width: 16),
        
        // Course info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                course!.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              
              // Stats row
              Row(
                children: [
                  // Level badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: course!.colorValue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      course!.level.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: course!.colorValue,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Duration
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${course!.estimatedDuration}m',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection(IconData icon, String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: course!.colorValue),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        content,
      ],
    );
  }

  Widget _buildObjectiveItem(String objective) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: course!.colorValue,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              objective,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitCard(Map<String, dynamic> unit) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        elevation: 1,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: (!_isNavigating) ? () => _onUnitTap(unit) : null,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Unit icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: course!.colorValue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.folder_outlined,
                    color: course!.colorValue,
                  ),
                ),
                const SizedBox(width: 16),
                
                // Unit info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        unit['title'] ?? 'Unit',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        unit['description'] ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '${unit['totalLessons'] ?? 0} lessons',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            '${unit['estimatedDuration'] ?? 0}m',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Arrow icon
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onUnitTap(Map<String, dynamic> unit) async {
    if (!_canNavigate()) return;
    
    final unitId = unit['id'] ?? '';
    final unitTitle = unit['title'] ?? 'Unit';
    
    if (unitId.isNotEmpty) {
      setState(() {
        _isNavigating = true;
        _lastNavigationTime = DateTime.now();
      });
      
      try {
        await Future.delayed(const Duration(milliseconds: 100));
        
        if (_canNavigate()) {
          // Navigate to UnitDetailPage với query parameters
          await context.push('/unit/$unitId?title=${Uri.encodeComponent(unitTitle)}');
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
      // Show error if no unit ID
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unit ID not found'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}