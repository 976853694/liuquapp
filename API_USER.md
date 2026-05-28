# Rhex 用户 API 接口文档

> 本文档包含所有普通用户可以使用的 API 接口

## 基础信息

- **Base URL**: `https://your-domain.com/api`
- **认证方式**: Session Cookie
- **响应格式**: JSON

### 通用响应格式

**成功响应**:
```json
{
  "success": true,
  "data": {},
  "message": "操作成功"
}
```

**错误响应**:
```json
{
  "success": false,
  "message": "错误信息",
  "code": 400
}
```

---

## 权限说明

### 接口权限分类

#### 🌐 公开接口 (无需登录)
- 浏览帖子列表
- 查看帖子详情
- 查看用户资料
- RSS 订阅

#### 🔐 用户接口 (需要登录)
- 发帖、评论、点赞、收藏
- 个人资料管理
- 消息通知
- 签到、积分、VIP

### 用户状态 (UserStatus)
- **ACTIVE**: 正常 - 可以正常使用所有功能
- **MUTED**: 禁言 - 无法发帖和评论，但可以浏览和点赞
- **BANNED**: 拉黑 - 无法登录和访问
- **INACTIVE**: 未激活 - 新注册用户未完成激活

---

## 1. 认证模块 (Auth)

### 1.1 用户登录
- **接口**: `POST /api/auth/login`
- **权限**: 🌐 公开
- **说明**: 支持用户名/邮箱/手机号密码登录，或手机验证码登录
- **请求体**:
```json
{
  "login": "username/email/phone",
  "password": "password",
  "loginMode": "password|phone-code",
  "phoneCode": "123456",
  "captchaToken": "token",
  "builtinCaptchaCode": "code",
  "powNonce": "nonce"
}
```
- **响应**:
```json
{
  "success": true,
  "data": {
    "username": "string",
    "autoLogin": true
  },
  "message": "登录成功"
}
```

### 1.2 用户注册
- **接口**: `POST /api/auth/register`
- **权限**: 🌐 公开
- **请求体**:
```json
{
  "username": "string",
  "password": "string",
  "nickname": "string",
  "email": "string",
  "emailCode": "string",
  "phone": "string",
  "phoneCode": "string",
  "inviteCode": "string",
  "inviterUsername": "string",
  "gender": "string",
  "captchaToken": "string"
}
```

### 1.3 获取当前用户信息
- **接口**: `GET /api/auth/me`
- **权限**: 🔐 需登录
- **响应**:
```json
{
  "user": {
    "id": 1,
    "username": "string",
    "nickname": "string",
    "avatarPath": "string",
    "role": "USER|MODERATOR|ADMIN",
    "status": "ACTIVE|MUTED|BANNED",
    "level": 1,
    "levelName": "新手",
    "levelColor": "#64748b",
    "levelIcon": "⭐",
    "points": 100,
    "vipLevel": 0,
    "vipExpiresAt": null
  },
  "surface": {}
}
```

### 1.4 退出登录
- **接口**: `POST /api/auth/logout`
- **权限**: 🔐 需登录

### 1.5 发送验证码
- **接口**: `POST /api/auth/send-verification-code`
- **权限**: 🌐 公开
- **请求体**:
```json
{
  "channel": "EMAIL|PHONE",
  "target": "email@example.com",
  "purpose": "register|login|reset-password"
}
```

### 1.6 验证验证码
- **接口**: `POST /api/auth/verify-code`
- **权限**: 🌐 公开

### 1.7 忘记密码 - 发送验证码
- **接口**: `POST /api/auth/forgot-password/send-code`
- **权限**: 🌐 公开

### 1.8 忘记密码 - 重置密码
- **接口**: `POST /api/auth/forgot-password/reset`
- **权限**: 🌐 公开

### 1.9 获取验证码图片
- **接口**: `GET /api/auth/captcha`
- **权限**: 🌐 公开

### 1.10 PoW 验证
- **接口**: `POST /api/auth/pow`
- **权限**: 🌐 公开

### 1.11 OAuth 登录
- **接口**: `GET /api/auth/oauth/[provider]/callback`
- **权限**: 🌐 公开
- **支持**: GitHub, Google

### 1.12 Passkey 注册
- **接口**: `POST /api/auth/passkey/register`
- **权限**: 🔐 需登录

