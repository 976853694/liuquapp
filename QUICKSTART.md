# 🚀 快速开始指南

## 📋 前置要求

- Flutter SDK 3.0+
- Dart SDK 3.0+
- Android Studio / Xcode（用于移动开发）
- Git

## 🛠️ 本地开发

### 1. 克隆项目

```bash
git clone <your-repo-url>
cd discover_app
```

### 2. 安装依赖

```bash
flutter pub get
```

### 3. 运行应用

#### Android
```bash
# 连接Android设备或启动模拟器
flutter run
```

#### iOS（需要Mac）
```bash
# 连接iOS设备或启动模拟器
flutter run
```

#### 指定设备
```bash
# 查看可用设备
flutter devices

# 在特定设备上运行
flutter run -d <device-id>
```

### 4. 热重载

应用运行时：
- 按 `r` 进行热重载
- 按 `R` 进行热重启
- 按 `q` 退出

## 📦 构建应用

### Android

#### 构建APK（用于测试）
```bash
flutter build apk --release
```
输出位置：`build/app/outputs/flutter-apk/app-release.apk`

#### 构建App Bundle（用于Google Play）
```bash
flutter build appbundle --release
```
输出位置：`build/app/outputs/bundle/release/app-release.aab`

#### 构建分架构APK（减小体积）
```bash
flutter build apk --split-per-abi --release
```

### iOS（需要Mac）

#### 构建未签名版本
```bash
flutter build ios --release --no-codesign
```

#### 构建签名版本
```bash
flutter build ios --release
```

#### 创建IPA
```bash
# 构建后
cd build/ios/iphoneos
mkdir Payload
cp -r Runner.app Payload/
zip -r app.ipa Payload
```

## 🔧 开发工具

### 代码分析
```bash
flutter analyze
```

### 运行测试
```bash
flutter test
```

### 格式化代码
```bash
flutter format .
```

### 清理构建
```bash
flutter clean
flutter pub get
```

## 🌐 GitHub Actions自动构建

### 自动触发
推送代码到 `main`、`master` 或 `develop` 分支时自动构建。

### 手动触发
1. 进入GitHub仓库
2. 点击 "Actions" 标签
3. 选择 "Build Flutter App"
4. 点击 "Run workflow"
5. 等待构建完成
6. 下载Artifacts

## 📱 安装到设备

### Android
```bash
# 通过ADB安装
adb install build/app/outputs/flutter-apk/app-release.apk

# 或直接运行
flutter install
```

### iOS
```bash
# 使用Xcode安装
open -a Simulator  # 启动模拟器
flutter install    # 安装到模拟器

# 或使用ios-deploy（真机）
ios-deploy --bundle build/ios/iphoneos/Runner.app
```

## 🐛 调试

### 启用调试模式
```bash
flutter run --debug
```

### 查看日志
```bash
flutter logs
```

### 性能分析
```bash
flutter run --profile
```

### DevTools
```bash
flutter pub global activate devtools
flutter pub global run devtools
```

## 📊 性能优化

### 分析应用大小
```bash
flutter build apk --analyze-size
flutter build ios --analyze-size
```

### 生成性能报告
```bash
flutter run --profile --trace-startup
```

## 🔐 签名配置

### Android签名

1. 生成密钥库：
```bash
keytool -genkey -v -keystore ~/release.keystore -alias my-key-alias -keyalg RSA -keysize 2048 -validity 10000
```

2. 创建 `android/key.properties`：
```properties
storePassword=<密钥库密码>
keyPassword=<密钥密码>
keyAlias=my-key-alias
storeFile=<密钥库路径>
```

3. 构建签名APK：
```bash
flutter build apk --release
```

### iOS签名

1. 在Xcode中打开 `ios/Runner.xcworkspace`
2. 选择 Runner > Signing & Capabilities
3. 选择你的Team和证书
4. 构建：
```bash
flutter build ios --release
```

## 📚 项目结构

```
lib/
├── main.dart                      # 应用入口
├── models/                        # 数据模型
│   └── post.dart
├── screens/                       # 页面
│   └── home_screen.dart
└── widgets/                       # 组件
    ├── banner_card.dart
    ├── category_tabs.dart
    ├── post_card.dart
    └── animated_bottom_nav.dart
```

## 🎨 自定义配置

### 修改应用名称

**Android**: `android/app/src/main/AndroidManifest.xml`
```xml
<application android:label="你的应用名">
```

**iOS**: `ios/Runner/Info.plist`
```xml
<key>CFBundleDisplayName</key>
<string>你的应用名</string>
```

### 修改应用图标

1. 准备图标文件（1024x1024 PNG）
2. 使用在线工具生成各尺寸图标
3. 替换：
   - Android: `android/app/src/main/res/mipmap-*/ic_launcher.png`
   - iOS: `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

### 修改包名/Bundle ID

**Android**: `android/app/build.gradle`
```gradle
defaultConfig {
    applicationId "com.yourcompany.yourapp"
}
```

**iOS**: 在Xcode中修改Bundle Identifier

## 🔄 版本管理

### 更新版本号

编辑 `pubspec.yaml`：
```yaml
version: 1.0.1+2  # 版本号+构建号
```

或使用命令：
```bash
# 更新版本号
flutter pub version patch  # 1.0.0 -> 1.0.1
flutter pub version minor  # 1.0.0 -> 1.1.0
flutter pub version major  # 1.0.0 -> 2.0.0
```

## 📖 更多资源

- [Flutter官方文档](https://flutter.dev/docs)
- [Dart语言指南](https://dart.dev/guides)
- [Material Design](https://material.io/design)
- [Flutter中文网](https://flutter.cn/)

## 💡 常用命令速查

```bash
# 开发
flutter run                    # 运行应用
flutter run --release          # 发布模式运行
flutter hot-reload            # 热重载
flutter hot-restart           # 热重启

# 构建
flutter build apk             # 构建Android APK
flutter build appbundle       # 构建Android App Bundle
flutter build ios             # 构建iOS应用

# 工具
flutter doctor                # 检查环境
flutter devices               # 列出设备
flutter clean                 # 清理构建
flutter pub get               # 获取依赖
flutter pub upgrade           # 升级依赖
flutter analyze               # 代码分析
flutter test                  # 运行测试
flutter format .              # 格式化代码

# 调试
flutter logs                  # 查看日志
flutter screenshot            # 截图
flutter install               # 安装到设备
```

## 🆘 遇到问题？

1. 运行 `flutter doctor` 检查环境
2. 运行 `flutter clean` 清理项目
3. 删除 `pubspec.lock` 并重新运行 `flutter pub get`
4. 查看 [INSTALL.md](INSTALL.md) 了解安装详情
5. 查看 [.github/workflows/README.md](.github/workflows/README.md) 了解CI/CD
6. 在GitHub上提交Issue

## 🎉 开始开发

现在你已经准备好开始开发了！运行以下命令启动应用：

```bash
flutter run
```

祝你开发愉快！🚀
