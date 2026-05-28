# 发现 APP - Flutter 社交分享应用 ✨

这是一个类似小红书的社交分享应用UI实现，具有精美的动画效果和毛玻璃设计。

[![Build Status](https://github.com/yourusername/discover_app/workflows/Build%20Flutter%20App/badge.svg)](https://github.com/yourusername/discover_app/actions)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.24.0-blue.svg)](https://flutter.dev/)

## 📖 文档导航

- 🚀 [快速开始](QUICKSTART.md) - 本地开发和构建指南
- 📱 [安装指南](INSTALL.md) - 详细的应用安装说明
- 🔧 [CI/CD说明](.github/workflows/README.md) - GitHub Actions工作流文档

## 🎨 功能特点

- ✅ 首页展示（带动态Banner和分类标签）
- ✅ 帖子卡片展示（毛玻璃效果）
- ✅ 动画底部导航栏（毛玻璃效果）
- ✅ 用户信息展示
- ✅ 互动数据（浏览、评论、点赞）
- ✅ 丰富的动画效果
- ✅ 毛玻璃（Backdrop Filter）设计

## ✨ 动画效果

### 1. Banner卡片动画
- 🔄 循环缩放动画（4秒周期）
- 💫 动态装饰圆点（呼吸效果）
- 🌀 旋转动画
- 🎭 毛玻璃文字容器
- 🌈 渐变背景

### 2. 分类标签动画
- 📍 平滑的选中状态切换
- 📏 动态下划线展开/收缩
- 💡 文字大小和粗细动画
- ✨ 阴影效果

### 3. 帖子卡片动画
- 🎬 淡入淡出效果（FadeTransition）
- 📱 滑动进入效果（SlideTransition）
- 💖 点赞按钮动画（缩放+颜色变化）
- 🖼️ Hero动画（头像和图片）
- 🌫️ 毛玻璃卡片背景
- 🎨 渐变图片占位符

### 4. 底部导航栏动画
- 🎯 图标切换动画（ScaleTransition）
- 🔘 FAB按钮呼吸动画
- 🌊 毛玻璃导航栏背景
- 📝 发布弹窗（毛玻璃底部表单）
- 🎪 页面切换淡入淡出

## 📁 项目结构

```
lib/
├── main.dart                      # 应用入口和主导航
├── models/
│   └── post.dart                 # 帖子数据模型
├── screens/
│   └── home_screen.dart          # 首页
└── widgets/
    ├── banner_card.dart          # Banner卡片组件（动画+毛玻璃）
    ├── category_tabs.dart        # 分类标签组件（动画）
    ├── post_card.dart            # 帖子卡片组件（动画+毛玻璃）
    └── animated_bottom_nav.dart  # 动画底部导航栏（毛玻璃）
```

## 运行项目

1. 确保已安装 Flutter SDK
2. 在项目根目录运行：

```bash
flutter pub get
flutter run
```

## 🎯 已实现的UI组件

### 1. 动态Banner卡片
- 🌈 绿色渐变背景
- 📝 大标题"狐书-发现"
- 💬 副标题"每一种兴趣"
- 🎪 动态装饰圆点（呼吸+缩放动画）
- 🌫️ 毛玻璃文字容器
- 🔄 4秒循环动画

### 2. 动画分类标签
- 📜 横向滚动
- 🏷️ 包含：推荐、二次元、旅行、生活、绘画、摄影
- 📍 选中状态带动画下划线
- ✨ 文字大小和颜色平滑过渡
- 💫 阴影效果

### 3. 毛玻璃帖子卡片
- 👤 用户头像（Hero动画）
- ⏰ 发布时间
- 📄 文字内容
- 🖼️ 图片网格（支持1-3张，Hero动画）
- 📊 互动数据（浏览、评论、点赞）
- 💖 点赞按钮动画（缩放+颜色变化）
- 🌫️ 毛玻璃卡片背景
- 🎬 淡入+滑动进入动画

### 4. 毛玻璃底部导航
- 🧭 发现、话题、发布、消息、我
- 🎯 图标切换动画
- 🔘 绿色圆形FAB（呼吸动画）
- 🌊 毛玻璃背景
- 📝 发布弹窗（毛玻璃底部表单）
- 🎨 圆角设计

## 🚀 CI/CD 自动构建

本项目配置了GitHub Actions自动构建工作流：

### 自动构建（推送代码时）
- ✅ Android APK（可直接安装）
- ✅ Android App Bundle
- ✅ iOS IPA（未签名）

### 手动构建（支持签名）
1. 进入GitHub仓库的 "Actions" 标签
2. 选择 "Build Flutter App" 或 "Build Flutter App (With Signing)"
3. 点击 "Run workflow"
4. 下载构建产物

详细说明请查看：[.github/workflows/README.md](.github/workflows/README.md)

## 📱 安装方法

### Android
1. 下载APK文件
2. 启用"未知来源"安装
3. 直接安装

### iOS
1. 下载IPA文件
2. 使用以下工具之一安装：
   - **AltStore**（推荐，无需越狱）
   - **Sideloadly**（推荐，无需越狱）
   - **Xcode**（开发者）
   - **AppSync Unified**（越狱设备）

## 下一步开发建议

1. 添加真实图片加载（使用 cached_network_image）
2. 实现下拉刷新和上拉加载
3. 添加帖子详情页
4. 实现发布功能
5. 添加用户个人主页
6. 集成后端API
7. 添加搜索功能
8. 实现评论和点赞功能

## 🛠️ 技术栈

- Flutter 3.0+
- Material Design
- 纯Dart实现，无第三方UI库依赖
- BackdropFilter（毛玻璃效果）
- AnimationController（动画控制）
- Hero动画（页面转场）
- SingleTickerProviderStateMixin（动画混入）
- TickerProviderStateMixin（多动画混入）

## 🎨 核心技术

### 毛玻璃效果（Backdrop Filter）
```dart
BackdropFilter(
  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
  child: Container(
    color: Colors.white.withOpacity(0.9),
  ),
)
```

### 动画控制器
```dart
AnimationController(
  duration: const Duration(seconds: 4),
  vsync: this,
)..repeat(reverse: true);
```

### Hero动画
```dart
Hero(
  tag: 'avatar_${post.id}',
  child: CircleAvatar(...),
)
```
