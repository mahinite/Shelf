class NoteDocument {
  const NoteDocument({
    required this.id,
    required this.chapterId,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    this.filePath,
    this.fileSize,
    this.pageCount,
    required this.position,
  });

  final String id;
  final String chapterId;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? filePath;
  final int? fileSize;
  final int? pageCount;
  final int position;

  factory NoteDocument.fromJson(Map<String, dynamic> json) {
    return NoteDocument(
      id: json['id'] as String,
      chapterId: json['chapter_id'] as String,
      title: json['title'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      filePath: json['file_path'] as String?,
      fileSize: json['file_size'] as int?,
      pageCount: json['page_count'] as int?,
      position: json['position'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chapter_id': chapterId,
      'title': title,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'file_path': filePath,
      'file_size': fileSize,
      'page_count': pageCount,
      'position': position,
    };
  }
}