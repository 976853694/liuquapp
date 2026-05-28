import 'dart:ui';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('设置'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          _buildSection(
            '账号设置',
            [
              _buildListTile(
                Icons.person_outline,
                '编辑资料',
                '修改头像、昵称、简介等',
                () {},
              ),
              _buildListTile(
                Icons.lock_outline,
                '修改密码',
                '定期修改密码保护账号安全',
                () {},
              ),
              _buildListTile(
                Icons.email_outlined,
                '绑定邮箱',
                'example@email.com',
                () {},
              ),
              _buildListTile(
                Icons.phone_outlined,
                '绑定手机',
                '138****8888',
                () {},
              ),
            ],
          ),
          _buildSection(
            '通知设置',
            [
              _buildSwitchTile(
                Icons.email_outlined,
                '邮件通知',
                '接收重要通知的邮件提醒',
                _emailNotifications,
                (value) {
                  setState(() {
                    _emailNotifications = value;
                  });
                },
              ),
              _buildSwitchTile(
                Icons.notifications_outlined,
                '推送通知',
                '接收应用推送通知',
                _pushNotifications,
                (value) {
                  setState(() {
                    _pushNotifications = value;
                  });
                },
              ),
            ],
          ),
          _buildSection(
            '隐私设置',
            [
              _buildListTile(
                Icons.block_outlined,
                '屏蔽列表',
                '管理已屏蔽的用户',
                () {},
              ),
              _buildListTile(
                Icons.visibility_off_outlined,
                '隐私设置',
                '谁可以看到我的内容',
                () {},
              ),
            ],
          ),
          _buildSection(
            '外观设置',
            [
              _buildSwitchTile(
                Icons.dark_mode_outlined,
                '深色模式',
                '开启深色主题',
                _darkMode,
                (value) {
                  setState(() {
                    _darkMode = value;
                  });
                },
              ),
            ],
          ),
          _buildSection(
            '其他',
            [
              _buildListTile(
                Icons.help_outline,
                '帮助中心',
                '常见问题与使用指南',
                () {},
              ),
              _buildListTile(
                Icons.info_outline,
                '关于我们',
                '版本 1.0.0',
                () {},
              ),
              _buildListTile(
                Icons.description_outlined,
                '用户协议',
                '查看用户协议和隐私政策',
                () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.red, Colors.redAccent],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    _showLogoutDialog();
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    child: const Text(
                      '退出登录',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.white.withOpacity(0.9),
              child: Column(children: children),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF00C853)),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey[600], fontSize: 12),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile(
    IconData icon,
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SwitchListTile(
      secondary: Icon(icon, color: const Color(0xFF00C853)),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey[600], fontSize: 12),
      ),
      value: value,
      activeColor: const Color(0xFF00C853),
      onChanged: onChanged,
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('退出登录'),
          content: const Text('确定要退出登录吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate to login screen
              },
              child: const Text(
                '确定',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
