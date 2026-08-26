class Chapter {
  const Chapter({
    required this.id,
    required this.subjectId,
    required this.name,
    required this.position,
    required this.createdAt,
  });

  final String id;
  final String subjectId;
  final String name;
  final int position;
  final DateTime createdAt;

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'] as String,
      subjectId: json['subject_id'] as String,
      name: json['name'] as String,
      position: json['position'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject_id': subjectId,
      'name': name,
      'position': position,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
