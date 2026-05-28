# 📱 安装指南

本文档详细说明如何在Android和iOS设备上安装本应用。

## 📥 下载应用

### 从GitHub Actions下载

1. 访问项目的GitHub仓库
2. 点击 "Actions" 标签
3. 选择最新的成功构建
4. 在页面底部的 "Artifacts" 部分下载：
   - **Android**: `android-apk`
   - **iOS**: `ios-ipa-unsigned` 或 `ios-app`

## 🤖 Android安装

### 方法1：直接安装APK（最简单）

1. **下载APK文件**
   - 从GitHub Actions下载 `android-apk.zip`
   - 解压得到 `app-release.apk`

2. **启用未知来源安装**
   - Android 8.0及以上：
     - 设置 > 应用和通知 > 特殊应用权限 > 安装未知应用
     - 选择你的文件管理器或浏览器，允许安装
   - Android 8.0以下：
     - 设置 > 安全 > 未知来源（勾选）

3. **安装应用**
   - 使用文件管理器找到APK文件
   - 点击安装
   - 按照提示完成安装

### 方法2：使用ADB安装

```bash
# 确保已安装Android SDK Platform Tools
# 连接设备并启用USB调试

# 安装应用
adb install app-release.apk

# 如果已安装旧版本，使用-r参数覆盖安装
adb install -r app-release.apk
```

### 方法3：通过电脑传输

1. 将APK文件传输到手机（通过USB、蓝牙、云盘等）
2. 在手机上找到APK文件
3. 点击安装

## 🍎 iOS安装

由于iOS的安全机制，未签名的应用需要重新签名才能安装。以下是几种安装方法：

### 方法1：使用AltStore（推荐，无需越狱）

**优点**：
- 无需越狱
- 免费
- 支持自动刷新

**缺点**：
- 需要电脑辅助
- 免费Apple ID每7天需要重新签名
- 最多同时安装3个应用

**步骤**：

1. **安装AltStore**
   - 访问 [altstore.io](https://altstore.io/)
   - 下载并安装AltServer（Windows/Mac）
   - 在iOS设备上安装AltStore应用

2. **配置AltStore**
   - 确保电脑和iOS设备在同一WiFi网络
   - 在电脑上运行AltServer
   - 在iOS设备上打开AltStore
   - 使用Apple ID登录

3. **安装应用**
   - 将IPA文件传输到iOS设备（通过AirDrop、iCloud等）
   - 在AltStore中点击"+"
   - 选择IPA文件
   - 等待签名和安装完成

4. **信任开发者**
   - 设置 > 通用 > VPN与设备管理
   - 点击你的Apple ID
   - 点击"信任"

### 方法2：使用Sideloadly（推荐，无需越狱）

**优点**：
- 无需越狱
- 界面友好
- 支持高级功能

**步骤**：

1. **安装Sideloadly**
   - 访问 [sideloadly.io](https://sideloadly.io/)
   - 下载并安装（Windows/Mac/Linux）

2. **连接设备**
   - 使用USB线连接iOS设备到电脑
   - 在设备上信任此电脑

3. **签名并安装**
   - 打开Sideloadly
   - 拖拽IPA文件到Sideloadly
   - 输入Apple ID和密码
   - 点击"Start"
   - 等待签名和安装完成

4. **信任开发者**
   - 设置 > 通用 > VPN与设备管理
   - 点击你的Apple ID
   - 点击"信任"

### 方法3：使用Xcode（需要Mac）

**优点**：
- 官方工具
- 稳定可靠

**步骤**：

1. **准备工作**
   - 安装Xcode（从App Store）
   - 注册Apple开发者账号（免费账号即可）

2. **安装应用**
   - 连接iOS设备到Mac
   - 打开Xcode
   - Window > Devices and Simulators
   - 选择你的设备
   - 点击"+"或拖拽 `Runner.app` 到设备

3. **信任开发者**
   - 设置 > 通用 > VPN与设备管理
   - 点击你的Apple ID
   - 点击"信任"

### 方法4：使用iOS App Signer（需要Mac）

**步骤**：

1. **安装iOS App Signer**
   - 访问 [GitHub](https://github.com/DanTheMan827/ios-app-signer)
   - 下载并安装

2. **准备证书**
   - 在Xcode中创建一个iOS项目
   - 使用你的Apple ID签名
   - 这会自动创建开发证书

3. **签名IPA**
   - 打开iOS App Signer
   - 选择IPA文件
   - 选择签名证书
   - 选择配置文件
   - 点击"Start"

4. **安装签名后的IPA**
   - 使用Xcode或其他工具安装签名后的IPA

### 方法5：越狱设备（不推荐）

**仅适用于已越狱的设备**

1. **安装AppSync Unified**
   - 添加源：https://cydia.akemi.ai/
   - 搜索并安装 AppSync Unified

2. **安装应用**
   - 使用Filza或其他文件管理器
   - 直接安装未签名的IPA

## ⚠️ 常见问题

### Android

**Q: 安装时提示"未知来源"或"不安全"**
A: 这是正常的，因为应用不是从Google Play下载的。启用"未知来源"安装即可。

**Q: 安装失败，提示"解析包时出现问题"**
A: 
- 确保下载的APK文件完整
- 检查设备的Android版本（需要Android 5.0+）
- 尝试重新下载APK

**Q: 应用闪退**
A:
- 清除应用数据和缓存
- 重新安装应用
- 检查设备是否有足够的存储空间

### iOS

**Q: 安装后无法打开，提示"未受信任的企业级开发者"**
A: 
- 设置 > 通用 > VPN与设备管理
- 点击你的Apple ID
- 点击"信任"

**Q: 每7天需要重新签名**
A: 
- 这是免费Apple ID的限制
- 使用付费开发者账号可以延长到1年
- 使用AltStore可以自动刷新签名

**Q: 安装时提示"无法验证应用"**
A:
- 确保设备已连接互联网
- 检查日期和时间设置是否正确
- 尝试重新签名和安装

**Q: Sideloadly提示"Lockdown error"**
A:
- 重新连接设备
- 在设备上重新信任此电脑
- 重启Sideloadly

## 🔒 安全提示

1. **仅从官方GitHub仓库下载应用**
2. **不要从第三方网站下载APK或IPA**
3. **安装后可以关闭"未知来源"选项（Android）**
4. **定期更新应用到最新版本**
5. **注意应用请求的权限**

## 📞 获取帮助

如果遇到问题：

1. 查看本文档的常见问题部分
2. 查看GitHub仓库的Issues
3. 在GitHub上提交新的Issue
4. 查看 `.github/workflows/README.md` 了解构建详情

## 🔄 更新应用

### Android
- 下载新版本的APK
- 直接安装（会覆盖旧版本）
- 数据会保留

### iOS
- 使用相同的方法重新签名和安装新版本
- 数据通常会保留（取决于Bundle ID是否相同）

## 📚 相关资源

- [AltStore官网](https://altstore.io/)
- [Sideloadly官网](https://sideloadly.io/)
- [iOS App Signer](https://github.com/DanTheMan827/ios-app-signer)
- [Android开发者文档](https://developer.android.com/)
- [Apple开发者文档](https://developer.apple.com/)
