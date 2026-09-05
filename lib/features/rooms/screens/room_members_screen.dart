import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/services.dart';

import '../models/room.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_scaffold.dart';

class RoomMembersScreen extends StatefulWidget {
  const RoomMembersScreen({
    super.key,
    required this.room,
  });

  final Room room;

  @override
  State<RoomMembersScreen> createState() => _RoomMembersScreenState();
}

class _RoomMembersScreenState extends State<RoomMembersScreen> {
  late Future<List<RoomMember>> _membersFuture;
  String? _inviteCode;

  @override
  void initState() {
    super.initState();
    _membersFuture = _loadMembers();
    _inviteCode = widget.room.inviteCode;
  }

  Future<List<RoomMember>> _loadMembers() async {
    final data = await Supabase.instance.client.rpc(
      'get_room_members',
      params: {'room_id': widget.room.id},
    );

    return (data as List).map((json) => RoomMember.fromJson(json)).toList();
  }

  Future<void> _refreshMembers() async {
    if (!mounted) return;
    setState(() {
      _membersFuture = _loadMembers();
    });
  }

  Future<void> _showInviteSheet() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: AppSpacing.containerMargin,
            right: AppSpacing.containerMargin,
            top: AppSpacing.containerMargin,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Invite Members',
                style: AppTextStyles.sectionTitle,
              ),
              const SizedBox(height: AppSpacing.md),
              ListTile(
                leading: const Icon(Icons.qr_code),
                title: const Text('Share invite code'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showInviteCodeDialog();
                },
              ),
              ListTile(
                leading: const Icon(Icons.email_outlined),
                title: const Text('Invite by email'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showInviteByEmailDialog();
                },
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showInviteCodeDialog() async {
    final isGenerating = _inviteCode == null;
    String? currentCode = _inviteCode;
    bool isLoading = isGenerating;

    if (isGenerating) {
      try {
        final code = await Supabase.instance.client.rpc(
          'regenerate_invite_code',
          params: {'room_id': widget.room.id},
        );
        if (mounted) {
          setState(() {
            currentCode = code;
            _inviteCode = code;
            isLoading = false;
          });
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to generate invite code: $e')),
        );
        Navigator.of(context).pop();
        return;
      }
    }

    if (!mounted) return;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Invite Code'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppSpacing.lg),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else ...[
                    SelectableText(
                      currentCode ?? '',
                      style: AppTextStyles.body.copyWith(
                        fontFamily: 'monospace',
                        fontSize: 16,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.copy),
                            label: const Text('Copy'),
                            onPressed: currentCode != null
                                ? () {
                                    Clipboard.setData(
                                      ClipboardData(text: currentCode!),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Invite code copied'),
                                      ),
                                    );
                                  }
                                : null,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: FilledButton.icon(
                            icon: const Icon(Icons.refresh),
                            label: const Text('Regenerate'),
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Regenerate invite code?'),
                                  content: const Text(
                                    'This will invalidate the current invite code. '
                                    'Anyone with the old code will no longer be able to join.',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text('Cancel'),
                                    ),
                                    FilledButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text('Regenerate'),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true && mounted) {
                                setDialogState(() {
                                  isLoading = true;
                                  currentCode = null;
                                });
                                try {
                                  final code = await Supabase.instance.client
                                      .rpc(
                                    'regenerate_invite_code',
                                    params: {'room_id': widget.room.id},
                                  );
                                  if (mounted) {
                                    setDialogState(() {
                                      currentCode = code;
                                      _inviteCode = code;
                                      isLoading = false;
                                    });
                                  }
                                } catch (e) {
                                  if (!mounted) return;
                                  setDialogState(() {
                                    isLoading = false;
                                  });
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Failed to regenerate code: $e',
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showInviteByEmailDialog() async {
    final controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        bool isLoading = false;
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Invite by Email'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller,
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    decoration: const InputDecoration(
                      hintText: 'Email address',
                      labelText: 'Email',
                    ),
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty && !isLoading) {
                        _handleInviteByEmail(value.trim(), setDialogState, () => isLoading = true);
                      }
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              final email = controller.text.trim();
                              if (email.isNotEmpty) {
                                _handleInviteByEmail(email, setDialogState, () => isLoading = true);
                              }
                            },
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Send Invite'),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _handleInviteByEmail(
    String email,
    Function(void Function()) setDialogState,
    void Function() setLoadingTrue,
  ) async {
    setLoadingTrue();
    setDialogState(() {});
    try {
      await Supabase.instance.client.rpc(
        'invite_member_by_email',
        params: {'room_id': widget.room.id, 'email': email},
      );
      if (!mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invite sent to $email')),
      );
      _refreshMembers();
    } catch (e) {
      if (!mounted) return;
      setDialogState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().contains('No Shelf account found')
                ? 'No Shelf account found with that email'
                : 'Could not send invite: $e',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Members',
      showBackButton: true,
      body: FutureBuilder<List<RoomMember>>(
        future: _membersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Could not load members.\n${snapshot.error}',
                    style: AppTextStyles.body,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  FilledButton(
                    onPressed: () => setState(() {
                      _membersFuture = _loadMembers();
                    }),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final members = snapshot.data ?? [];

          return Stack(
            children: [
              if (members.isEmpty)
                const Center(child: Text('No members yet.'))
              else
                ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.containerMargin),
                  itemCount: members.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final member = members[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          member.displayName.isNotEmpty
                              ? member.displayName[0].toUpperCase()
                              : '?',
                        ),
                      ),
                      title: Text(member.displayName, style: AppTextStyles.body),
                      trailing: member.isCreator
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: AppSpacing.xs,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryButton.withValues(alpha: 0.1),
                                borderRadius:
                                    BorderRadius.circular(AppRadius.sm),
                              ),
                              child: Text(
                                'Creator',
                                style: AppTextStyles.metadata.copyWith(
                                  color: AppColors.primaryButton,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : null,
                    );
                  },
                ),
              Positioned(
                right: AppSpacing.containerMargin,
                bottom: AppSpacing.containerMargin,
                child: FloatingActionButton(
                  onPressed: _showInviteSheet,
                  child: const Icon(Icons.person_add),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class RoomMember {
  final String userId;
  final String displayName;
  final DateTime joinedAt;
  final bool isCreator;

  RoomMember({
    required this.userId,
    required this.displayName,
    required this.joinedAt,
    required this.isCreator,
  });

  factory RoomMember.fromJson(Map<String, dynamic> json) {
    return RoomMember(
      userId: json['user_id'] as String,
      displayName: json['display_name'] as String? ?? 'Unknown',
      joinedAt: DateTime.parse(json['joined_at'] as String),
      isCreator: json['is_creator'] as bool? ?? false,
    );
  }
}