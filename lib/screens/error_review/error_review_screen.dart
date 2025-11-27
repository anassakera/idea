import 'package:flutter/material.dart';
import 'package:idea/screens/error_review/model/review_model.dart';
import 'package:idea/screens/error_review/widgets/question_review_card.dart';

class ErrorReviewScreen extends StatefulWidget {
  const ErrorReviewScreen({super.key});

  @override
  State<ErrorReviewScreen> createState() => _ErrorReviewScreenState();
}

class _ErrorReviewScreenState extends State<ErrorReviewScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Correct', 'Incorrect', 'Skipped'];

  // Dummy Data
  final List<ReviewModel> _allReviews = [
    ReviewModel(
      questionNumber: 1,
      questionText: "What is the capital of France?",
      userAnswer: "Paris",
      correctAnswer: "Paris",
      explanation: "Paris is the capital and most populous city of France.",
      isCorrect: true,
    ),
    ReviewModel(
      questionNumber: 2,
      questionText: "Which planet is known as the Red Planet?",
      userAnswer: "Venus",
      correctAnswer: "Mars",
      explanation:
          "Mars is often referred to as the 'Red Planet' because of the reddish iron oxide prevalent on its surface.",
      isCorrect: false,
    ),
    ReviewModel(
      questionNumber: 3,
      questionText: "What is 2 + 2?",
      userAnswer: "4",
      correctAnswer: "4",
      explanation: "Basic arithmetic addition.",
      isCorrect: true,
    ),
    ReviewModel(
      questionNumber: 4,
      questionText: "Who wrote 'Romeo and Juliet'?",
      userAnswer: "Charles Dickens",
      correctAnswer: "William Shakespeare",
      explanation:
          "William Shakespeare wrote the play 'Romeo and Juliet' early in his career.",
      isCorrect: false,
    ),
  ];

  List<ReviewModel> get _filteredReviews {
    if (_selectedFilter == 'All') return _allReviews;
    if (_selectedFilter == 'Correct') {
      return _allReviews.where((r) => r.isCorrect).toList();
    }
    if (_selectedFilter == 'Incorrect') {
      return _allReviews.where((r) => !r.isCorrect).toList();
    }
    // For simplicity, treating skipped as incorrect or separate if we had that state
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EDFF), // Magnolia
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF3D3B40)),
          onPressed: () => Navigator.pop(context),
        ),
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF525CEB), Color(0xFFBFCFE7)],
          ).createShader(bounds),
          child: const Text(
            'Review Answers',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white, // Required for ShaderMask
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: _filters.map((filter) {
                final isSelected = _selectedFilter == filter;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF525CEB)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: const Color(
                                  0xFF525CEB,
                                ).withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [],
                    ),
                    child: Text(
                      filter,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF3D3B40),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredReviews.length,
              itemBuilder: (context, index) {
                return QuestionReviewCard(
                  review: _filteredReviews[index],
                  onTap: () {
                    setState(() {
                      _filteredReviews[index].isExpanded =
                          !_filteredReviews[index].isExpanded;
                    });
                  },
                  onFlag: () {
                    setState(() {
                      _filteredReviews[index].isFlagged =
                          !_filteredReviews[index].isFlagged;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Save for later logic
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Saved flagged questions for later review'),
            ),
          );
        },
        backgroundColor: const Color(0xFF525CEB),
        icon: const Icon(Icons.bookmark_add, color: Colors.white),
        label: const Text(
          'Save Flagged',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
