import 'package:flutter/material.dart';
import 'package:idea/screens/library/model/library_item_model.dart';
import 'package:intl/intl.dart';

class LibraryItemCard extends StatelessWidget {
  final LibraryItemModel item;
  final VoidCallback onTap;
  final Function(String) onMenuAction;

  const LibraryItemCard({
    super.key,
    required this.item,
    required this.onTap,
    required this.onMenuAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF525CEB).withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _buildIcon(),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: Color(0xFF3D3B40),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8EDFF),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              item.subject,
                              style: const TextStyle(
                                color: Color(0xFF525CEB),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat('MMM d, yyyy').format(item.date),
                            style: TextStyle(
                              color: const Color(
                                0xFF3D3B40,
                              ).withValues(alpha: 0.6),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      _buildDetails(),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Color(0xFF3D3B40)),
                  onSelected: onMenuAction,
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'open',
                          child: Row(
                            children: [
                              Icon(Icons.open_in_new, size: 18),
                              SizedBox(width: 8),
                              Text('Open'),
                            ],
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'share',
                          child: Row(
                            children: [
                              Icon(Icons.share, size: 18),
                              SizedBox(width: 8),
                              Text('Share'),
                            ],
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'rename',
                          child: Row(
                            children: [
                              Icon(Icons.edit, size: 18),
                              SizedBox(width: 8),
                              Text('Rename'),
                            ],
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red, size: 18),
                              SizedBox(width: 8),
                              Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    IconData iconData;
    Color color;
    Color bgColor;

    switch (item.type) {
      case LibraryItemType.document:
        iconData = Icons.description;
        color = const Color(0xFF525CEB);
        bgColor = const Color(0xFFBFCFE7).withValues(alpha: 0.3);
        break;
      case LibraryItemType.quiz:
        iconData = Icons.quiz;
        color = Colors.orange;
        bgColor = Colors.orange.withValues(alpha: 0.1);
        break;
      case LibraryItemType.note:
        iconData = Icons.note;
        color = Colors.purple;
        bgColor = Colors.purple.withValues(alpha: 0.1);
        break;
    }

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(iconData, color: color),
    );
  }

  Widget _buildDetails() {
    if (item.type == LibraryItemType.document && item.fileSize != null) {
      return Text(
        item.fileSize!,
        style: TextStyle(
          color: const Color(0xFF3D3B40).withValues(alpha: 0.5),
          fontSize: 12,
        ),
      );
    } else if (item.type == LibraryItemType.quiz && item.score != null) {
      return Text(
        'Score: ${item.score}/${item.totalQuestions}',
        style: TextStyle(
          color: (item.score! / item.totalQuestions! >= 0.7)
              ? Colors.green
              : Colors.orange,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
