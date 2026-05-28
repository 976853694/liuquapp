# Rhex 管理后台 API 接口文档

> 本文档包含所有管理后台 API 接口，需要管理员或版主权限

## 基础信息

- **Base URL**: `https://your-domain.com/api/admin`
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

### 用户角色 (UserRole)
- **MODERATOR**: 版主 - 可以管理指定节点/分区的内容
- **ADMIN**: 管理员 - 拥有所有权限

### 权限标识
- 👮 **版主权限** - MODERATOR 或 ADMIN 可访问
- 👑 **管理员权限** - 仅 ADMIN 可访问

### 版主权限范围
版主只能管理被授权的节点/分区内的内容：
- 帖子管理（批量操作、标签管理）
- 评论管理（批量操作）
- 结构管理（节点/分区设置）

### 管理员专属功能
- 用户管理
- 系统设置
- 勋章/等级/认证管理
- 邀请码/兑换码管理
- 敏感词管理
- 插件管理
- 应用配置

---

## 1. 管理操作 (Actions)

### 1.1 执行管理操作
- **接口**: `POST /api/admin/actions`
- **权限**: 👮 版主/管理员
- **说明**: 统一的管理操作入口，支持多种操作类型
- **请求体**:
```json
{
  "action": "user.ban|user.mute|post.hide|comment.delete|...",
  "targetId": "string",
  "message": "操作原因/备注"
}
```

### 1.2 支持的操作类型

#### 用户操作 (👑 仅管理员)
- `user.ban` - 拉黑用户
- `user.mute` - 禁言用户
- `user.unmute` - 解除禁言
- `user.delete` - 删除用户
- `user.updateRole` - 更新用户角色
- `user.updateStatus` - 更新用户状态
- `user.updateVip` - 更新 VIP
- `user.updatePoints` - 更新积分

#### 帖子操作 (👮 版主/管理员)
- `post.hide` - 隐藏帖子
- `post.show` - 显示帖子
- `post.lock` - 锁定帖子
- `post.unlock` - 解锁帖子
- `post.delete` - 删除帖子
- `post.moveBoard` - 移动到其他节点

#### 评论操作 (👮 版主/管理员)
- `comment.approve` - 审核通过
- `comment.reject` - 审核拒绝
- `comment.hide` - 隐藏评论
- `comment.show` - 显示评论
- `comment.delete` - 删除评论
- `comment.markGod` - 标记神评论
- `comment.unmarkGod` - 取消神评论

---

## 2. 用户管理

### 2.1 获取用户详情
- **接口**: `GET /api/admin/users/detail`
- **权限**: 👑 管理员
- **查询参数**:
  - `userId`: 用户ID (必填)
- **响应**:
```json
{
  "user": {
    "id": 1,
    "username": "string",
    "email": "string",
    "phone": "string",
    "role": "USER|MODERATOR|ADMIN",
    "status": "ACTIVE|MUTED|BANNED",
    "points": 100,
    "level": 5,
    "vipLevel": 0,
    "postCount": 50,
    "commentCount": 200,
    "likeReceivedCount": 100,
    "inviteCount": 10,
    "createdAt": "2024-01-01T00:00:00Z",
    "lastLoginAt": "2024-01-01T00:00:00Z",
    "lastLoginIp": "127.0.0.1"
  },
  "stats": {
    "totalPosts": 50,
    "totalComments": 200,
    "totalLikes": 100
  },
  "recentPosts": [],
  "recentComments": [],
  "loginHistory": []
}
```

---

## 3. 帖子管理

### 3.1 批量操作帖子
- **接口**: `POST /api/admin/posts/bulk`
- **权限**: 👮 版主/管理员
- **请求体**:
```json
{
  "action": "post.hide|post.show|post.lock|post.unlock|post.delete|post.moveBoard",
  "postIds": ["post1", "post2", "post3"],
  "message": "操作原因",
  "boardSlug": "target-board"
}
```
- **限制**: 单次最多处理 100 篇帖子
- **响应**:
```json
{
  "successCount": 10,
  "failedCount": 0,
  "failures": [
    {
      "postId": "post1",
      "message": "错误信息"
    }
  ]
}
```

