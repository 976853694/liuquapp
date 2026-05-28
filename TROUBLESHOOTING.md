# 🔧 故障排除指南

本文档列出了常见问题及其解决方案。

## 📱 构建问题

### Android构建失败

#### 问题1: "Build failed due to use of deleted Android v1 embedding"

**原因**: 使用了旧版Android嵌入方式

**解决方案**:
```bash
# 清理项目
flutter clean

# 重新获取依赖
flutter pub get

# 重新构建
flutter build apk --release
```

确保 `android/app/src/main/AndroidManifest.xml` 中包含：
```xml
<meta-data
    android:name="flutterEmbedding"
    android:value="2" />
```

#### 问题2: Gradle构建失败

**解决方案**:
```bash
# 删除Gradle缓存
cd android
./gradlew clean

# 或者完全清理
cd ..
flutter clean
rm -rf android/.gradle
rm -rf android/app/build
flutter pub get
```

#### 问题3: "SDK location not found"

**解决方案**:
创建 `android/local.properties`:
```properties
sdk.dir=/path/to/android/sdk
flutter.sdk=/path/to/flutter
```

或设置环境变量：
```bash
export ANDROID_HOME=/path/to/android/sdk
export FLUTTER_ROOT=/path/to/flutter
```

#### 问题4: Java版本问题

**解决方案**:
确保使用Java 17：
```bash
# 检查Java版本
java -version

# 设置JAVA_HOME
export JAVA_HOME=/path/to/java17
```

### iOS构建失败

#### 问题1: "No valid code signing certificates found"

**解决方案**:
使用 `--no-codesign` 标志：
```bash
flutter build ios --release --no-codesign
```

#### 问题2: CocoaPods问题

**解决方案**:
```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter pub get
```

#### 问题3: Xcode版本问题

**解决方案**:
确保使用最新版本的Xcode：
```bash
# 检查Xcode版本
xcodebuild -version

# 更新Xcode Command Line Tools
xcode-select --install
```

## 🚀 GitHub Actions问题

### 问题1: Actions构建失败

**检查步骤**:
1. 查看Actions日志
2. 检查Flutter版本是否正确
3. 确认所有配置文件都已提交

**解决方案**:
```bash
# 本地测试构建
flutter build apk --release
flutter build ios --release --no-codesign

# 如果本地成功，检查GitHub Actions配置
```

### 问题2: Artifacts下载失败

**解决方案**:
- 等待构建完全完成
- 检查Artifacts保留期限（默认30天）
- 确认有足够的GitHub存储空间

### 问题3: 签名构建失败

**检查**:
- 确认GitHub Secrets配置正确
- 验证证书Base64编码正确
- 检查证书密码是否正确

**生成Base64编码**:
```bash
# Android
base64 release.keystore | tr -d '\n' > keystore.txt

# iOS
base64 certificate.p12 | tr -d '\n' > certificate.txt
base64 profile.mobileprovision | tr -d '\n' > profile.txt
```

## 📦 安装问题

### Android安装问题

#### 问题1: "应用未安装"

**解决方案**:
1. 启用"未知来源"安装
2. 检查存储空间
3. 卸载旧版本后重新安装
4. 使用ADB安装：
```bash
adb install -r app-release.apk
```

#### 问题2: "解析包时出现问题"

**解决方案**:
- 重新下载APK（可能下载不完整）
- 检查Android版本（需要5.0+）
- 确认APK文件未损坏

#### 问题3: 应用闪退

**解决方案**:
```bash
# 查看崩溃日志
adb logcat | grep -i flutter

# 清除应用数据
adb shell pm clear com.example.discover_app

# 重新安装
adb install -r app-release.apk
```

### iOS安装问题

#### 问题1: "无法验证应用"

**解决方案**:
1. 确保设备已连接互联网
2. 检查日期和时间设置
3. 信任开发者证书：
   - 设置 > 通用 > VPN与设备管理
   - 点击开发者名称
   - 点击"信任"

#### 问题2: AltStore签名失败

**解决方案**:
- 确保电脑和设备在同一WiFi
- 重启AltServer
- 重新登录Apple ID
- 检查Apple ID是否启用了双重认证

