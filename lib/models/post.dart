class Post {
  final String id;
  final String username;
  final String avatar;
  final String timeAgo;
  final String content;
  final List<String> images;
  final int views;
  final int comments;
  final int likes;

  Post({
    required this.id,
    required this.username,
    required this.avatar,
    required this.timeAgo,
    required this.content,
    required this.images,
    required this.views,
    required this.comments,
    required this.likes,
  });
}