### 3.2 管理帖子标签
- **接口**: `POST /api/admin/posts/tags`
- **权限**: 👮 版主/管理员
- **请求体**:
```json
{
  "postId": "string",
  "tags": ["tag1", "tag2", "tag3"]
}
```

---

## 4. 评论管理

### 4.1 批量操作评论
- **接口**: `POST /api/admin/comments/bulk`
- **权限**: 👮 版主/管理员
- **请求体**:
```json
{
  "action": "comment.approve|comment.reject|comment.hide|comment.show|comment.delete|comment.markGod|comment.unmarkGod",
  "commentIds": ["comment1", "comment2"],
  "message": "操作原因"
}
```
- **限制**: 单次最多处理 100 条评论
- **响应**:
```json
{
  "successCount": 10,
  "failedCount": 0,
  "failures": []
}
```

---

## 5. 结构管理 (分区/节点)

### 5.1 创建结构
- **接口**: `POST /api/admin/structure`
- **权限**: 👮 版主/管理员
- **请求体**:
```json
{
  "type": "zone|board",
  "name": "string",
  "slug": "string",
  "description": "string",
  "zoneId": "string",
  "sortOrder": 0,
  "status": "ACTIVE|HIDDEN|DISABLED",
  "allowPost": true,
  "allowUserPost": true,
  "allowUserReply": true,
  "requirePostReview": false,
  "requireCommentReview": false,
  "postPointDelta": 0,
  "replyPointDelta": 0,
  "minViewLevel": 0,
  "minPostLevel": 0,
  "minReplyLevel": 0
}
```

### 5.2 更新结构
- **接口**: `PUT /api/admin/structure`
- **权限**: 👮 版主/管理员
- **请求体**: 同创建，需包含 `id` 字段

### 5.3 删除结构
- **接口**: `DELETE /api/admin/structure`
- **权限**: 👮 版主/管理员
- **请求体**:
```json
{
  "type": "zone|board",
  "id": "string"
}
```

### 5.4 添加版主
- **接口**: `POST /api/admin/structure/moderators`
- **权限**: 👑 管理员
- **请求体**:
```json
{
  "moderatorId": 1,
  "scopeType": "zone|board",
  "scopeId": "string",
  "canEditSettings": false,
  "canWithdrawTreasury": true
}
```

### 5.5 移除版主
- **接口**: `DELETE /api/admin/structure/moderators`
- **权限**: 👑 管理员
- **请求体**:
```json
{
  "scopeId": "string"
}
```

### 5.6 更新版主权限
- **接口**: `POST /api/admin/moderator-scopes`
- **权限**: 👑 管理员
- **请求体**:
```json
{
  "userId": 1,
  "scopes": [
    {
      "type": "zone|board",
      "id": "string",
      "permissions": ["edit", "withdraw"]
    }
  ]
}
```

---

## 6. 系统设置

### 6.1 获取站点设置
- **接口**: `GET /api/admin/site-settings`
- **权限**: 👑 管理员
- **响应**: 完整的站点配置对象

### 6.2 更新站点设置
- **接口**: `POST /api/admin/site-settings`
- **权限**: 👑 管理员
- **请求体**:
```json
{
  "section": "basic|registration|interaction|upload|vip|...",
  "settings": {
    "siteName": "string",
    "siteDescription": "string",
    "allowRegister": true,
    "requireInviteCode": false,
    "guestCanViewComments": true,
    "commentPageSize": 20
  }
}
```

### 6.3 清除缓存
- **接口**: `POST /api/admin/site-settings/cache`
- **权限**: 👑 管理员
- **说明**: 清除站点设置缓存

### 6.4 上传站点图标
- **接口**: `POST /api/admin/site-settings/icon-upload`
- **权限**: 👑 管理员
- **Content-Type**: `multipart/form-data`
- **字段**:
  - `file`: 图标文件 (支持 .svg, .png, .jpg, .ico)

### 6.5 Markdown 表情上传
- **接口**: `POST /api/admin/site-settings/markdown-emoji/upload`
- **权限**: 👑 管理员
- **Content-Type**: `multipart/form-data`