#### 问题3: Sideloadly "Lockdown error"

**解决方案**:
1. 重新连接设备
2. 在设备上重新信任此电脑
3. 重启Sideloadly
4. 更新到最新版本的Sideloadly

#### 问题4: 每7天需要重新签名

**这是正常的**:
- 免费Apple ID限制
- 使用付费开发者账号可延长到1年
- 使用AltStore可自动刷新

## 🔍 运行时问题

### 问题1: 白屏或黑屏

**解决方案**:
```bash
# 检查是否有错误
flutter logs

# 重新构建
flutter clean
flutter pub get
flutter run
```

### 问题2: 热重载不工作

**解决方案**:
- 按 `R` 进行热重启
- 重新运行应用
- 检查是否有编译错误

### 问题3: 网络请求失败

**检查**:
- Android: 确认 `AndroidManifest.xml` 中有 `INTERNET` 权限
- iOS: 检查 `Info.plist` 中的网络配置
- 检查设备网络连接

## 🛠️ 开发环境问题

### 问题1: Flutter doctor报错

**解决方案**:
```bash
# 运行诊断
flutter doctor -v

# 根据提示修复问题
# 例如：
flutter doctor --android-licenses  # 接受Android许可
```

### 问题2: 依赖冲突

**解决方案**:
```bash
# 清理并重新获取
flutter clean
rm pubspec.lock
flutter pub get

# 或升级依赖
flutter pub upgrade
```

### 问题3: IDE问题

**VS Code**:
- 安装Flutter和Dart插件
- 重启VS Code
- 运行 "Flutter: Run Flutter Doctor"

**Android Studio**:
- 安装Flutter插件
- 配置Flutter SDK路径
- 重启IDE

## 📊 性能问题

### 问题1: 应用卡顿

**解决方案**:
- 使用 `--profile` 模式分析
- 检查是否有大量重建
- 优化图片和资源

### 问题2: 应用体积过大

**解决方案**:
```bash
# 分架构构建
flutter build apk --split-per-abi

# 分析体积
flutter build apk --analyze-size
```

### 问题3: 启动慢

**解决方案**:
- 减少启动时的初始化操作
- 使用延迟加载
- 优化启动画面

## 🔐 证书和签名问题

### Android签名问题

#### 生成新密钥库
```bash
keytool -genkey -v -keystore release.keystore \
  -alias my-key-alias \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000
```

#### 查看密钥库信息
```bash
keytool -list -v -keystore release.keystore
```

### iOS签名问题

#### 创建开发证书
1. 打开Xcode
2. Preferences > Accounts
3. 添加Apple ID
4. Manage Certificates > + > iOS Development

#### 导出证书
1. 打开Keychain Access
2. 找到证书
3. 右键 > 导出
4. 保存为 .p12 文件

## 📞 获取更多帮助

如果以上方法都无法解决问题：

1. **查看日志**:
   ```bash
   flutter logs
   adb logcat  # Android
   ```

2. **搜索问题**:
   - [Flutter GitHub Issues](https://github.com/flutter/flutter/issues)
   - [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)

3. **提交Issue**:
   - 在项目GitHub仓库提交Issue
   - 包含完整的错误信息和日志
   - 说明复现步骤

4. **社区支持**:
   - [Flutter中文社区](https://flutter.cn/)
   - [Flutter Discord](https://discord.gg/flutter)
   - [Flutter Reddit](https://www.reddit.com/r/FlutterDev/)

## 🔄 常用命令速查

```bash
# 清理项目
flutter clean

# 重新获取依赖
flutter pub get

# 升级依赖
flutter pub upgrade

# 检查环境
flutter doctor -v

# 查看设备
flutter devices

# 构建APK
flutter build apk --release

# 构建iOS
flutter build ios --release --no-codesign

# 查看日志
flutter logs

# 运行测试
flutter test

# 代码分析
flutter analyze

# 格式化代码
flutter format .
```

## 📚 相关资源

- [Flutter官方文档](https://flutter.dev/docs)
- [Flutter常见问题](https://flutter.dev/docs/resources/faq)
- [Android开发者文档](https://developer.android.com/)
- [iOS开发者文档](https://developer.apple.com/documentation/)
