class ScanBatch {
  const ScanBatch({
    required this.id,
    required this.documentId,
    required this.scannedBy,
    required this.createdAt,
  });

  final String id;
  final String documentId;
  final String scannedBy;
  final DateTime createdAt;

  factory ScanBatch.fromJson(Map<String, dynamic> json) {
    return ScanBatch(
      id: json['id'] as String,
      documentId: json['document_id'] as String,
      scannedBy: json['scanned_by'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'document_id': documentId,
      'scanned_by': scannedBy,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
