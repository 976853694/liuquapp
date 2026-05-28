# GitHub Actions 工作流说明

## 📦 主工作流：`build-app.yml`

这是唯一启用的工作流，用于同时构建Android和iOS应用。

### 触发条件

- ✅ 推送到 `main`、`master` 或 `develop` 分支
- ✅ Pull Request
- ✅ 手动触发

### 构建产物

- ✅ **Android APK** - 可直接安装
- ✅ **Android App Bundle** - 用于Google Play
- ✅ **iOS IPA** - 未签名，需要重新签名

### 特点

- 🍎 使用macOS runner以支持iOS构建
- 🤖 自动构建Android APK和App Bundle
- 📦 自动创建iOS项目文件（如果不存在）
- 🔄 自动安装CocoaPods依赖
- 📊 详细的构建摘要

## 🚀 使用方法

### 自动构建（推荐）

推送代码到GitHub：

```bash
git add .
git commit -m "Update app"
git push
```

GitHub Actions会自动开始构建，大约15-20分钟后完成。

### 手动触发

1. 进入GitHub仓库
2. 点击 "Actions" 标签
3. 选择 "Build App" 工作流
4. 点击 "Run workflow"
5. （可选）输入构建号
6. 点击绿色的 "Run workflow" 按钮

### 下载构建产物

1. 进入 [Actions](https://github.com/976853694/liuquapp/actions) 页面
2. 选择最新的成功构建（绿色✅）
3. 滚动到页面底部的 "Artifacts" 部分
4. 下载需要的文件：
   - `android-apk` - Android安装包
   - `android-appbundle` - Android App Bundle
   - `ios-ipa-unsigned` - iOS安装包（未签名）

## � 安装说明

### Android安装

1. 下载 `android-apk` 并解压
2. 在Android设备上启用"未知来源"安装
3. 传输APK到设备并安装

或使用ADB：
```bash
adb install app-release.apk
```

### iOS安装

iOS应用需要重新签名才能安装。推荐工具：

- **AltStore**（无需越狱）- [altstore.io](https://altstore.io/)
- **Sideloadly**（无需越狱）- [sideloadly.io](https://sideloadly.io/)
- **Xcode**（开发者）

详细说明请查看 [INSTALL.md](../../INSTALL.md)

## � 工作流详情

### 构建步骤

1. **准备环境**
   - 检出代码
   - 安装Java 17
   - 安装Flutter 3.24.0

2. **代码检查**
   - 获取依赖
   - 代码分析
   - 运行测试

3. **Android构建**
   - 创建local.properties
   - 构建APK
   - 构建App Bundle
   - 上传产物

4. **iOS构建**
   - 检查iOS项目文件
   - 如果需要，创建iOS项目
   - 安装CocoaPods依赖
   - 构建iOS应用（无签名）
   - 创建IPA
   - 上传产物

5. **构建摘要**
   - 显示构建结果
   - 显示文件大小
   - 提供安装说明

## ⏱️ 构建时间

- **总时间**: 约15-20分钟
- **Android构建**: 约5-8分钟
- **iOS构建**: 约10-12分钟

## 💰 成本

- **公开仓库**: 免费，无限制
- **私有仓库**: 使用GitHub Actions免费额度（2000分钟/月）
- **macOS runner**: 消耗10倍分钟数（1分钟 = 10分钟额度）

## 📊 构建状态

在README中添加状态徽章：

```markdown
[![Build Status](https://github.com/976853694/liuquapp/workflows/Build%20App/badge.svg)](https://github.com/976853694/liuquapp/actions)
```

效果：
[![Build Status](https://github.com/976853694/liuquapp/workflows/Build%20App/badge.svg)](https://github.com/976853694/liuquapp/actions)

## 🐛 故障排除

### Android构建失败

**常见原因**：
- Gradle配置错误
- Java版本不匹配
- 依赖冲突

**解决方案**：
```bash
flutter clean
flutter pub get
flutter build apk --release
```

### iOS构建失败

**常见原因**：
- CocoaPods依赖问题
- Xcode配置错误
- 签名问题

**解决方案**：
```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter build ios --release --no-codesign
```

### 无法下载Artifacts

**原因**：
- 构建未完成
- Artifacts已过期（30天）

**解决方案**：
- 等待构建完成
- 重新触发构建

## 📚 相关文档

- [INSTALL.md](../../INSTALL.md) - 详细的安装指南
- [TROUBLESHOOTING.md](../../TROUBLESHOOTING.md) - 故障排除指南
- [QUICKSTART.md](../../QUICKSTART.md) - 快速开始指南

## 🔐 签名构建（可选）

如果需要签名的发布版本，可以使用 `build-with-signing.yml` 工作流。

需要在GitHub Secrets中配置：

### Android签名
- `ANDROID_KEYSTORE_BASE64`
- `ANDROID_KEYSTORE_PASSWORD`
- `ANDROID_KEY_ALIAS`
- `ANDROID_KEY_PASSWORD`

### iOS签名
- `IOS_CERTIFICATE_BASE64`
- `IOS_CERTIFICATE_PASSWORD`
- `IOS_PROVISIONING_PROFILE_BASE64`

## 💡 最佳实践

1. **开发阶段**: 使用自动构建，每次推送都会构建
2. **测试阶段**: 下载Artifacts进行测试
3. **发布阶段**: 使用签名构建工作流

## 🎯 总结

- ✅ 一个工作流同时构建Android和iOS
- ✅ 自动触发，无需手动操作
- ✅ 15-20分钟完成构建
- ✅ 生成可安装的APK和IPA
- ✅ 详细的构建摘要和日志

现在推送代码，让GitHub Actions自动构建你的应用吧！🚀