### 1.13 Passkey 登录
- **接口**: `POST /api/auth/passkey/login`
- **权限**: 🌐 公开

---

## 2. 帖子模块 (Posts)

### 2.1 获取帖子列表
- **接口**: `GET /api/posts`
- **权限**: 🌐 公开
- **查询参数**: 
  - `page`: 页码
  - `pageSize`: 每页数量
  - `sort`: 排序方式

### 2.2 创建帖子
- **接口**: `POST /api/posts/create`
- **权限**: 🔐 需登录 (ACTIVE)
- **请求体**:
```json
{
  "boardId": "string",
  "title": "string",
  "content": "string",
  "type": "NORMAL|BOUNTY|POLL|LOTTERY|AUCTION",
  "isAnonymous": false,
  "tags": ["tag1", "tag2"],
  "coverPath": "string",
  "minViewLevel": 0,
  "minViewVipLevel": 0,
  "bountyPoints": 0,
  "pollOptions": [],
  "lotteryConfig": {},
  "auctionConfig": {}
}
```
- **响应**:
```json
{
  "id": "string",
  "slug": "string",
  "status": "NORMAL|PENDING"
}
```

### 2.3 更新帖子
- **接口**: `POST /api/posts/update`
- **权限**: 🔐 需登录

### 2.4 帖子点赞
- **接口**: `POST /api/posts/like`
- **权限**: 🔐 需登录 (ACTIVE/MUTED)
- **请求体**:
```json
{
  "postId": "string"
}
```
- **响应**:
```json
{
  "liked": true
}
```

### 2.5 收藏帖子
- **接口**: `POST /api/posts/favorite`
- **权限**: 🔐 需登录

### 2.6 打赏帖子
- **接口**: `POST /api/posts/tip`
- **权限**: 🔐 需登录
- **请求体**:
```json
{
  "postId": "string",
  "points": 10,
  "message": "打赏留言"
}
```

### 2.7 购买帖子解锁
- **接口**: `POST /api/posts/purchase`
- **权限**: 🔐 需登录

### 2.8 帖子下线
- **接口**: `POST /api/posts/offline`
- **权限**: 🔐 需登录 (仅作者)

### 2.9 投票
- **接口**: `POST /api/posts/vote`
- **权限**: 🔐 需登录
- **请求体**:
```json
{
  "postId": "string",
  "optionId": "string"
}
```

### 2.10 抽奖
- **接口**: `POST /api/posts/draw`
- **权限**: 🔐 需登录

### 2.11 采纳答案
- **接口**: `POST /api/posts/accept-answer`
- **权限**: 🔐 需登录 (仅作者)

### 2.12 置顶评论
- **接口**: `POST /api/posts/pin-comment`
- **权限**: 🔐 需登录 (仅作者)

### 2.13 神评论
- **接口**: `POST /api/posts/god-comment`
- **权限**: 🔐 需登录 (仅作者)

### 2.14 AI 分类
- **接口**: `POST /api/posts/ai-categorize`
- **权限**: 🔐 需登录

### 2.15 拍卖相关
- **出价**: `POST /api/posts/auction/bid`
- **出价列表**: `GET /api/posts/auction/bids`
- **参与者列表**: `GET /api/posts/auction/participants`

### 2.16 抽奖参与者
- **接口**: `GET /api/posts/lottery/participants`
- **权限**: 🌐 公开

---

## 3. 评论模块 (Comments)

### 3.1 获取评论列表
- **接口**: `GET /api/comments/list`
- **权限**: 🌐 公开 (根据站点设置)
- **查询参数**:
  - `postId`: 帖子ID (必填)
  - `page`: 页码
  - `sort`: oldest|newest
  - `view`: tree|flat
- **响应**:
```json
{
  "items": [],
  "flatItems": [],
  "total": 100,
  "page": 1,
  "pageSize": 20,
  "viewMode": "tree",
  "hasNextPage": true
}
```

### 3.2 创建评论
- **接口**: `POST /api/comments/create`
- **权限**: 🔐 需登录 (ACTIVE)
- **请求体**:
```json
{
  "postId": "string",
  "content": "string",
  "replyToCommentId": "string",
  "replyToUserId": 1,
  "isAnonymous": false,
  "isPrivate": false
}
```
- **响应**:
```json
{
  "id": "string",
  "reviewRequired": false,
  "navigation": {
    "page": 1,
    "sort": "oldest",
    "view": "tree",
    "anchor": "comment-123"
  }
}
```

