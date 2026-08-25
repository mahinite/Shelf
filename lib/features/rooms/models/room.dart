import '../../subjects/models/subject.dart';

/// Rooms are the top level of the hierarchy. Per the design brief,
/// rooms are visually neutral — no accent color is stored here on
/// purpose, unlike Subject which drives color through AppColors.subjectAccent.
class Room {
  const Room({
    required this.name,
    required this.subjects,
  });

  final String name;
  final List<Subject> subjects;
}
