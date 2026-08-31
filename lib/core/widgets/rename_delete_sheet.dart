import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';

/// Action sheet shown on long-press with Rename/Delete options.
/// Caller provides callbacks for rename/delete and the item's current name.
class RenameDeleteSheet extends StatelessWidget {
  const RenameDeleteSheet({
    super.key,
    required this.currentName,
    required this.onRename,
    required this.onDelete,
    required this.itemType,
    this.hasChildren = false,
  });

  final String currentName;
  final Future<void> Function(String newName) onRename;
  final Future<void> Function() onDelete;
  final String itemType; // e.g., 'Room', 'Subject', 'Chapter', 'Document'
  final bool hasChildren; // whether deleting cascades to nested items

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: Text('Rename $itemType', style: AppTextStyles.body),
            onTap: () {
              Navigator.pop(context);
              _showRenameDialog(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.delete_outline, color: Colors.red[600]),
            title: Text('Delete $itemType', style: AppTextStyles.body.copyWith(color: Colors.red[600])),
            onTap: () {
              Navigator.pop(context);
              _showDeleteConfirmation(context);
            },
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  void _showRenameDialog(BuildContext context) {
    final controller = TextEditingController(text: currentName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Rename $itemType'),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            hintText: '$itemType name',
          ),
          onSubmitted: (value) {
            final trimmed = value.trim();
            if (trimmed.isNotEmpty && trimmed != currentName) {
              Navigator.of(context).pop();
              onRename(trimmed);
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final trimmed = controller.text.trim();
              if (trimmed.isNotEmpty && trimmed != currentName) {
                Navigator.of(context).pop();
                onRename(trimmed);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    final warningText = hasChildren
        ? 'This will also delete all $itemType contents (documents, and for rooms, subjects and chapters too). This cannot be undone.'
        : 'This cannot be undone.';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete $itemType?'),
        content: Text(
          'Are you sure you want to delete "$currentName"?\n\n$warningText',
          style: AppTextStyles.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red[600]),
            onPressed: () {
              Navigator.of(context).pop();
              onDelete();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

/// Helper to show the rename/delete bottom sheet from a long-press gesture.
Future<void> showRenameDeleteSheet({
  required BuildContext context,
  required String currentName,
  required Future<void> Function(String newName) onRename,
  required Future<void> Function() onDelete,
  required String itemType,
  bool hasChildren = false,
}) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (context) => RenameDeleteSheet(
      currentName: currentName,
      onRename: onRename,
      onDelete: onDelete,
      itemType: itemType,
      hasChildren: hasChildren,
    ),
  );
}