### 3.3 更新评论
- **接口**: `POST /api/comments/update`
- **权限**: 🔐 需登录 (仅作者)

### 3.4 评论点赞
- **接口**: `POST /api/comments/like`
- **权限**: 🔐 需登录

### 3.5 评论打赏
- **接口**: `POST /api/comments/tip`
- **权限**: 🔐 需登录

### 3.6 评论下线
- **接口**: `POST /api/comments/offline`
- **权限**: 🔐 需登录 (仅作者)

---

## 4. 用户模块 (Users)

### 4.1 搜索用户
- **接口**: `GET /api/users/search`
- **权限**: 🔐 需登录
- **查询参数**:
  - `q`: 搜索关键词
  - `postId`: 帖子ID（可选，用于优先显示帖子作者）
- **响应**:
```json
{
  "users": [
    {
      "id": 1,
      "username": "string",
      "nickname": "string",
      "displayName": "string",
      "role": "USER",
      "isPostAuthor": false
    }
  ]
}
```

### 4.2 获取用户信息
- **接口**: `GET /api/users/[username]`
- **权限**: 🌐 公开

### 4.3 获取用户预览
- **接口**: `GET /api/users/[username]/preview`
- **权限**: 🌐 公开

### 4.4 获取用户收藏集
- **接口**: `GET /api/users/[username]/collections`
- **权限**: 🌐 公开

---

## 5. 个人资料模块 (Profile)

### 5.1 更新个人资料
- **接口**: `POST /api/profile/update`
- **权限**: 🔐 需登录
- **请求体**:
```json
{
  "nickname": "string",
  "bio": "string",
  "signature": "string",
  "gender": "string",
  "avatarPath": "string"
}
```

### 5.2 修改密码
- **接口**: `POST /api/profile/password`
- **权限**: 🔐 需登录
- **请求体**:
```json
{
  "oldPassword": "string",
  "newPassword": "string",
  "code": "string"
}
```

### 5.3 发送密码修改验证码
- **接口**: `POST /api/profile/password/send-code`
- **权限**: 🔐 需登录

### 5.4 通知设置
- **接口**: `POST /api/profile/notification-settings`
- **权限**: 🔐 需登录
- **请求体**:
```json
{
  "emailNotifications": true,
  "webhookUrl": "string",
  "notificationTypes": ["REPLY_POST", "LIKE", "MENTION"]
}
```

### 5.5 测试通知
- **接口**: `POST /api/profile/notification-settings/test`
- **权限**: 🔐 需登录

### 5.6 账号绑定 - OAuth
- **接口**: `POST /api/profile/account-bindings/oauth`
- **权限**: 🔐 需登录

### 5.7 账号绑定 - Passkey
- **接口**: `POST /api/profile/account-bindings/passkey`
- **权限**: 🔐 需登录

---

## 6. 节点/分区模块 (Boards/Zones)

### 6.1 关注节点
- **接口**: `POST /api/boards/follow`
- **权限**: 🔐 需登录
- **请求体**:
```json
{
  "boardId": "string"
}
```

### 6.2 获取节点帖子
- **接口**: `GET /api/boards/[slug]/posts`
- **权限**: 🌐 公开

### 6.3 获取分区帖子
- **接口**: `GET /api/zones/[slug]/posts`
- **权限**: 🌐 公开

---

## 7. 关注模块 (Follows)

### 7.1 关注/取消关注
- **接口**: `POST /api/follows/toggle`
- **权限**: 🔐 需登录
- **请求体**:
```json
{
  "targetType": "USER|BOARD|TAG|POST",
  "targetId": "string|number"
}
```

---

## 8. 屏蔽模块 (Blocks)

### 8.1 屏蔽/取消屏蔽用户
- **接口**: `POST /api/blocks/toggle`
- **权限**: 🔐 需登录
- **请求体**:
```json
{
  "blockedId": 1
}
```

---

## 9. 通知模块 (Notifications)

### 9.1 标记已读
- **接口**: `POST /api/notifications/read`
- **权限**: 🔐 需登录
- **请求体**:
```json
{
  "notificationId": "string"
}
```

