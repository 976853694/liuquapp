# GitHub Actions 工作流说明

本项目包含两个GitHub Actions工作流文件，用于自动构建Flutter应用。

## 📦 工作流文件

### 1. `build.yml` - 基础构建（推荐用于测试）

**触发条件：**
- 推送到 `main`、`master` 或 `develop` 分支
- Pull Request 到 `main` 或 `master` 分支
- 手动触发

**构建产物：**
- ✅ Android APK（未签名，可直接安装）
- ✅ Android App Bundle（未签名）
- ✅ iOS IPA（未签名，需要重新签名）
- ✅ iOS Runner.app

**特点：**
- 无需配置任何证书
- Android APK可以直接安装（需要启用"未知来源"）
- iOS需要使用第三方工具重新签名

### 2. `build-with-signing.yml` - 签名构建（用于发布）

**触发条件：**
- 仅手动触发

**构建产物：**
- ✅ Android APK（已签名，如果配置了密钥）
- ✅ Android App Bundle（已签名，如果配置了密钥）
- ✅ iOS IPA（已签名，如果配置了证书）

**特点：**
- 支持使用GitHub Secrets配置证书
- 如果未配置证书，则生成未签名版本
- 可以指定版本号和构建号

## 🔧 配置说明

### Android签名配置（可选）

如果需要签名的Android应用，需要在GitHub仓库的Settings > Secrets中添加：

1. **ANDROID_KEYSTORE_BASE64**: Android密钥库文件的Base64编码
   ```bash
   # 生成密钥库
   keytool -genkey -v -keystore release.keystore -alias my-key-alias -keyalg RSA -keysize 2048 -validity 10000
   
   # 转换为Base64
   base64 release.keystore | tr -d '\n' > keystore.txt
   # 将keystore.txt的内容复制到GitHub Secret
   ```

2. **ANDROID_KEYSTORE_PASSWORD**: 密钥库密码
3. **ANDROID_KEY_ALIAS**: 密钥别名
4. **ANDROID_KEY_PASSWORD**: 密钥密码

### iOS签名配置（可选）

如果需要签名的iOS应用，需要在GitHub仓库的Settings > Secrets中添加：

1. **IOS_CERTIFICATE_BASE64**: iOS证书(.p12)的Base64编码
   ```bash
   # 从Keychain导出证书为.p12文件
   # 然后转换为Base64
   base64 certificate.p12 | tr -d '\n' > certificate.txt
   # 将certificate.txt的内容复制到GitHub Secret
   ```

2. **IOS_CERTIFICATE_PASSWORD**: 证书密码
3. **IOS_PROVISIONING_PROFILE_BASE64**: 配置文件(.mobileprovision)的Base64编码
   ```bash
   base64 profile.mobileprovision | tr -d '\n' > profile.txt
   # 将profile.txt的内容复制到GitHub Secret
   ```

## 📱 安装说明

### Android安装

#### 方法1：直接安装APK（推荐）
1. 从GitHub Actions的Artifacts下载 `android-apk`
2. 在Android设备上启用"未知来源"安装
   - 设置 > 安全 > 未知来源
3. 安装APK文件

#### 方法2：使用ADB安装
```bash
adb install app-release.apk
```

### iOS安装

由于iOS的安全限制，未签名的IPA需要重新签名才能安装。

#### 方法1：使用AltStore（推荐，无需越狱）
1. 安装 [AltStore](https://altstore.io/)
2. 下载未签名的IPA
3. 使用AltStore安装IPA
4. 每7天需要重新签名（免费Apple ID）

#### 方法2：使用Sideloadly（推荐，无需越狱）
1. 安装 [Sideloadly](https://sideloadly.io/)
2. 连接iOS设备到电脑
3. 使用Apple ID登录
4. 选择IPA文件并安装

#### 方法3：使用Xcode
1. 下载 `Runner.app`
2. 打开Xcode
3. Window > Devices and Simulators
4. 选择你的设备
5. 拖拽 `Runner.app` 到设备

#### 方法4：越狱设备
1. 安装 AppSync Unified
2. 直接安装未签名的IPA

#### 方法5：使用iOS App Signer
1. 下载 [iOS App Signer](https://dantheman827.github.io/ios-app-signer/)
2. 选择未签名的IPA
3. 选择你的签名证书
4. 重新签名并安装

## 🚀 使用方法

### 自动构建
每次推送代码到主分支时，GitHub Actions会自动构建应用。

### 手动构建
1. 进入GitHub仓库
2. 点击 "Actions" 标签
3. 选择工作流（`Build Flutter App` 或 `Build Flutter App (With Signing)`）
4. 点击 "Run workflow"
5. 填写版本号（可选）
6. 点击 "Run workflow" 按钮

### 下载构建产物
1. 进入GitHub仓库的 "Actions" 标签
2. 选择一个完成的工作流运行
3. 在 "Artifacts" 部分下载需要的文件

## 📝 注意事项

1. **Android APK** 可以直接安装，无需签名
2. **iOS IPA** 需要重新签名才能在非越狱设备上安装
3. 构建产物会保留30天
4. 如果不配置签名证书，Android和iOS都会生成未签名版本
5. 未签名的Android APK在大多数设备上可以正常安装
6. iOS应用必须签名才能在非越狱设备上运行

## 🔒 安全建议

1. 不要在代码中硬编码证书或密码
2. 使用GitHub Secrets存储敏感信息
3. 定期更新证书和密钥
4. 不要将密钥库文件提交到Git仓库
5. 使用不同的密钥用于开发和生产环境

## 🐛 故障排除

### Android构建失败
- 检查Java版本是否正确（需要Java 17）
- 检查Gradle配置
- 查看构建日志中的错误信息

### iOS构建失败
- 确保使用macOS runner
- 检查证书和配置文件是否正确
- 查看Xcode构建日志

### 无法安装应用
- **Android**: 确保启用了"未知来源"安装
- **iOS**: 确保应用已正确签名，或使用第三方工具重新签名

## 📚 相关资源

- [Flutter官方文档](https://flutter.dev/docs)
- [GitHub Actions文档](https://docs.github.com/en/actions)
- [Android应用签名](https://developer.android.com/studio/publish/app-signing)
- [iOS代码签名](https://developer.apple.com/support/code-signing/)
- [AltStore](https://altstore.io/)
- [Sideloadly](https://sideloadly.io/)
