class NotificationItem {
  final String id;
  final String type; // REPLY_POST, REPLY_COMMENT, LIKE, MENTION, FOLLOWED_YOU, etc.
  final String title;
  final String content;
  final String timeAgo;
  final bool isRead;
  final String? avatarPath;
  final String? username;
  final String? postId;
  final String? commentId;

  NotificationItem({
    required this.id,
    required this.type,
    required this.title,
    required this.content,
    required this.timeAgo,
    this.isRead = false,
    this.avatarPath,
    this.username,
    this.postId,
    this.commentId,
  });
}
