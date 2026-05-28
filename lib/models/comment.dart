class Comment {
  final String id;
  final String postId;
  final String content;
  final String username;
  final String nickname;
  final String? avatarPath;
  final String timeAgo;
  final int likes;
  final bool isLiked;
  final bool isAnonymous;
  final bool isPrivate;
  final String? replyToCommentId;
  final int? replyToUserId;
  final String? replyToUsername;
  final List<Comment> replies;

  Comment({
    required this.id,
    required this.postId,
    required this.content,
    required this.username,
    required this.nickname,
    this.avatarPath,
    required this.timeAgo,
    this.likes = 0,
    this.isLiked = false,
    this.isAnonymous = false,
    this.isPrivate = false,
    this.replyToCommentId,
    this.replyToUserId,
    this.replyToUsername,
    this.replies = const [],
  });
}
