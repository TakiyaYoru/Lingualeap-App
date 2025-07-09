// lib/controllers/vocabulary_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/vocabulary_model.dart';

class VocabularyController extends GetxController {
  // Observable lists
  final RxList<VocabularyWord> _allWords = <VocabularyWord>[].obs;
  final Rx<VocabularyFilter> _currentFilter = VocabularyFilter.all.obs;
  final RxBool _isLoading = false.obs;

  // Getters
  List<VocabularyWord> get allWords => _allWords;
  VocabularyFilter get currentFilter => _currentFilter.value;
  bool get isLoading => _isLoading.value;

  // Filtered words based on current filter
  List<VocabularyWord> get filteredWords {
    switch (_currentFilter.value) {
      case VocabularyFilter.all:
        return _allWords;
      case VocabularyFilter.unlearned:
        return _allWords.where((word) => !word.isLearned).toList();
      case VocabularyFilter.learned:
        return _allWords.where((word) => word.isLearned).toList();
    }
  }

  // Statistics
  int get totalWords => _allWords.length;
  int get learnedWords => _allWords.where((word) => word.isLearned).length;
  int get unlearnedWords => _allWords.where((word) => !word.isLearned).length;
  double get progressPercentage => 
      totalWords == 0 ? 0.0 : (learnedWords / totalWords) * 100;

  @override
  void onInit() {
    super.onInit();
    loadVocabulary();
    _loadSampleData(); // Load some sample data for testing
  }

  // Load vocabulary from SharedPreferences
  Future<void> loadVocabulary() async {
    try {
      _isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      final String? vocabularyJson = prefs.getString('vocabulary_words');
      
      if (vocabularyJson != null) {
        final List<dynamic> wordsList = json.decode(vocabularyJson);
        _allWords.value = wordsList
            .map((wordJson) => VocabularyWord.fromJson(wordJson))
            .toList();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load vocabulary: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  // Save vocabulary to SharedPreferences
  Future<void> _saveVocabulary() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String vocabularyJson = json.encode(
        _allWords.map((word) => word.toJson()).toList(),
      );
      await prefs.setString('vocabulary_words', vocabularyJson);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save vocabulary: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Add new word
  Future<void> addWord({
    required String word,
    required String meaning,
    String? pronunciation,
    String? example,
  }) async {
    // Check for duplicates
    if (_allWords.any((w) => w.word.toLowerCase() == word.toLowerCase())) {
      Get.snackbar(
        'Word Exists',
        'This word is already in your vocabulary list',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final newWord = VocabularyWord(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      word: word.trim(),
      meaning: meaning.trim(),
      pronunciation: pronunciation?.trim(),
      example: example?.trim(),
      createdAt: DateTime.now(),
    );

    _allWords.insert(0, newWord); // Add to beginning of list
    await _saveVocabulary();
    
    Get.snackbar(
      'Word Added',
      '"$word" has been added to your vocabulary',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Delete word
  Future<void> deleteWord(String wordId) async {
    final wordIndex = _allWords.indexWhere((word) => word.id == wordId);
    if (wordIndex != -1) {
      final removedWord = _allWords[wordIndex];
      _allWords.removeAt(wordIndex);
      await _saveVocabulary();
      
      Get.snackbar(
        'Word Deleted',
        '"${removedWord.word}" has been removed',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Toggle learned status
  Future<void> toggleLearned(String wordId) async {
    final wordIndex = _allWords.indexWhere((word) => word.id == wordId);
    if (wordIndex != -1) {
      final currentWord = _allWords[wordIndex];
      final updatedWord = currentWord.copyWith(
        isLearned: !currentWord.isLearned,
        learnedAt: !currentWord.isLearned ? DateTime.now() : null,
      );
      
      _allWords[wordIndex] = updatedWord;
      await _saveVocabulary();
      
      Get.snackbar(
        updatedWord.isLearned ? 'Word Learned!' : 'Word Unmarked',
        updatedWord.isLearned 
            ? 'Great! "${updatedWord.word}" marked as learned'
            : '"${updatedWord.word}" marked as unlearned',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Set filter
  void setFilter(VocabularyFilter filter) {
    _currentFilter.value = filter;
  }

  // Clear all words
  Future<void> clearAllWords() async {
    _allWords.clear();
    await _saveVocabulary();
    Get.snackbar(
      'All Cleared',
      'All vocabulary words have been removed',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Load sample data for testing
  Future<void> _loadSampleData() async {
    // Only load if no words exist
    if (_allWords.isEmpty) {
      final sampleWords = [
        VocabularyWord(
          id: '1',
          word: 'Serendipity',
          meaning: 'The occurrence of events by chance in a happy way',
          pronunciation: '/ˌserənˈdipədē/',
          example: 'Meeting my best friend was pure serendipity.',
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
        ),
        VocabularyWord(
          id: '2',
          word: 'Ephemeral',
          meaning: 'Lasting for a very short time',
          pronunciation: '/əˈfem(ə)rəl/',
          example: 'The beauty of cherry blossoms is ephemeral.',
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          isLearned: true,
          learnedAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        VocabularyWord(
          id: '3',
          word: 'Resilience',
          meaning: 'The ability to recover quickly from difficulties',
          pronunciation: '/rəˈzilyəns/',
          example: 'Her resilience helped her overcome all obstacles.',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ];

      _allWords.addAll(sampleWords);
      await _saveVocabulary();
    }
  }
}