### 9.2 全部标记已读
- **接口**: `POST /api/notifications/read-all`
- **权限**: 🔐 需登录

---

## 10. 消息模块 (Messages)

### 10.1 获取会话列表
- **接口**: `GET /api/messages/conversation`
- **权限**: 🔐 需登录

### 10.2 获取消息历史
- **接口**: `GET /api/messages/history`
- **权限**: 🔐 需登录
- **查询参数**:
  - `conversationId`: 会话ID
  - `before`: 时间戳

### 10.3 发送消息
- **接口**: `POST /api/messages/send`
- **权限**: 🔐 需登录
- **请求体**:
```json
{
  "recipientId": 1,
  "content": "string",
  "attachments": []
}
```

### 10.4 删除消息
- **接口**: `POST /api/messages/delete`
- **权限**: 🔐 需登录

### 10.5 标记已读
- **接口**: `POST /api/messages/read`
- **权限**: 🔐 需登录

### 10.6 消息流 (SSE)
- **接口**: `GET /api/messages/stream`
- **权限**: 🔐 需登录
- **说明**: Server-Sent Events 实时消息推送

### 10.7 上传消息附件
- **接口**: `POST /api/messages/upload`
- **权限**: 🔐 需登录
- **Content-Type**: `multipart/form-data`

### 10.8 获取消息文件
- **接口**: `GET /api/messages/files/[uploadId]`
- **权限**: 🔐 需登录

---

## 11. 签到模块 (Check-in)

### 11.1 签到
- **接口**: `POST /api/check-in`
- **权限**: 🔐 需登录
- **请求体**:
```json
{
  "补签": false
}
```

---

## 12. 积分/VIP 模块

### 12.1 VIP 信息
- **接口**: `GET /api/vip`
- **权限**: 🔐 需登录

### 12.2 积分充值
- **接口**: `POST /api/payments/topup`
- **权限**: 🔐 需登录

### 12.3 创建支付订单
- **接口**: `POST /api/payments/checkout`
- **权限**: 🔐 需登录

### 12.4 查询订单
- **接口**: `GET /api/payments/order`
- **权限**: 🔐 需登录

### 12.5 支付回调
- **接口**: `POST /api/payments/notify/[providerCode]`
- **权限**: 🌐 公开 (支付网关回调)

---

## 13. 勋章模块 (Badges)

### 13.1 领取勋章
- **接口**: `POST /api/badges/claim`
- **权限**: 🔐 需登录
- **请求体**:
```json
{
  "badgeCode": "string"
}
```

### 13.2 设置展示勋章
- **接口**: `POST /api/badges/display`
- **权限**: 🔐 需登录
- **请求体**:
```json
{
  "badgeCodes": ["badge1", "badge2", "badge3"]
}
```

---

## 14. 认证模块 (Verifications)

### 14.1 申请认证
- **接口**: `POST /api/verifications/apply`
- **权限**: 🔐 需登录

### 14.2 解绑认证
- **接口**: `POST /api/verifications/unbind`
- **权限**: 🔐 需登录

---

## 15. 邀请码模块 (Invite Codes)

### 15.1 我的邀请码
- **接口**: `GET /api/invite-codes/mine`
- **权限**: 🔐 需登录

### 15.2 购买邀请码
- **接口**: `POST /api/invite-codes/purchase`
- **权限**: 🔐 需登录

---

## 16. 兑换码模块 (Redeem Codes)

### 16.1 兑换
- **接口**: `POST /api/redeem-codes/redeem`
- **权限**: 🔐 需登录
- **请求体**:
```json
{
  "code": "string"
}
```

---

## 17. 举报模块 (Reports)

### 17.1 创建举报
- **接口**: `POST /api/reports/create`
- **权限**: 🔐 需登录
- **请求体**:
```json
{
  "targetType": "POST|COMMENT|USER",
  "targetId": "string",
  "reason": "string",
  "description": "string"
}
```

---

## 18. 收藏集模块 (Favorite Collections)

### 18.1 收藏集管理
- **接口**: `POST /api/favorite-collections`
- **权限**: 🔐 需登录
- **操作**: 创建、更新、删除收藏集

---

## 19. 上传模块 (Upload)

