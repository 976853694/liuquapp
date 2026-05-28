import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/post.dart';
import '../widgets/post_card.dart';
import 'post_detail_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _currentFeedType = 'following';

  final List<Post> _mockPosts = [
    Post(
      id: '1',
      username: 'Teen',
      avatar: '',
      timeAgo: '12天前',
      content: '上周末天气挺好，出去晒晒太阳 ☀️',
      images: ['', '', ''],
      views: 16,
      comments: 3,
      likes: 8,
    ),
    Post(
      id: '2',
      username: '晴天大',
      avatar: '',
      timeAgo: '12天前',
      content: '从此以后\n有一天你会遇到一个彩虹般绚丽的人，从此以后，其他人就不过是匆匆浮云 🌈',
      images: [],
      views: 24,
      comments: 5,
      likes: 12,
    ),
    Post(
      id: '3',
      username: '摄影师小王',
      avatar: '',
      timeAgo: '1天前',
      content: '今天拍到的日落，太美了！',
      images: ['', ''],
      views: 156,
      comments: 23,
      likes: 89,
    ),
  ];

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
      backgroundColor: Colors.grey[50],
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              pinned: true,
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text(
                '动态',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.black),
                  onPressed: () {},
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      color: Colors.white.withOpacity(0.9),
                      child: TabBar(
                        controller: _tabController,
                        labelColor: const Color(0xFF00C853),
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: const Color(0xFF00C853),
                        indicatorWeight: 3,
                        onTap: (index) {
                          setState(() {
                            _currentFeedType = ['following', 'hot', 'latest'][index];
                          });
                        },
                        tabs: const [
                          Tab(text: '关注'),
                          Tab(text: '热门'),
                          Tab(text: '最新'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildFeedList(),
            _buildFeedList(),
            _buildFeedList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedList() {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 80),
        itemCount: _mockPosts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PostDetailScreen(post: _mockPosts[index]),
                ),
              );
            },
            child: PostCard(post: _mockPosts[index]),
          );
        },
      ),
    );
  }
}