### 6.6 SMTP 测试
- **接口**: `POST /api/admin/site-settings/smtp-test`
- **权限**: 👑 管理员
- **请求体**:
```json
{
  "recipient": "test@example.com"
}
```

### 6.7 水印预览
- **接口**: `GET /api/admin/site-settings/watermark-preview`
- **权限**: 👑 管理员
- **查询参数**:
  - `text`: 水印文字
  - `opacity`: 透明度

---

## 7. 公告管理

### 7.1 获取公告列表
- **接口**: `GET /api/admin/announcements`
- **权限**: 👑 管理员

### 7.2 创建/更新公告
- **接口**: `POST /api/admin/announcements`
- **权限**: 👑 管理员
- **请求体**:
```json
{
  "action": "save|delete|toggle-pin|update-status",
  "id": "string",
  "type": "ANNOUNCEMENT|HELP",
  "title": "string",
  "content": "string",
  "sourceType": "DOCUMENT|LINK",
  "slug": "string",
  "linkUrl": "string",
  "titleColor": "#000000",
  "titleBold": false,
  "status": "DRAFT|PUBLISHED|OFFLINE",
  "isPinned": false
}
```

---

## 8. 勋章管理

### 8.1 获取勋章列表
- **接口**: `GET /api/admin/badges`
- **权限**: 👑 管理员
- **响应**:
```json
[
  {
    "id": "string",
    "name": "string",
    "code": "string",
    "description": "string",
    "iconPath": "string",
    "iconText": "🏅",
    "color": "#f59e0b",
    "category": "社区成就",
    "pointsCost": 0,
    "status": true,
    "isHidden": false,
    "grantedUserCount": 100,
    "rules": [],
    "effects": []
  }
]
```

### 8.2 创建勋章
- **接口**: `POST /api/admin/badges`
- **权限**: 👑 管理员
- **请求体**:
```json
{
  "name": "string",
  "code": "string",
  "description": "string",
  "iconPath": "string",
  "iconText": "🏅",
  "color": "#f59e0b",
  "imageUrl": "string",
  "category": "社区成就",
  "sortOrder": 0,
  "pointsCost": 0,
  "status": true,
  "isHidden": false,
  "rules": [
    {
      "ruleType": "POST_COUNT|COMMENT_COUNT|RECEIVED_LIKE_COUNT|...",
      "operator": "GT|GTE|EQ|LT|LTE|BETWEEN",
      "value": "100",
      "extraValue": null,
      "sortOrder": 0
    }
  ],
  "effects": [
    {
      "name": "积分加成",
      "description": "发帖积分 +10%",
      "targetType": "POINTS|PROBABILITY|FUNCTION",
      "scopeKeys": ["post.create", "comment.create"],
      "ruleKind": "FIXED|PERCENTAGE|RANDOM_FIXED|...",
      "direction": "BUFF|NERF",
      "value": 10,
      "extraValue": null,
      "startMinuteOfDay": null,
      "endMinuteOfDay": null,
      "sortOrder": 0,
      "status": true
    }
  ]
}
```

### 8.3 更新勋章
- **接口**: `PUT /api/admin/badges`
- **权限**: 👑 管理员
- **请求体**: 同创建，需包含 `id` 字段

### 8.4 删除勋章
- **接口**: `DELETE /api/admin/badges`
- **权限**: 👑 管理员
- **请求体**:
```json
{
  "id": "string"
}
```

---

## 9. 等级管理

### 9.1 获取等级列表
- **接口**: `GET /api/admin/levels`
- **权限**: 👑 管理员

### 9.2 保存等级设置
- **接口**: `POST /api/admin/levels`
- **权限**: 👑 管理员
- **请求体**:
```json
{
  "action": "save|refresh-all-users",
  "levels": [
    {
      "level": 1,
      "name": "新手",
      "color": "#64748b",
      "icon": "⭐",
      "requireCheckInDays": 0,
      "requirePostCount": 0,
      "requireCommentCount": 0,
      "requireLikeCount": 0
    }
  ]
}
```

---

## 10. 认证管理

### 10.1 获取认证列表
- **接口**: `GET /api/admin/verifications`
- **权限**: 👑 管理员

