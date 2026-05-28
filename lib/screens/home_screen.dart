import 'package:flutter/material.dart';
import '../widgets/banner_card.dart';
import '../widgets/category_tabs.dart';
import '../widgets/post_card.dart';
import '../models/post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = '推荐';

  // 模拟数据
  final List<Post> _posts = [
    Post(
      id: '1',
      username: 'Teen',
      avatar: '',
      timeAgo: '12天前',
      content: '上周末天气挺好，出去晒晒太阳',
      images: ['', '', ''],
      views: 16,
      comments: 0,
      likes: 0,
    ),
    Post(
      id: '2',
      username: '晴天大',
      avatar: '',
      timeAgo: '12天前',
      content: '从此以后\n有一天你会遇到一个彩虹般绚丽的人，从此以后，其他人就不过是匆匆浮云',
      images: [],
      views: 4,
      comments: 0,
      likes: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页-狐书'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Banner卡片
          const BannerCard(),
          
          // 分类标签
          CategoryTabs(
            selectedCategory: _selectedCategory,
            onCategorySelected: (category) {
              setState(() {
                _selectedCategory = category;
              });
            },
          ),
          
          // 帖子列表
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return PostCard(post: _posts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
