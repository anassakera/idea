import 'package:flutter/material.dart';
import 'package:idea/routes/app_routes.dart';
import 'package:idea/screens/library/model/library_item_model.dart';
import 'package:idea/screens/library/widgets/library_item_card.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  final List<LibraryItemModel> _allItems = [
    LibraryItemModel(
      id: '1',
      title: 'Math Fundamentals.pdf',
      subject: 'Math',
      date: DateTime.now().subtract(const Duration(days: 1)),
      type: LibraryItemType.document,
      fileSize: '2.5 MB',
    ),
    LibraryItemModel(
      id: '2',
      title: 'Physics Quiz 1',
      subject: 'Physics',
      date: DateTime.now().subtract(const Duration(days: 2)),
      type: LibraryItemType.quiz,
      score: 8,
      totalQuestions: 10,
    ),
    LibraryItemModel(
      id: '3',
      title: 'History Notes',
      subject: 'History',
      date: DateTime.now().subtract(const Duration(days: 5)),
      type: LibraryItemType.note,
    ),
    LibraryItemModel(
      id: '4',
      title: 'Chemistry Lab Report.docx',
      subject: 'Chemistry',
      date: DateTime.now().subtract(const Duration(days: 0)),
      type: LibraryItemType.document,
      fileSize: '1.2 MB',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<LibraryItemModel> _filterItems(LibraryItemType? type) {
    var items = _allItems;
    if (type != null) {
      items = items.where((item) => item.type == type).toList();
    }

    // Simple search logic
    final query = _searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      items = items
          .where(
            (item) =>
                item.title.toLowerCase().contains(query) ||
                item.subject.toLowerCase().contains(query),
          )
          .toList();
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EDFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Library',
          style: TextStyle(
            color: Color(0xFF3D3B40),
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: const Color(0xFF525CEB),
          unselectedLabelColor: const Color(0xFF3D3B40).withValues(alpha: 0.6),
          indicatorColor: const Color(0xFF525CEB),
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Documents'),
            Tab(text: 'Quizzes'),
            Tab(text: 'Notes'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() {}),
                decoration: const InputDecoration(
                  hintText: 'Search files, quizzes...',
                  prefixIcon: Icon(Icons.search, color: Color(0xFFBFCFE7)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),
          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildList(_filterItems(null)),
                _buildList(_filterItems(LibraryItemType.document)),
                _buildList(_filterItems(LibraryItemType.quiz)),
                _buildList(_filterItems(LibraryItemType.note)),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to upload document
          Navigator.pushNamed(context, AppRoutes.uploadDocument);
        },
        backgroundColor: const Color(0xFF525CEB),
        icon: const Icon(Icons.upload_file, color: Colors.white),
        label: const Text('Upload', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildList(List<LibraryItemModel> items) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder_open,
              size: 64,
              color: Colors.grey.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No items found',
              style: TextStyle(
                color: Colors.grey.withValues(alpha: 0.8),
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return LibraryItemCard(
          item: items[index],
          onTap: () {
            // Handle tap based on item type
            if (items[index].type == LibraryItemType.document) {
              Navigator.pushNamed(context, AppRoutes.documentDetails);
            } else if (items[index].type == LibraryItemType.quiz) {
              Navigator.pushNamed(context, AppRoutes.quizResult);
            }
          },
          onMenuAction: (action) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Selected action: $action')));
          },
        );
      },
    );
  }
}
