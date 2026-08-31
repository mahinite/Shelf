import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Shows a bottom sheet with "Rename" and "Delete" options.
///
/// Tapping either option closes the bottom sheet first, then invokes
/// the corresponding callback. The callback is responsible for showing
/// any follow-up dialog (rename text input, delete confirmation) since
/// those differ per screen.
Future<void> showItemActionSheet({
  required BuildContext context,
  required String itemName,
  required Future<void> Function() onRename,
  required Future<void> Function() onDelete,
}) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (context) => _ItemActionSheet(
      itemName: itemName,
      onRename: onRename,
      onDelete: onDelete,
    ),
  );
}

class _ItemActionSheet extends StatelessWidget {
  const _ItemActionSheet({
    required this.itemName,
    required this.onRename,
    required this.onDelete,
  });

  final String itemName;
  final Future<void> Function() onRename;
  final Future<void> Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit_outlined, color: AppColors.textPrimary),
            title: Text('Rename', style: AppTextStyles.body),
            onTap: () async {
              Navigator.pop(context);
              await onRename();
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline, color: AppColors.textSecondary),
            title: Text('Delete', style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
            onTap: () async {
              Navigator.pop(context);
              await onDelete();
            },
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}