### 19.1 上传文件
- **接口**: `POST /api/upload`
- **权限**: 🔐 需登录
- **Content-Type**: `multipart/form-data`
- **字段**:
  - `file`: 文件
  - `type`: 类型 (avatar|post|attachment)

---

## 20. 帖子附件模块 (Post Attachments)

### 20.1 下载附件
- **接口**: `GET /api/post-attachments/download`
- **权限**: 🔐 需登录

### 20.2 购买附件
- **接口**: `POST /api/post-attachments/purchase`
- **权限**: 🔐 需登录

### 20.3 解锁附件
- **接口**: `POST /api/post-attachments/reveal`
- **权限**: 🔐 需登录

---

## 21. Feed 流模块

### 21.1 获取 Feed
- **接口**: `GET /api/feed`
- **权限**: 🔐 需登录
- **查询参数**:
  - `type`: following|hot|latest
  - `page`: 页码

---

## 22. 提及模块 (Mentions)

### 22.1 搜索可提及用户
- **接口**: `GET /api/mentions/search`
- **权限**: 🔐 需登录
- **查询参数**:
  - `q`: 搜索关键词
  - `postId`: 帖子ID

---

## 23. 友情链接模块 (Friend Links)

### 23.1 申请友链
- **接口**: `POST /api/friend-links/apply`
- **权限**: 🔐 需登录

---

## 24. 节点申请模块 (Board Applications)

### 24.1 申请节点
- **接口**: `POST /api/board-applications`
- **权限**: 🔐 需登录

### 24.2 节点金库
- **接口**: `GET /api/board-applications/treasury`
- **权限**: 🔐 需登录

---

## 25. RSS Universe 模块

### 25.1 获取 RSS 列表
- **接口**: `GET /api/rss-universe`
- **权限**: 🌐 公开

### 25.2 申请 RSS 源
- **接口**: `POST /api/rss-universe/apply`
- **权限**: 🔐 需登录

### 25.3 点赞 RSS 条目
- **接口**: `POST /api/rss-universe/like`
- **权限**: 🔐 需登录

### 25.4 打赏 RSS 条目
- **接口**: `POST /api/rss-universe/tip`
- **权限**: 🔐 需登录

---

## 26. 小游戏模块

### 26.1 五子棋
- **接口**: `POST /api/gobang`
- **权限**: 🔐 需登录

### 26.2 阴阳契
- **接口**: `POST /api/yinyang-contract`
- **权限**: 🔐 需登录

### 26.3 自助广告
- **接口**: `POST /api/self-serve-ads`
- **权限**: 🔐 需登录

---

## 附录

### HTTP 状态码

- `200`: 成功
- `400`: 请求参数错误
- `401`: 未登录
- `403`: 无权限
- `404`: 资源不存在
- `500`: 服务器错误

### 帖子类型 (PostType)

- `NORMAL`: 普通帖
- `BOUNTY`: 悬赏帖
- `POLL`: 投票帖
- `LOTTERY`: 抽奖帖
- `AUCTION`: 拍卖帖

### 帖子状态 (PostStatus)

- `NORMAL`: 正常
- `PENDING`: 待审核
- `LOCKED`: 锁定
- `OFFLINE`: 下线

### 通知类型 (NotificationType)

- `REPLY_POST`: 回复了你的帖子
- `REPLY_COMMENT`: 回复了你的评论
- `LIKE`: 点赞了你的内容
- `MENTION`: 提及了你
- `FOLLOWED_YOU`: 关注了你
- `FOLLOWING_ACTIVITY`: 你关注的人有新动态
- `SYSTEM`: 系统通知
- `REPORT_RESULT`: 举报处理结果

---

## 开发建议

1. **认证**: 使用 Cookie 存储 Session Token
2. **错误处理**: 统一处理 API 错误响应
3. **分页**: 大部分列表接口支持 `page` 和 `pageSize` 参数
4. **实时通信**: 消息模块支持 SSE (Server-Sent Events)
5. **文件上传**: 使用 `multipart/form-data` 格式
6. **图片处理**: 支持头像裁剪和水印
7. **状态检查**: 发帖和评论需要 ACTIVE 状态，点赞可以是 MUTED 状态

---

## 更新日志

- **2026-05-28**: 初始版本，整理所有用户 API 接口

