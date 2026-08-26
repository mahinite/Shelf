class Subject {
  const Subject({
    required this.id,
    required this.roomId,
    required this.name,
    this.color,
    required this.position,
    required this.createdAt,
  });

  final String id;
  final String roomId;
  final String name;
  final String? color;
  final int position;
  final DateTime createdAt;

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'] as String,
      roomId: json['room_id'] as String,
      name: json['name'] as String,
      color: json['color'] as String?,
      position: json['position'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'room_id': roomId,
      'name': name,
      'color': color,
      'position': position,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
