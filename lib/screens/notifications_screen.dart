import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/notification.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<NotificationItem> _mockNotifications = [
    NotificationItem(
      id: '1',
      type: 'LIKE',
      title: '小明 赞了你的帖子',
      content: '上周末天气挺好，出去晒晒太阳',
      timeAgo: '5分钟前',
      isRead: false,
      username: '小明',
    ),
    NotificationItem(
      id: '2',
      type: 'REPLY_POST',
      title: '小红 回复了你的帖子',
      content: '拍得真好！',
      timeAgo: '1小时前',
      isRead: false,
      username: '小红',
    ),
    NotificationItem(
      id: '3',
      type: 'FOLLOWED_YOU',
      title: '小刚 关注了你',
      content: '',
      timeAgo: '2小时前',
      isRead: true,
      username: '小刚',
    ),
    NotificationItem(
      id: '4',
      type: 'MENTION',
      title: '小李 在评论中提到了你',
      content: '@你 你觉得这个怎么样？',
      timeAgo: '3小时前',
      isRead: true,
      username: '小李',
    ),
    NotificationItem(
      id: '5',
      type: 'SYSTEM',
      title: '系统通知',
      content: '欢迎来到六趣社区！',
      timeAgo: '1天前',
      isRead: true,
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
      appBar: AppBar(
        title: const Text('通知'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                for (var notification in _mockNotifications) {
                  notification = NotificationItem(
                    id: notification.id,
                    type: notification.type,
                    title: notification.title,
                    content: notification.content,
                    timeAgo: notification.timeAgo,
                    isRead: true,
                    username: notification.username,
                  );
                }
              });
            },
            child: const Text('全部已读'),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: TabBar(
            controller: _tabController,
            labelColor: const Color(0xFF00C853),
            unselectedLabelColor: Colors.grey,
            indicatorColor: const Color(0xFF00C853),
            indicatorWeight: 3,
            tabs: const [
              Tab(text: '全部'),
              Tab(text: '互动'),
              Tab(text: '系统'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNotificationList(_mockNotifications),
          _buildNotificationList(
            _mockNotifications.where((n) => n.type != 'SYSTEM').toList(),
          ),
          _buildNotificationList(
            _mockNotifications.where((n) => n.type == 'SYSTEM').toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList(List<NotificationItem> notifications) {
    if (notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_none, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              '暂无通知',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return _buildNotificationItem(notifications[index]);
      },
    );
  }

  Widget _buildNotificationItem(NotificationItem notification) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: notification.isRead
                ? Colors.white.withOpacity(0.9)
                : const Color(0xFF00C853).withOpacity(0.05),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              leading: Stack(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      _getNotificationIcon(notification.type),
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  if (!notification.isRead)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              title: Text(
                notification.title,
                style: TextStyle(
                  fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              subtitle: notification.content.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        notification.content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    )
                  : null,
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    notification.timeAgo,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  // Mark as read
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'LIKE':
        return Icons.favorite;
      case 'REPLY_POST':
      case 'REPLY_COMMENT':
        return Icons.comment;
      case 'MENTION':
        return Icons.alternate_email;
      case 'FOLLOWED_YOU':
        return Icons.person_add;
      case 'FOLLOWING_ACTIVITY':
        return Icons.notifications;
      case 'SYSTEM':
        return Icons.info;
      default:
        return Icons.notifications;
    }
  }
}
