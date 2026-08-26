import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../rooms/widgets/room_card.dart';
import '../../rooms/screens/room_screen.dart';
import '../../rooms/models/room.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Room>> _roomsFuture;

  @override
  void initState() {
    super.initState();
    _roomsFuture = _loadRooms();
  }

  Future<List<Room>> _loadRooms() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      throw Exception('No authenticated user.');
    }

    final response = await Supabase.instance.client
        .from('rooms')
        .select(
          'id, name, created_by, created_at, '
          'room_members!inner(user_id)',
        )
        .eq('room_members.user_id', user.id)
        .order('created_at', ascending: true);

    return (response as List)
        .map((json) => Room.fromJson(json))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Shelf',
      body: FutureBuilder<List<Room>>(
        future: _roomsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Could not load your study rooms.',
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
              ),
            );
          }

          final rooms = snapshot.data ?? [];

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.containerMargin),
            children: [
              Text(
                'Good to see you',
                style: AppTextStyles.largeTitle,
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                'Your Study Rooms',
                style: AppTextStyles.sectionTitle,
              ),
              const SizedBox(height: AppSpacing.md),
              if (rooms.isEmpty)
                const Text('No study rooms yet.')
              else
                for (final room in rooms) ...[
                  RoomCard(
                    room: room,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => RoomScreen(room: room),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
            ],
          );
        },
      ),
    );
  }
}