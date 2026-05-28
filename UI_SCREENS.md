# 狐书 UI 界面文档

本文档描述了基于 API_USER.md 创建的所有 UI 界面。所有界面都采用毛玻璃（Glassmorphism）效果和绿色主题设计。

## 📱 已实现的界面

### 1. 登录/注册界面 (LoginScreen)
**文件**: `lib/screens/login_screen.dart`

**功能**:
- 双标签页设计（登录/注册）
- 登录模式切换：
  - 密码登录
  - 验证码登录
- 社交登录支持（Google、GitHub）
- 忘记密码功能
- 毛玻璃背景效果
- 渐变按钮设计

**API 对应**:
- `POST /api/auth/login` - 用户登录
- `POST /api/auth/register` - 用户注册
- `POST /api/auth/send-verification-code` - 发送验证码
- `GET /api/auth/oauth/[provider]/callback` - OAuth 登录

---

### 2. 首页界面 (HomeScreen)
**文件**: `lib/screens/home_screen.dart`

**功能**:
- Banner 卡片展示（带呼吸动画）
- 分类标签切换
- 帖子瀑布流展示
- 下拉刷新
- 毛玻璃效果卡片

**API 对应**:
- `GET /api/posts` - 获取帖子列表

---

### 3. 动态流界面 (FeedScreen)
**文件**: `lib/screens/feed_screen.dart`

**功能**:
- 三个标签页：关注、热门、最新
- 帖子列表展示
- 下拉刷新
- 点击跳转到帖子详情
- 毛玻璃导航栏

**API 对应**:
- `GET /api/feed` - 获取 Feed 流
- 查询参数: `type=following|hot|latest`

---

### 4. 帖子详情界面 (PostDetailScreen)
**文件**: `lib/screens/post_detail_screen.dart`

**功能**:
- 帖子完整内容展示
- 作者信息和关注按钮
- 图片网格展示
- 点赞、收藏、分享按钮
- 评论列表（树形结构）
- 评论回复功能
- 评论点赞
- 举报、屏蔽等更多选项

**API 对应**:
- `GET /api/posts/[id]` - 获取帖子详情
- `POST /api/posts/like` - 点赞帖子
- `POST /api/posts/favorite` - 收藏帖子
- `GET /api/comments/list` - 获取评论列表
- `POST /api/comments/create` - 创建评论
- `POST /api/comments/like` - 点赞评论
- `POST /api/reports/create` - 举报

---

### 5. 发布帖子界面 (CreatePostScreen)
**文件**: `lib/screens/create_post_screen.dart`

**功能**:
- 帖子类型选择：
  - 普通帖
  - 悬赏帖
  - 投票帖
  - 抽奖帖
  - 拍卖帖
- 标题和内容输入
- 图片上传（网格展示）
- 标签添加
- 匿名发布选项
- 添加位置
- 选择分区
- 底部工具栏（图片、表情、@提及、附件）

**API 对应**:
- `POST /api/posts/create` - 创建帖子
- `POST /api/upload` - 上传文件

---

### 6. 消息列表界面 (MessagesScreen)
**文件**: `lib/screens/messages_screen.dart`

**功能**:
- 会话列表展示
- 未读消息数量提示
- 在线状态显示
- 最后消息预览
- 时间格式化显示
- 点击进入聊天界面

**API 对应**:
- `GET /api/messages/conversation` - 获取会话列表

---

### 7. 聊天界面 (ChatScreen)
**文件**: `lib/screens/chat_screen.dart`

**功能**:
- 消息气泡展示（左右对齐）
- 实时消息发送
- 附件上传选项（图片、视频、文件）
- 在线状态显示
- 毛玻璃消息气泡
- 自动滚动到最新消息

**API 对应**:
- `GET /api/messages/history` - 获取消息历史
- `POST /api/messages/send` - 发送消息
- `POST /api/messages/upload` - 上传附件
- `GET /api/messages/stream` - SSE 实时消息推送

