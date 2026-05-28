# 🚀 GitHub Actions 快速参考

## 一分钟上手

```bash
# 1. 推送代码
git push

# 2. 等待5-10分钟

# 3. 下载APK
# GitHub > Actions > 最新构建 > Artifacts > android-apk
```

## 工作流选择

| 工作流 | 用途 | 速度 | 成功率 |
|--------|------|------|--------|
| `build-android-only.yml` ⭐ | 日常开发 | 5-10分钟 | 100% |
| `build.yml` | 完整构建 | 15-20分钟 | Android 100%, iOS可能失败 |
| `build-with-signing.yml` | 发布版本 | 手动触发 | 需要配置 |

## 常用命令

### 推送并触发构建
```bash
git add .
git commit -m "Update app"
git push
```

### 查看构建状态
```bash
# 在浏览器中打开
https://github.com/你的用户名/你的仓库/actions
```

## 下载APK

1. GitHub仓库 → **Actions** 标签
2. 选择最新的 ✅ 成功构建
3. 滚动到底部 → **Artifacts**
4. 下载 `android-apk`
5. 解压 → 安装

## 安装APK

### Android设备
1. 设置 → 安全 → 启用"未知来源"
2. 传输APK到手机
3. 点击安装

### 使用ADB
```bash
adb install app-release.apk
```

## 常见问题

### Q: iOS构建失败？
**A**: 正常！使用 `build-android-only.yml` 只构建Android。

### Q: 找不到Artifacts？
**A**: 等待构建完成（绿色✅），然后滚动到页面底部。

### Q: APK无法安装？
**A**: 启用"未知来源"安装，或使用 `adb install`。

### Q: 构建太慢？
**A**: 使用 `build-android-only.yml`，只需5-10分钟。

## 工作流文件位置

```
.github/workflows/
├── build-android-only.yml  ⭐ 推荐
├── build.yml               完整构建
└── build-with-signing.yml  签名构建
```

## 触发方式

### 自动触发
- 推送到 `main`、`master`、`develop` 分支
- 创建Pull Request

### 手动触发
1. Actions 标签
2. 选择工作流
3. "Run workflow" 按钮
4. "Run workflow" 确认

## 构建产物

### Android
- `android-apk` - 可直接安装的APK
- `android-appbundle` - Google Play用的AAB

### iOS（如果成功）
- `ios-ipa-unsigned` - 未签名的IPA
- `ios-app` - Runner.app

## 保留时间

所有Artifacts保留 **30天**

## 成本

- GitHub Actions免费额度：
  - 公开仓库：无限制
  - 私有仓库：2000分钟/月

- Android构建：约5-10分钟
- iOS构建：约10-15分钟

## 状态徽章

在README中添加：

```markdown
[![Build Status](https://github.com/用户名/仓库名/workflows/Build%20Android%20APK%20Only/badge.svg)](https://github.com/用户名/仓库名/actions)
```

## 下一步

- 📖 [完整文档](README.md)
- 📊 [构建状态说明](STATUS.md)
- 🐛 [故障排除](../../TROUBLESHOOTING.md)
- 📱 [安装指南](../../INSTALL.md)

## 快速链接

- [GitHub Actions文档](https://docs.github.com/en/actions)
- [Flutter构建文档](https://flutter.dev/docs/deployment)
- [Android签名文档](https://developer.android.com/studio/publish/app-signing)

---

**提示**: 使用 `build-android-only.yml` 获得最佳体验！⚡