### 10.2 创建认证类型
- **接口**: `POST /api/admin/verifications`
- **权限**: 👑 管理员
- **请求体**:
```json
{
  "name": "string",
  "code": "string",
  "description": "string",
  "iconPath": "string",
  "color": "#3b82f6",
  "requireReview": true
}
```

### 10.3 更新认证/审核
- **接口**: `PUT /api/admin/verifications`
- **权限**: 👑 管理员
- **请求体**:
```json
{
  "action": "update-type|review-application",
  "id": "string",
  "status": "APPROVED|REJECTED",
  "message": "审核意见"
}
```

### 10.4 删除认证类型
- **接口**: `DELETE /api/admin/verifications`
- **权限**: 👑 管理员

---

## 11. 任务中心

### 11.1 获取任务列表
- **接口**: `GET /api/admin/tasks`
- **权限**: 👑 管理员

### 11.2 创建/更新任务
- **接口**: `POST /api/admin/tasks`
- **权限**: 👑 管理员
- **请求体**:
```json
{
  "action": "save|duplicate|update-status",
  "id": "string",
  "name": "string",
  "description": "string",
  "category": "NEWBIE|DAILY|CHALLENGE",
  "cycleType": "PERMANENT|DAILY|WEEKLY",
  "sortOrder": 0,
  "status": "ACTIVE|PAUSED|ARCHIVED",
  "conditions": [
    {
      "type": "CHECK_IN_COUNT|POST_COUNT|COMMENT_COUNT|...",
      "value": 1
    }
  ],
  "rewards": {
    "points": 10,
    "vipDays": 0
  }
}
```

---

## 12. 邀请码管理

### 12.1 获取邀请码列表
- **接口**: `GET /api/admin/invite-codes`
- **权限**: 👑 管理员

### 12.2 生成邀请码
- **接口**: `POST /api/admin/invite-codes`
- **权限**: 👑 管理员
- **请求体**:
```json
{
  "count": 10,
  "note": "备注"
}
```
- **限制**: 单次最多生成 100 个

### 12.3 删除邀请码
- **接口**: `DELETE /api/admin/invite-codes`
- **权限**: 👑 管理员
- **请求体**:
```json
{
  "scope": "single|used|unused|all",
  "id": "string"
}
```

---

## 13. 兑换码管理

### 13.1 获取兑换码列表
- **接口**: `GET /api/admin/redeem-codes`
- **权限**: 👑 管理员

### 13.2 生成兑换码
- **接口**: `POST /api/admin/redeem-codes`
- **权限**: 👑 管理员
- **请求体**:
```json
{
  "count": 10,
  "points": 100,
  "codeCategory": "活动奖励",
  "categoryUserLimit": 1,
  "note": "备注",
  "expiresAt": "2024-12-31 23:59:59"
}
```
- **限制**: 单次最多生成 100 个

### 13.3 删除兑换码
- **接口**: `DELETE /api/admin/redeem-codes`
- **权限**: 👑 管理员
- **请求体**:
```json
{
  "scope": "single|used|unused|all",
  "id": "string"
}
```

---

## 14. 敏感词管理

### 14.1 创建敏感词规则
- **接口**: `POST /api/admin/sensitive-words`
- **权限**: 👑 管理员
- **请求体**:
```json
{
  "word": "string",
  "words": ["word1", "word2", "word3"],
  "matchType": "EXACT|CONTAINS|REGEX",
  "actionType": "REJECT|REPLACE|REVIEW"
}
```

### 14.2 更新敏感词状态
- **接口**: `PUT /api/admin/sensitive-words`
- **权限**: 👑 管理员
- **请求体**:
```json
{
  "id": "string",
  "status": true
}
```

### 14.3 删除敏感词
- **接口**: `DELETE /api/admin/sensitive-words`
- **权限**: 👑 管理员
- **请求体**:
```json
{
  "id": "string",
  "ids": ["id1", "id2", "id3"]
}
```

---

## 15. 友链管理

