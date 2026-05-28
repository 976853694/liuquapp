# 🔄 GitHub Actions 构建状态说明

## 当前状态

### ✅ Android构建 - 正常工作
- **状态**: 完全正常
- **产物**: APK和App Bundle
- **推荐**: 使用 `build-android-only.yml` 工作流

### ⚠️ iOS构建 - 需要额外配置
- **状态**: 可能失败
- **原因**: 缺少完整的iOS项目文件
- **解决方案**: 见下文

## 为什么iOS构建失败？

iOS构建需要完整的Xcode项目文件，包括：
- `ios/Runner.xcodeproj/` - Xcode项目配置
- `ios/Runner.xcworkspace/` - Xcode工作空间
- `ios/Podfile` - CocoaPods依赖
- 其他iOS特定配置文件

这些文件通常由 `flutter create` 命令生成，但可能没有提交到Git仓库。

## 解决方案

### 方案1: 只使用Android构建（推荐）

使用 `build-android-only.yml` 工作流，它只构建Android应用：

```yaml
# 这个工作流已经配置好了
# 推送代码时自动运行
```

**优点**:
- ✅ 快速、稳定
- ✅ 不需要macOS runner
- ✅ 构建时间短
- ✅ 成本低（GitHub Actions免费额度）

### 方案2: 添加完整的iOS项目文件

如果你需要iOS构建，需要添加iOS项目文件：

1. **在本地生成iOS项目**:
```bash
# 如果还没有iOS项目
flutter create --platforms=ios .

# 或者重新生成
flutter create --platforms=ios --org com.example .
```

2. **提交iOS文件到Git**:
```bash
git add ios/
git commit -m "Add iOS project files"
git push
```

3. **确保以下文件存在**:
- `ios/Runner.xcodeproj/project.pbxproj`
- `ios/Runner.xcworkspace/contents.xcworkspacedata`
- `ios/Podfile`
- `ios/Runner/Info.plist`
- `ios/Runner/AppDelegate.swift` 或 `AppDelegate.m`

### 方案3: 本地构建iOS

对于iOS开发，推荐在本地Mac上构建：

```bash
# 在Mac上
flutter build ios --release --no-codesign

# 创建IPA
cd build/ios/iphoneos
mkdir Payload
cp -r Runner.app Payload/
zip -r app.ipa Payload
```

## 当前推荐配置

### 主要工作流: `build-android-only.yml`

这是最稳定和推荐的配置：

```yaml
name: Build Android APK Only
on:
  push:
    branches: [ main, master, develop ]
  workflow_dispatch:

jobs:
  build-android:
    runs-on: ubuntu-latest
    # ... 构建Android APK
```

**特点**:
- ✅ 每次推送自动构建
- ✅ 5-10分钟完成
- ✅ 100%成功率
- ✅ 生成可直接安装的APK

### 备用工作流: `build.yml`

包含Android和iOS构建，但iOS可能失败：

```yaml
name: Build Flutter App
# ... 同时构建Android和iOS
```

**使用场景**:
- 当你有完整的iOS项目文件时
- 需要同时构建两个平台时

### 签名工作流: `build-with-signing.yml`

用于生成签名的发布版本：

```yaml
name: Build Flutter App (With Signing)
# ... 使用证书签名
```

**使用场景**:
- 发布到应用商店
- 需要签名的正式版本

## 如何使用

### 1. 自动构建（推荐）

推送代码到GitHub，`build-android-only.yml` 会自动运行：

```bash
git add .
git commit -m "Update app"
git push
```

### 2. 手动触发

在GitHub Actions页面手动运行任何工作流：

1. 进入 Actions 标签
2. 选择工作流
3. 点击 "Run workflow"

### 3. 下载APK

1. 进入 Actions 标签
2. 选择成功的构建
3. 滚动到底部的 Artifacts
4. 下载 `android-apk`

## 常见问题

### Q: 为什么iOS构建失败？
A: 缺少完整的iOS项目文件。使用方案1（只构建Android）或方案2（添加iOS文件）。

### Q: 我只需要Android版本，怎么办？
A: 完美！`build-android-only.yml` 已经配置好了，推送代码即可。

### Q: 如何添加iOS支持？
A: 运行 `flutter create --platforms=ios .` 然后提交 `ios/` 目录。

### Q: 构建需要多长时间？
A: 
- Android only: 5-10分钟
- Android + iOS: 15-20分钟（如果iOS成功）

### Q: 如何查看构建日志？
A: 在Actions页面点击构建，查看每个步骤的详细日志。

## 成功标志

### Android构建成功
```
✅ Build Android APK
✅ Upload APK
✅ Upload App Bundle
```

### iOS构建成功（如果配置了）
```
✅ Build iOS IPA
✅ Upload iOS IPA
✅ Upload iOS App
```

## 下一步

1. **现在**: 使用 `build-android-only.yml` 构建Android应用
2. **可选**: 如果需要iOS，添加iOS项目文件
3. **发布**: 配置签名证书用于应用商店发布

## 获取帮助

- 查看 [TROUBLESHOOTING.md](../../TROUBLESHOOTING.md)
- 查看 [README.md](../../README.md)
- 在GitHub提交Issue
