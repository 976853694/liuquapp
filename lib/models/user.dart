class User {
  final int id;
  final String username;
  final String nickname;
  final String? avatarPath;
  final String role; // USER, MODERATOR, ADMIN
  final String status; // ACTIVE, MUTED, BANNED, INACTIVE
  final int level;
  final String levelName;
  final String levelColor;
  final String levelIcon;
  final int points;
  final int vipLevel;
  final DateTime? vipExpiresAt;
  final String? bio;
  final String? signature;
  final String? gender;
  final int followersCount;
  final int followingCount;
  final int postsCount;

  User({
    required this.id,
    required this.username,
    required this.nickname,
    this.avatarPath,
    required this.role,
    required this.status,
    required this.level,
    required this.levelName,
    required this.levelColor,
    required this.levelIcon,
    required this.points,
    this.vipLevel = 0,
    this.vipExpiresAt,
    this.bio,
    this.signature,
    this.gender,
    this.followersCount = 0,
    this.followingCount = 0,
    this.postsCount = 0,
  });
}