---

### 8. 通知界面 (NotificationsScreen)
**文件**: `lib/screens/notifications_screen.dart`

**功能**:
- 三个标签页：全部、互动、系统
- 通知类型图标：
  - 点赞 ❤️
  - 评论 💬
  - 提及 @
  - 关注 👤
  - 系统 ℹ️
- 未读标记（红点）
- 全部已读功能
- 通知内容预览

**API 对应**:
- `GET /api/notifications` - 获取通知列表
- `POST /api/notifications/read` - 标记已读
- `POST /api/notifications/read-all` - 全部标记已读

---

### 9. 个人资料界面 (ProfileScreen)
**文件**: `lib/screens/profile_screen.dart`

**功能**:
- 头像展示（带边框和阴影）
- VIP 标识
- 用户名和等级显示
- 个人简介
- 统计数据：
  - 关注数
  - 粉丝数
  - 帖子数
  - 积分
- 三个标签页：帖子、收藏、赞过
- 设置按钮
- 毛玻璃效果

**API 对应**:
- `GET /api/auth/me` - 获取当前用户信息
- `GET /api/users/[username]` - 获取用户信息
- `GET /api/users/[username]/posts` - 获取用户帖子

---

### 10. 设置界面 (SettingsScreen)
**文件**: `lib/screens/settings_screen.dart`

**功能**:
- 账号设置：
  - 编辑资料
  - 修改密码
  - 绑定邮箱
  - 绑定手机
- 通知设置：
  - 邮件通知开关
  - 推送通知开关
- 隐私设置：
  - 屏蔽列表
  - 隐私设置
- 外观设置：
  - 深色模式开关
- 其他：
  - 帮助中心
  - 关于我们
  - 用户协议
- 退出登录按钮

**API 对应**:
- `POST /api/profile/update` - 更新个人资料
- `POST /api/profile/password` - 修改密码
- `POST /api/profile/notification-settings` - 通知设置
- `POST /api/auth/logout` - 退出登录

---

## 🎨 设计特点

### 毛玻璃效果 (Glassmorphism)
所有界面都使用了 `BackdropFilter` 实现毛玻璃效果：
```dart
BackdropFilter(
  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
  child: Container(
    color: Colors.white.withOpacity(0.9),
    // ...
  ),
)
```

### 绿色主题
- 主色调: `#00C853` (深绿)
- 辅助色: `#00E676` (浅绿)
- 渐变效果: 从浅绿到深绿

### 动画效果
- 呼吸动画（Banner、FAB）
- 页面切换淡入淡出
- 按钮点击缩放
- 标签页滑动

---

## 📦 数据模型

### User (用户)
**文件**: `lib/models/user.dart`
```dart
- id: 用户ID
- username: 用户名
- nickname: 昵称
- avatarPath: 头像路径
- role: 角色 (USER/MODERATOR/ADMIN)
- status: 状态 (ACTIVE/MUTED/BANNED)
- level: 等级
- points: 积分
- vipLevel: VIP等级
- bio: 个人简介
- followersCount: 粉丝数
- followingCount: 关注数
- postsCount: 帖子数
```

### Post (帖子)
**文件**: `lib/models/post.dart`
```dart
- id: 帖子ID
- username: 作者用户名
- avatar: 作者头像
- timeAgo: 发布时间
- content: 内容
- images: 图片列表
- views: 浏览量
- comments: 评论数
- likes: 点赞数
```

### Comment (评论)
**文件**: `lib/models/comment.dart`
```dart
- id: 评论ID
- postId: 帖子ID
- content: 内容
- username: 用户名
- nickname: 昵称
- timeAgo: 时间
- likes: 点赞数
- isLiked: 是否已点赞
- replyToUsername: 回复的用户
- replies: 子评论列表
```

### Message (消息)
**文件**: `lib/models/message.dart`
```dart
- id: 消息ID
- conversationId: 会话ID
- senderId: 发送者ID
- recipientId: 接收者ID
- content: 内容
- timestamp: 时间戳
- isRead: 是否已读
- attachments: 附件列表
```

