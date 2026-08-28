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
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('No authenticated user.');
    }

    debugPrint('LOAD ROOMS: user = ${user.id}');
    debugPrint(
      'LOAD ROOMS: session exists = ${supabase.auth.currentSession != null}',
    );

    final response = await supabase
        .from('rooms')
        .select(
          'id, name, created_by, created_at, '
          'subjects(count), '
          'room_members!inner(user_id)',
        )
        .eq('room_members.user_id', user.id)
        .order('created_at', ascending: true);

    return (response as List)
        .map((json) => Room.fromJson(json))
        .toList();
  }

  Future<void> _createRoom() async {
    debugPrint('CREATE ROOM: started');

    final controller = TextEditingController();

    final name = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('New Study Room'),
          content: TextField(
            controller: controller,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              hintText: 'Room name',
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
              onPressed: () {
                Navigator.of(context).pop();
              },
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
      debugPrint('CREATE ROOM: cancelled');
      return;
    }

    debugPrint('CREATE ROOM: name = $name');

    try {
      final supabase = Supabase.instance.client;

      debugPrint('CREATE ROOM: checking auth');

      final user = supabase.auth.currentUser;

      if (user == null) {
        debugPrint('CREATE ROOM: NO USER');
        throw Exception('No authenticated user.');
      }

      final session = supabase.auth.currentSession;

      debugPrint('CREATE ROOM: user = ${user.id}');
      debugPrint(
        'CREATE ROOM: session exists = ${session != null}',
      );

      if (session == null) {
        throw Exception('No active Supabase session.');
      }

      if (session.isExpired) {
        debugPrint('CREATE ROOM: session is expired');
        throw Exception('Supabase session has expired.');
      }

      debugPrint('CREATE ROOM: attempting rooms INSERT');

      final room = await supabase
          .from('rooms')
          .insert({
            'name': name,
            'created_by': user.id,
          })
          .select()
          .single();

      debugPrint(
        'CREATE ROOM: room created = ${room['id']}',
      );

      debugPrint('CREATE ROOM: adding room member');

      await supabase.from('room_members').insert({
        'room_id': room['id'],
        'user_id': user.id,
      });

      debugPrint('CREATE ROOM: member created');

      if (!mounted) return;

      setState(() {
        _roomsFuture = _loadRooms();
      });

      debugPrint('CREATE ROOM: complete');
    } catch (error) {
      debugPrint('CREATE ROOM ERROR: $error');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Could not create room.\n$error',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Shelf',
      body: Stack(
        children: [
          FutureBuilder<List<Room>>(
            future: _roomsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(
                      AppSpacing.containerMargin,
                    ),
                    child: Text(
                      'Could not load your study rooms.\n\n${snapshot.error}',
                      style: AppTextStyles.body,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              final rooms = snapshot.data ?? [];

              return ListView(
                padding: const EdgeInsets.all(
                  AppSpacing.containerMargin,
                ),
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
                              builder: (_) => RoomScreen(
                                room: room,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: AppSpacing.md),
                    ],
                  const SizedBox(height: 80),
                ],
              );
            },
          ),
          Positioned(
            right: AppSpacing.containerMargin,
            bottom: AppSpacing.containerMargin,
            child: FloatingActionButton(
              onPressed: _createRoom,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}