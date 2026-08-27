import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/room.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../subjects/models/subject.dart';
import '../../subjects/widgets/subject_list_item.dart';
import '../../subjects/screens/subject_screen.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({
    super.key,
    required this.room,
  });

  final Room room;

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  late Future<List<Subject>> _subjectsFuture;

  @override
  void initState() {
    super.initState();
    _subjectsFuture = _loadSubjects();
  }

  Future<List<Subject>> _loadSubjects() async {
    final data = await Supabase.instance.client
        .from('subjects')
        .select()
        .eq('room_id', widget.room.id)
        .order('position', ascending: true);

    return (data as List)
        .map((json) => Subject.fromJson(json))
        .toList();
  }

  Future<void> _createSubject() async {
    final controller = TextEditingController();

    final name = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('New Subject'),
          content: TextField(
            controller: controller,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              hintText: 'Subject name',
            ),
            onSubmitted: (value) {
              final trimmed = value.trim();
              if (trimmed.isNotEmpty) {
                Navigator.of(context).pop(trimmed);
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

                if (trimmed.isNotEmpty) {
                  Navigator.of(context).pop(trimmed);
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );

   WidgetsBinding.instance.addPostFrameCallback((_) {
  controller.dispose();
});

if (name == null || name.isEmpty) {
      return;
    }

    try {
      final nextPosition = await _nextSubjectPosition();

      await Supabase.instance.client.from('subjects').insert({
        'room_id': widget.room.id,
        'name': name,
        'position': nextPosition,
      });

      if (!mounted) return;

      setState(() {
        _subjectsFuture = _loadSubjects();
      });
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not create subject.\n$error'),
        ),
      );
    }
  }

  Future<int> _nextSubjectPosition() async {
    final data = await Supabase.instance.client
        .from('subjects')
        .select('position')
        .eq('room_id', widget.room.id)
        .order('position', ascending: false)
        .limit(1);

    if (data.isEmpty) {
      return 0;
    }

    return (data.first['position'] as int) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: widget.room.name,
      showBackButton: true,
      body: FutureBuilder<List<Subject>>(
        future: _subjectsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Could not load subjects.\n${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          final subjects = snapshot.data ?? [];

          return Stack(
            children: [
              if (subjects.isEmpty)
                const Center(
                  child: Text('No subjects yet.'),
                )
              else
                ListView.separated(
                  padding: const EdgeInsets.all(
                    AppSpacing.containerMargin,
                  ),
                  itemCount: subjects.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final subject = subjects[index];

                    return SubjectListItem(
                      subject: subject,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => SubjectScreen(
                              subject: subject,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

              Positioned(
                right: AppSpacing.containerMargin,
                bottom: AppSpacing.containerMargin,
                child: FloatingActionButton(
                  onPressed: _createSubject,
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}