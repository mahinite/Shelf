import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/room.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../subjects/models/subject.dart';
import '../../subjects/widgets/subject_list_item.dart';
import '../../subjects/screens/subject_screen.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key, required this.room});

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
        .select('*, chapters(count)')
        .eq('room_id', widget.room.id)
        .order('position', ascending: true);

    return (data as List)
        .map((json) => Subject.fromJson(json))
        .toList();
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

          if (subjects.isEmpty) {
            return const Center(
              child: Text('No subjects yet.'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.containerMargin),
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
                      builder: (_) => SubjectScreen(subject: subject),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}