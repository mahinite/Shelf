import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/widgets/app_scaffold.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/tactile.dart';
import '../../documents/services/scan_service.dart';
import '../../rooms/models/room.dart'; // Not used directly but ensures model imports are available
import '../../subjects/models/subject.dart'; // same
import '../../chapters/models/chapter.dart';
import '../../documents/models/document.dart';
import '../../../core/widgets/hierarchy_picker_sheet.dart';

/// Configuration screen shown after the native scanner returns image paths.
/// Allows the user to either create a new document or add pages to an
/// existing document.
class ScanConfigScreen extends StatefulWidget {
  const ScanConfigScreen({
    super.key,
    required this.imagePaths,
  });

  /// List of image file paths returned by the scanner.
  final List<String> imagePaths;

  @override
  State<ScanConfigScreen> createState() => _ScanConfigScreenState();
}

enum _ConfigMode { newDocument, addToExisting }

class _ScanConfigScreenState extends State<ScanConfigScreen> {
  _ConfigMode _mode = _ConfigMode.newDocument;
  String? _title;
  Chapter? _selectedChapter;
  Document? _selectedDocument;
  bool _isSaving = false;

  void _selectChapter() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => HierarchyPickerSheet(
        mode: HierarchyPickerMode.pickChapter,
        onChapterPicked: (chapter) {
          setState(() => _selectedChapter = chapter);
        },
      ),
    );
  }

  void _selectDocument() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => HierarchyPickerSheet(
        mode: HierarchyPickerMode.pickDocument,
        onChapterPicked: (_) {}, // not used in document mode
        onDocumentPicked: (doc) {
          setState(() => _selectedDocument = doc);
        },
      ),
    );
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    try {
      // Placeholder: real upload logic goes here using ScanService.
      // For now just simulate a short delay.
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Save successful')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Save failed: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool canSave = _mode == _ConfigMode.newDocument
        ? (_title?.isNotEmpty == true && _selectedChapter != null)
        : _selectedDocument != null;

    return AppScaffold(
      title: 'Scan Config',
      body: Column(
        children: [
          // Mode selector
          Padding(
            padding: const EdgeInsets.all(AppSpacing.containerMargin),
            child: ToggleButtons(
              isSelected: [_mode == _ConfigMode.newDocument, _mode == _ConfigMode.addToExisting],
              onPressed: (index) {
                setState(() {
                  _mode = index == 0 ? _ConfigMode.newDocument : _ConfigMode.addToExisting;
                });
              },
              borderRadius: BorderRadius.circular(AppRadius.md),
              fillColor: AppColors.primaryButton,
              selectedColor: AppColors.onPrimaryButton,
              color: AppColors.textPrimary,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('New Document'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Add to Existing'),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.containerMargin),
              child: _mode == _ConfigMode.newDocument
                  ? _buildNewDocumentForm()
                  : _buildAddToExistingForm(),
            ),
          ),
          // Save button
          Padding(
            padding: const EdgeInsets.all(AppSpacing.containerMargin),
            child: Tactile(
              onTap: canSave && !_isSaving ? _save : null,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: canSave && !_isSaving ? AppColors.primaryButton : AppColors.border,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: _isSaving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.onPrimaryButton),
                      )
                    : Text(
                        'Save',
                        style: AppTextStyles.buttonLabel.copyWith(color: canSave ? AppColors.onPrimaryButton : AppColors.textSecondary),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewDocumentForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Document Title',
          ),
          onChanged: (v) => setState(() => _title = v),
        ),
        const SizedBox(height: AppSpacing.lg),
        Tactile(
          onTap: _selectChapter,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: Text(_selectedChapter?.name ?? 'Choose location'),
                ),
                const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddToExistingForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Tactile(
          onTap: _selectDocument,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: Text(_selectedDocument?.title ?? 'Choose document'),
                ),
                const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
