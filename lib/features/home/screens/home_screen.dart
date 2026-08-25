import 'package:flutter/material.dart';
import '../../../data/mock_data.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../rooms/widgets/room_card.dart';
import '../../rooms/screens/room_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Shelf',
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.containerMargin),
        children: [
          Text('Good to see you', style: AppTextStyles.largeTitle),
          const SizedBox(height: AppSpacing.xl),
          Text('Your Study Rooms', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          for (final room in MockData.rooms) ...[
            RoomCard(
              room: room,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => RoomScreen(room: room)),
                );
              },
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ],
      ),
    );
  }
}
