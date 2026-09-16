import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/services/cache_service.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/rename_delete_sheet.dart';
import '../../rooms/widgets/room_card.dart';
import '../../rooms/screens/room_screen.dart';
import '../../rooms/models/room.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Room> _rooms = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    const cacheKey = 'rooms';

    final cached = await CacheService.instance.readList(cacheKey);
    if (!mounted) return;

    if (cached != null) {
      setState(() {
        _rooms = cached.map((json) => Room.fromJson(json)).toList();
        _isLoading = false;
        _error = null;
      });
    }

    try {
      final rooms = await _loadRooms();
      if (!mounted) return;
      setState(() {
        _rooms = rooms;
        _isLoading = false;
        _error = null;
      });
      await CacheService.instance.writeList(
        cacheKey,
        rooms.map((r) => r.toJson()).toList(),
      );
    } catch (e) {
      if (!mounted) return;
      if (_rooms.isNotEmpty) {
        return;
      }
      setState(() {
        _error = 'Could not load your study rooms.\n\n$e';
        _isLoading = false;
      });
    }
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

    return (response as List).map((json) => Room.fromJson(json)).toList();
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

      _load();

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

  Future<void> _renameRoom(Room room, String newName) async {
    try {
      await Supabase.instance.client
          .from('rooms')
          .update({'name': newName}).eq('id', room.id);

      if (!mounted) return;

      _load();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Room renamed to $newName')),
        );
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not rename room.\n$error')),
      );
    }
  }

  Future<void> _deleteRoom(Room room) async {
    try {
      final result = await Supabase.instance.client.from('rooms').delete().eq('id', room.id).select();

      if (!mounted) return;

      if (result.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You don\'t have permission to delete this room')),
        );
        return;
      }

      _load();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Room deleted')),
        );
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not delete room.\n$error')),
      );
    }
  }

  Future<void> _joinRoomByCode() async {
    final controller = TextEditingController();

    final code = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Join Room'),
          content: TextField(
            controller: controller,
            autofocus: true,
            textCapitalization: TextCapitalization.characters,
            decoration: const InputDecoration(
              hintText: 'Invite code',
              labelText: 'Invite Code',
            ),
            onSubmitted: (value) {
              final trimmed = value.trim().toUpperCase();
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
                final trimmed = controller.text.trim().toUpperCase();
                if (trimmed.isNotEmpty) {
                  Navigator.of(context).pop(trimmed);
                }
              },
              child: const Text('Join'),
            ),
          ],
        );
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.dispose();
    });

    if (code == null || code.isEmpty) {
      return;
    }

    try {
      final response = await Supabase.instance.client.rpc(
        'join_room_by_code',
        params: {'code': code},
      );

      if (!mounted) return;

      // join_room_by_code returns a single room object (not a list)
      debugPrint('join_room_by_code raw response: $response');
      if (response == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid invite code')),
        );
        return;
      }
      final room = Room.fromJson(response as Map<String, dynamic>);

      _load();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Joined "${room.name}"')),
        );

        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => RoomScreen(room: room),
          ),
        );

        if (mounted) {
          _load();
        }
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not join room: $e')),
      );
    }
  }

  void _showRoomActions(Room room) {
    final currentUserId = Supabase.instance.client.auth.currentUser?.id;
    final isCreator = currentUserId == room.createdBy;
    
    showRenameDeleteSheet(
      context: context,
      currentName: room.name,
      itemType: 'Room',
      hasChildren: true,
      onRename: isCreator ? (newName) => _renameRoom(room, newName) : null,
      onDelete: isCreator ? () => _deleteRoom(room) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Shelf',
      body: Stack(
        children: [
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else if (_error != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(
                  AppSpacing.containerMargin,
                ),
                child: Text(
                  _error!,
                  style: AppTextStyles.body,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          else
            ListView(
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
                if (_rooms.isEmpty)
                  const Text('No study rooms yet.')
                else
                  for (final room in _rooms) ...[
                    RoomCard(
                      room: room,
                      onTap: () async {
                        await Navigator.of(context).push<bool>(
                          MaterialPageRoute(
                            builder: (_) => RoomScreen(
                              room: room,
                            ),
                          ),
                        );
                        if (mounted) {
                          _load();
                        }
                      },
                      onLongPress: () => _showRoomActions(room),
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],
                const SizedBox(height: 80),
              ],
            ),
          Positioned(
            right: AppSpacing.containerMargin,
            bottom: AppSpacing.containerMargin,
            child: FloatingActionButton(
              onPressed: _createRoom,
              child: const Icon(Icons.add),
            ),
          ),
          Positioned(
            right: AppSpacing.containerMargin * 3 + 56, // FAB width + margin
            bottom: AppSpacing.containerMargin,
            child: FloatingActionButton.small(
              onPressed: _joinRoomByCode,
              heroTag: 'joinRoomFab',
              child: const Icon(Icons.login),
            ),
          ),
        ],
      ),
    );
  }
}
