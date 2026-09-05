import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/services/crash_logger.dart';
import '../../../core/services/theme_notifier.dart';
import '../../../core/network/worker_client.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _appVersion = '';
  String _buildNumber = '';

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
  }

  Future<void> _loadAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _appVersion = packageInfo.version;
        _buildNumber = packageInfo.buildNumber;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final email = user?.email ?? 'No email available';
    final themeNotifier = ThemeModeNotifier();

    return AppScaffold(
      title: 'Settings',
      showBackButton: true,
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.containerMargin),
        child: ListView(
          children: [
            Center(
              child: Image.asset(
                'assets/Shelf-text-logo-non-transparent.png',
                width: 160,
                height: 160,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Account', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.sm),
            Text(email, style: AppTextStyles.bodySecondary),
            const SizedBox(height: AppSpacing.md),
            ListTile(
              leading: const Icon(Icons.lock_outline),
              title: const Text('Change Password'),
              onTap: _showChangePasswordDialog,
            ),
            ListTile(
              leading: const Icon(Icons.delete_forever_outlined),
              title: const Text('Delete Account'),
              textColor: AppColors.destructive,
              iconColor: AppColors.destructive,
              onTap: _showDeleteAccountDialog,
            ),
            const SizedBox(height: AppSpacing.xl),
            const Divider(),
            const SizedBox(height: AppSpacing.md),
            Text('Appearance', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.sm),
            ValueListenableBuilder<ThemeMode>(
              valueListenable: themeNotifier,
              builder: (context, themeMode, _) {
                return SwitchListTile(
                  secondary: Icon(
                    themeMode == ThemeMode.dark
                        ? Icons.dark_mode
                        : Icons.light_mode,
                  ),
                  title: const Text('Dark Mode'),
                  subtitle: Text(
                    themeMode == ThemeMode.dark ? 'Dark' : 'Light',
                    style: AppTextStyles.bodySecondary,
                  ),
                  value: themeMode == ThemeMode.dark,
                  onChanged: (_) => themeNotifier.toggleTheme(),
                );
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            const Divider(),
            const SizedBox(height: AppSpacing.md),
            Text('Debug', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.sm),
            ListTile(
              leading: const Icon(Icons.bug_report_outlined),
              title: const Text('View Crash Logs'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CrashLogsScreen()),
                );
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            const Divider(),
            const SizedBox(height: AppSpacing.md),
            Text('About', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.sm),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Shelf'),
              subtitle: Text(
                _appVersion.isNotEmpty
                    ? 'Version $_appVersion ($_buildNumber)'
                    : 'Loading...',
                style: AppTextStyles.bodySecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await Supabase.instance.client.auth.signOut();
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Log out'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showChangePasswordDialog() async {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    bool isLoading = false;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Change Password'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: currentPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Current Password',
                        hintText: 'Enter current password',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: newPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'New Password',
                        hintText: 'Enter new password',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Confirm New Password',
                        hintText: 'Re-enter new password',
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: isLoading ? null : () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          final current = currentPasswordController.text;
                          final newPass = newPasswordController.text;
                          final confirm = confirmPasswordController.text;

                          if (newPass != confirm) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Passwords do not match'),
                              ),
                            );
                            return;
                          }
                          if (newPass.length < 6) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Password must be at least 6 characters',
                                ),
                              ),
                            );
                            return;
                          }

                          setDialogState(() => isLoading = true);

                          try {
                            // Re-authenticate with current password before changing
                            final email = Supabase.instance.client.auth.currentUser?.email;
                            if (email == null) throw Exception('No user email');

                            await Supabase.instance.client.auth.signInWithPassword(
                              email: email,
                              password: current,
                            );

                            await Supabase.instance.client.auth.updateUser(
                              UserAttributes(password: newPass),
                            );

                            if (!context.mounted) return;
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Password changed successfully'),
                              ),
                            );
                          } catch (e) {
                            if (!context.mounted) return;
                            setDialogState(() => isLoading = false);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to change password: $e')),
                            );
                          }
                        },
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Change'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showDeleteAccountDialog() async {
    final confirmController = TextEditingController();
    bool isLoading = false;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Delete Account'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'This action is permanent and cannot be undone. '
                    'Your account and all associated data will be deleted.',
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const Text(
                    'If you own any study rooms, they will be transferred to another '
                    'member or deleted if you are the only member.',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  TextField(
                    controller: confirmController,
                    decoration: const InputDecoration(
                      labelText: 'Type "DELETE" to confirm',
                      hintText: 'DELETE',
                    ),
                    onChanged: (_) => setDialogState(() {}),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: isLoading ? null : () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.destructive,
                  ),
                  onPressed: (isLoading || confirmController.text != 'DELETE')
                      ? null
                      : () async {
                          setDialogState(() => isLoading = true);
                          try {
                            await WorkerClient.instance.deleteAccount();
                            await Supabase.instance.client.auth.signOut();
                            if (!context.mounted) return;
                            Navigator.of(context).pop();
                            // Navigate to login screen (AuthGate will handle it)
                          } catch (e) {
                            if (!context.mounted) return;
                            setDialogState(() => isLoading = false);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to delete account: $e')),
                            );
                          }
                        },
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Delete Account'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class CrashLogsScreen extends StatefulWidget {
  const CrashLogsScreen({super.key});

  @override
  State<CrashLogsScreen> createState() => _CrashLogsScreenState();
}

class _CrashLogsScreenState extends State<CrashLogsScreen> {
  String _logs = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  Future<void> _loadLogs() async {
    final logs = await CrashLogger.readLogs();
    if (mounted) {
      setState(() {
        _logs = logs;
      });
    }
  }

  Future<void> _clearLogs() async {
    await CrashLogger.clearLogs();
    if (mounted) {
      setState(() {
        _logs = 'No crash logs found.';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Crash logs cleared')),
      );
    }
  }

  Future<void> _shareLogs() async {
    final file = await CrashLogger.getLogFile();
    if (await file.exists()) {
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Shelf Crash Logs',
      );
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No crash log file to share')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Crash Logs',
      showBackButton: true,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.containerMargin),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: SelectableText(
                      _logs,
                      style: AppTextStyles.body.copyWith(fontFamily: 'monospace'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: AppSpacing.containerMargin,
            right: AppSpacing.containerMargin,
            bottom: AppSpacing.containerMargin,
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Clear'),
                    onPressed: _clearLogs,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: FilledButton.icon(
                    icon: const Icon(Icons.share),
                    label: const Text('Share'),
                    onPressed: _shareLogs,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