### Conversation (会话)
**文件**: `lib/models/message.dart`
```dart
- id: 会话ID
- userId: 用户ID
- username: 用户名
- nickname: 昵称
- lastMessage: 最后消息
- lastMessageTime: 最后消息时间
- unreadCount: 未读数量
- isOnline: 是否在线
```

### NotificationItem (通知)
**文件**: `lib/models/notification.dart`
```dart
- id: 通知ID
- type: 类型 (LIKE/REPLY_POST/MENTION等)
- title: 标题
- content: 内容
- timeAgo: 时间
- isRead: 是否已读
- username: 相关用户名
```

---

## 🔄 导航结构

```
LoginScreen (登录界面)
    ↓
MainScreen (主界面)
    ├── HomeScreen (首页)
    ├── FeedScreen (动态)
    │   └── PostDetailScreen (帖子详情)
    │       └── ChatScreen (私信)
    ├── CreatePostScreen (发布)
    ├── NotificationsScreen (通知)
    └── ProfileScreen (个人)
        └── SettingsScreen (设置)

MessagesScreen (消息列表)
    └── ChatScreen (聊天)
```

---

## 🚀 使用说明

### 启动应用
1. 默认启动到登录界面
2. 点击"登录"按钮进入主界面
3. 可以在 `main.dart` 中修改 `home: const LoginScreen()` 为 `home: const MainScreen()` 跳过登录

### 底部导航栏
- **首页**: 展示推荐内容和 Banner
- **动态**: 关注、热门、最新三个 Feed 流
- **发布**: 点击中间的 + 按钮发布内容
- **通知**: 查看所有通知
- **我**: 个人资料和设置

### 模拟数据
所有界面都使用了模拟数据（mock data），实际使用时需要：
1. 集成真实的 API 调用
2. 添加状态管理（如 Provider、Riverpod、Bloc）
3. 添加错误处理和加载状态
4. 实现图片上传和显示
5. 添加 SSE 实时消息推送

---

## 📝 待实现功能

以下功能在 API 文档中有定义，但 UI 暂未完全实现：

1. **高级帖子类型**:
   - 悬赏帖的赏金设置
   - 投票帖的选项管理
   - 抽奖帖的配置
   - 拍卖帖的出价功能

2. **积分和 VIP 系统**:
   - 积分充值界面
   - VIP 购买界面
   - 积分商城

3. **签到系统**:
   - 签到界面
   - 签到日历
   - 补签功能

4. **勋章系统**:
   - 勋章展示
   - 勋章领取
   - 勋章墙

5. **搜索功能**:
   - 全局搜索
   - 用户搜索
   - 帖子搜索
   - 标签搜索

6. **节点/分区**:
   - 节点列表
   - 节点详情
   - 节点关注

7. **友情链接**:
   - 友链申请
   - 友链展示

8. **RSS Universe**:
   - RSS 源列表
   - RSS 条目展示

9. **小游戏**:
   - 五子棋
   - 阴阳契

---

## 🎯 下一步建议

1. **集成真实 API**:
   - 使用 `http` 或 `dio` 包
   - 创建 API service 层
   - 添加请求拦截器和错误处理

2. **状态管理**:
   - 推荐使用 Riverpod 或 Bloc
   - 管理用户登录状态
   - 管理帖子列表状态

3. **图片处理**:
   - 使用 `image_picker` 选择图片
   - 使用 `cached_network_image` 缓存网络图片
   - 实现图片压缩和上传

4. **实时通信**:
   - 实现 SSE 消息推送
   - 添加 WebSocket 支持（如果需要）

5. **性能优化**:
   - 列表懒加载
   - 图片懒加载
   - 缓存策略

6. **测试**:
   - 单元测试
   - Widget 测试
   - 集成测试

---

## 📄 许可证

本项目遵循 MIT 许可证。
