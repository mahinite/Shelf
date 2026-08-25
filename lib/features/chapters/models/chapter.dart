import '../../documents/models/note.dart';

/// A chapter always has one Notes document, and may optionally have
/// exercises. Exercises are NOT forced — [exercises] can be empty.
class Chapter {
  const Chapter({
    required this.name,
    required this.notes,
    this.exercises = const [],
  });

  final String name;
  final NoteDocument notes;
  final List<NoteDocument> exercises;
}
