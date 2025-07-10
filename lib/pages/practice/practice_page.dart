// lib/pages/practice/practice_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PracticePage extends StatelessWidget {
  const PracticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Practice Hub'),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.fitness_center,
                    size: 40,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Practice Hub',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Strengthen your English skills with targeted practice',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),

            // 🗣️ Luyện giao tiếp
            _buildSectionHeader(
              context,
              icon: Icons.chat_bubble_outline,
              title: 'Luyện giao tiếp',
              color: Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildPracticeCard(
              context,
              title: 'Speaking Practice',
              subtitle: 'Practice conversations and pronunciation',
              icon: Icons.mic,
              color: Colors.blue,
              isComingSoon: true,
              onTap: () {
                // Coming soon
                _showComingSoon(context, 'Speaking Practice');
              },
            ),
            
            const SizedBox(height: 24),

            // 🎯 Luyện kỹ năng
            _buildSectionHeader(
              context,
              icon: Icons.trending_up,
              title: 'Luyện kỹ năng',
              color: Colors.orange,
            ),
            const SizedBox(height: 12),
            Column(
              children: [
                _buildPracticeCard(
                  context,
                  title: 'Các lỗi sai cũ',
                  subtitle: 'Review your past mistakes',
                  icon: Icons.error_outline,
                  color: Colors.red,
                  isComingSoon: true,
                  onTap: () => _showComingSoon(context, 'Mistake Review'),
                ),
                const SizedBox(height: 12),
                _buildPracticeCard(
                  context,
                  title: 'Luyện nghe',
                  subtitle: 'Improve your listening skills',
                  icon: Icons.headphones,
                  color: Colors.purple,
                  isComingSoon: true,
                  onTap: () => _showComingSoon(context, 'Listening Practice'),
                ),
                const SizedBox(height: 12),
                _buildPracticeCard(
                  context,
                  title: 'Luyện đọc',
                  subtitle: 'Enhance your reading comprehension',
                  icon: Icons.menu_book,
                  color: Colors.teal,
                  isComingSoon: true,
                  onTap: () {context.push('/reading-practice');},
                ),
              ],
            ),
            
            const SizedBox(height: 24),

            // 📚 Góc học tập
            _buildSectionHeader(
              context,
              icon: Icons.school,
              title: 'Góc học tập',
              color: Colors.green,
            ),
            const SizedBox(height: 12),
            Column(
              children: [
                _buildPracticeCard(
                  context,
                  title: 'Radio',
                  subtitle: 'Listen to English podcasts and radio',
                  icon: Icons.radio,
                  color: Colors.indigo,
                  isComingSoon: true,
                  onTap: () => _showComingSoon(context, 'English Radio'),
                ),
                const SizedBox(height: 12),
                _buildPracticeCard(
                  context,
                  title: 'Từ vựng',
                  subtitle: 'Manage and review your vocabulary',
                  icon: Icons.book,
                  color: Colors.green,
                  isComingSoon: false,
                  onTap: () {
                    // Navigate to vocabulary page
                    context.push('/vocabulary');
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: color,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ],
    );
  }

  Widget _buildPracticeCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required bool isComingSoon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
            ),
          ),
          child: Row(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 24,
                  color: color,
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Content - Fixed overflow issue
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title with Coming Soon badge
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        if (isComingSoon) ...[
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Coming Soon',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 8),
              
              // Arrow
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Coming Soon'),
          content: Text('$feature is under development and will be available soon!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}