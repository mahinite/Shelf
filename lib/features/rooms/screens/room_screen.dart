import 'package:flutter/material.dart';
import '../models/room.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../subjects/widgets/subject_list_item.dart';
import '../../subjects/screens/subject_screen.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key, required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: room.name,
      showBackButton: true,
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.containerMargin),
        itemCount: room.subjects.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, index) {
          final subject = room.subjects[index];
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
      ),
    );
  }
}
