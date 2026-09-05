class Room {
  const Room({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.createdAt,
    this.subjectCount,
    this.inviteCode,
  });

  final String id;
  final String name;
  final String createdBy;
  final DateTime createdAt;
  final int? subjectCount;
  final String? inviteCode;

  factory Room.fromJson(Map<String, dynamic> json) {
    final subjects = json['subjects'];

    return Room(
      id: json['id'] as String,
      name: json['name'] as String,
      createdBy: json['created_by'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      subjectCount: subjects is List && subjects.isNotEmpty
          ? (subjects.first['count'] as int?)
          : null,
      inviteCode: json['invite_code'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'invite_code': inviteCode,
    };
  }
}