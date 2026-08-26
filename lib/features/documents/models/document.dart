class Document {
  const Document({
    required this.id,
    required this.chapterId,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String chapterId;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'] as String,
      chapterId: json['chapter_id'] as String,
      title: json['title'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chapter_id': chapterId,
      'title': title,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
