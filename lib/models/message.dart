class Message {
  final String id;
  final String conversationId;
  final int senderId;
  final int recipientId;
  final String content;
  final DateTime timestamp;
  final bool isRead;
  final List<String> attachments;

  Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.recipientId,
    required this.content,
    required this.timestamp,
    this.isRead = false,
    this.attachments = const [],
  });
}

class Conversation {
  final String id;
  final int userId;
  final String username;
  final String nickname;
  final String? avatarPath;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final bool isOnline;

  Conversation({
    required this.id,
    required this.userId,
    required this.username,
    required this.nickname,
    this.avatarPath,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
    this.isOnline = false,
  });
}
