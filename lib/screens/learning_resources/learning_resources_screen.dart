import 'package:flutter/material.dart';
import 'package:idea/screens/learning_resources/widgets/video_card.dart';
import 'package:idea/screens/learning_resources/widgets/flashcard_widget.dart';

class LearningResourcesScreen extends StatefulWidget {
  const LearningResourcesScreen({super.key});

  @override
  State<LearningResourcesScreen> createState() =>
      _LearningResourcesScreenState();
}

class _LearningResourcesScreenState extends State<LearningResourcesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EDFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF3D3B40)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Learning Resources',
          style: TextStyle(
            color: Color(0xFF3D3B40),
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF525CEB),
          unselectedLabelColor: const Color(0xFF3D3B40).withValues(alpha: 0.6),
          indicatorColor: const Color(0xFF525CEB),
          tabs: const [
            Tab(text: 'Videos'),
            Tab(text: 'Summaries'),
            Tab(text: 'Flashcards'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildVideosTab(),
          _buildSummariesTab(),
          _buildFlashcardsTab(),
        ],
      ),
    );
  }

  Widget _buildVideosTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        VideoCard(
          title: 'Introduction to Calculus',
          duration: '12:30',
          thumbnailUrl: '', // Add valid URL if available
          onTap: () {},
        ),
        VideoCard(
          title: 'The Solar System Explained',
          duration: '08:45',
          thumbnailUrl: '',
          onTap: () {},
        ),
        VideoCard(
          title: 'French Grammar Basics',
          duration: '15:20',
          thumbnailUrl: '',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSummariesTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.map_outlined,
                size: 48,
                color: const Color(0xFF525CEB).withValues(alpha: 0.8),
              ),
              const SizedBox(height: 16),
              Text(
                'Mind Map ${index + 1}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3D3B40),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'View Summary',
                style: TextStyle(
                  color: const Color(0xFF525CEB).withValues(alpha: 0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFlashcardsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        FlashcardWidget(
          question: 'What is the powerhouse of the cell?',
          answer: 'Mitochondria',
        ),
        SizedBox(height: 16),
        FlashcardWidget(
          question: 'What is the value of Pi (approx)?',
          answer: '3.14159',
        ),
        SizedBox(height: 16),
        FlashcardWidget(
          question: 'Who painted the Mona Lisa?',
          answer: 'Leonardo da Vinci',
        ),
      ],
    );
  }
}
