import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/services/crash_logger.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final email = user?.email ?? 'No email available';

    return AppScaffold(
      title: 'Settings',
      showBackButton: true,
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.containerMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Account', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.sm),
            Text(email, style: AppTextStyles.bodySecondary),
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
          ],
        ),
      ),
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
