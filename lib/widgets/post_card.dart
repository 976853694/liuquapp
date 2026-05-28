import 'package:flutter/material.dart';
import '../models/post.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 用户信息
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    post.timeAgo,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // 内容
          Text(
            post.content,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
            ),
          ),
          
          // 图片
          if (post.images.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildImageGrid(post.images),
          ],
          
          const SizedBox(height: 12),
          
          // 互动数据
          Row(
            children: [
              _buildStatItem(Icons.visibility_outlined, post.views),
              const SizedBox(width: 24),
              _buildStatItem(Icons.chat_bubble_outline, post.comments),
              const SizedBox(width: 24),
              _buildStatItem(Icons.favorite_border, post.likes),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageGrid(List<String> images) {
    if (images.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 200,
          color: Colors.grey[200],
          child: const Center(
            child: Icon(Icons.image, size: 60, color: Colors.grey),
          ),
        ),
      );
    }

    return SizedBox(
      height: 120,
      child: Row(
        children: images.take(3).map((image) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(Icons.image, size: 40, color: Colors.grey),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, int count) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          count.toString(),
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