### 15.1 创建/审核友链
- **接口**: `POST /api/admin/friend-links`
- **权限**: 👑 管理员
- **请求体**:
```json
{
  "action": "create|approve|reject",
  "id": "string",
  "name": "string",
  "url": "string",
  "logo": "string",
  "description": "string"
}
```

---

## 16. 自定义页面

### 16.1 获取自定义页面列表
- **接口**: `GET /api/admin/custom-pages`
- **权限**: 👑 管理员

### 16.2 创建/更新自定义页面
- **接口**: `POST /api/admin/custom-pages`
- **权限**: 👑 管理员
- **请求体**:
```json
{
  "action": "save|delete|update-status",
  "id": "string",
  "title": "string",
  "slug": "string",
  "content": "string",
  "status": "DRAFT|PUBLISHED"
}
```

---

## 17. 附件管理

### 17.1 获取附件列表
- **接口**: `GET /api/admin/attachments`
- **权限**: 👑 管理员
- **查询参数**:
  - `page`: 页码
  - `pageSize`: 每页数量
  - `type`: 附件类型

---

## 18. 节点申请审核

### 18.1 审核节点申请
- **接口**: `POST /api/admin/board-applications`
- **权限**: 👑 管理员
- **请求体**:
```json
{
  "action": "approve|reject|update",
  "id": "string",
  "message": "审核意见"
}
```

---

## 19. 插件管理

### 19.1 获取插件列表
- **接口**: `GET /api/admin/addons`
- **权限**: 👑 管理员

### 19.2 安装插件
- **接口**: `POST /api/admin/addons/install`
- **权限**: 👑 管理员
- **Content-Type**: `multipart/form-data`
- **字段**:
  - `file`: 插件压缩包

### 19.3 插件操作
- **接口**: `POST /api/admin/addons/[addonId]`
- **权限**: 👑 管理员
- **操作**: 启用、禁用、卸载、配置

---

## 20. 应用管理

### 20.1 AI 回复配置
- **接口**: `POST /api/admin/apps/ai-reply`
- **权限**: 👑 管理员
- **请求体**:
```json
{
  "enabled": true,
  "apiKey": "string",
  "model": "string",
  "agentUserId": 1,
  "systemPrompt": "string"
}
```

### 20.2 RSS 抓取配置
- **接口**: `POST /api/admin/apps/rss-harvest`
- **权限**: 👑 管理员

### 20.3 五子棋配置
- **接口**: `POST /api/admin/apps/gobang`
- **权限**: 👑 管理员

### 20.4 阴阳契配置
- **接口**: `POST /api/admin/apps/yinyang-contract`
- **权限**: 👑 管理员

### 20.5 自助广告配置
- **接口**: `POST /api/admin/apps/self-serve-ads`
- **权限**: 👑 管理员

### 20.6 支付网关配置
- **接口**: `POST /api/admin/apps/payment-gateway`
- **权限**: 👑 管理员

---

## 附录

### HTTP 状态码

- `200`: 成功
- `400`: 请求参数错误
- `401`: 未登录
- `403`: 无权限（非管理员/版主）
- `404`: 资源不存在
- `500`: 服务器错误

### 批量操作限制

- 帖子批量操作: 最多 100 篇
- 评论批量操作: 最多 100 条
- 邀请码生成: 最多 100 个
- 兑换码生成: 最多 100 个

### 版主权限范围

版主只能管理被授权的节点/分区：
- 可以执行的操作: 帖子管理、评论管理、结构设置
- 不能执行的操作: 用户管理、系统设置、全局配置

### 管理日志

所有管理操作都会记录日志：
- 操作人
- 操作类型
- 目标对象
- 操作时间
- IP 地址
- 操作详情

---

## 开发建议

1. **权限检查**: 每个接口都会验证用户角色和权限
2. **批量操作**: 使用批量接口提高效率，注意单次限制
3. **错误处理**: 批量操作会返回成功和失败的详细信息
4. **日志记录**: 重要操作会自动记录到管理日志
5. **缓存管理**: 修改设置后注意清除相关缓存
6. **版主授权**: 添加版主时需要指定具体的节点/分区范围

---

## 更新日志

- **2026-05-28**: 初始版本，整理所有管理后台 API 接口

