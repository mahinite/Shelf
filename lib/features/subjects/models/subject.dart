import '../../chapters/models/chapter.dart';

class Subject {
  const Subject({
    required this.name,
    required this.chapters,
  });

  final String name;
  final List<Chapter> chapters;
}
