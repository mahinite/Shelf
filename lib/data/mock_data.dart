import '../features/chapters/models/chapter.dart';
import '../features/documents/models/note.dart';
import '../features/rooms/models/room.dart';
import '../features/subjects/models/subject.dart';

/// Static mock data for the MVP. Nothing here is persisted or fetched —
/// this is just enough shape to make every screen in the hierarchy
/// reachable and populated. Replace with real data once storage exists.
class MockData {
  MockData._();

  static final List<Room> rooms = [
    Room(
      name: 'Math + Physics',
      subjects: [_mathematics, _physics],
    ),
    Room(
      name: 'Physics',
      subjects: [_physics],
    ),
    Room(
      name: 'Math',
      subjects: [_mathematics],
    ),
  ];

  static final Subject _mathematics = Subject(
    name: 'Mathematics',
    chapters: [
      Chapter(
        name: 'Algebra',
        notes: const NoteDocument(title: 'Algebra — Notes', pageCount: 12),
        exercises: const [
          NoteDocument(title: 'Exercise 01', pageCount: 3),
          NoteDocument(title: 'Exercise 02', pageCount: 4),
        ],
      ),
      Chapter(
        name: 'Calculus',
        notes: const NoteDocument(title: 'Calculus — Notes', pageCount: 18),
        exercises: const [
          NoteDocument(title: 'Exercise 01', pageCount: 5),
        ],
      ),
      Chapter(
        name: 'Vectors',
        notes: const NoteDocument(title: 'Vectors — Notes', pageCount: 9),
        // No exercises for this chapter — intentionally empty.
      ),
    ],
  );

  static final Subject _physics = Subject(
    name: 'Physics',
    chapters: [
      Chapter(
        name: 'Kinematics',
        notes: const NoteDocument(title: 'Kinematics — Notes', pageCount: 14),
        exercises: const [
          NoteDocument(title: 'Exercise 01', pageCount: 6),
          NoteDocument(title: 'Exercise 02', pageCount: 5),
          NoteDocument(title: 'Exercise 03', pageCount: 4),
        ],
      ),
      Chapter(
        name: 'Thermodynamics',
        notes: const NoteDocument(
          title: 'Thermodynamics — Notes',
          pageCount: 11,
        ),
      ),
    ],
  );
}
