class ScanPage {
  const ScanPage({
    required this.id,
    required this.batchId,
    required this.documentId,
    required this.pageOrder,
    required this.filePath,
    required this.createdAt,
  });

  final String id;
  final String batchId;
  final String documentId;
  final int pageOrder;
  final String filePath;
  final DateTime createdAt;

  factory ScanPage.fromJson(Map<String, dynamic> json) {
    return ScanPage(
      id: json['id'] as String,
      batchId: json['batch_id'] as String,
      documentId: json['document_id'] as String,
      pageOrder: json['page_order'] as int,
      filePath: json['file_path'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'batch_id': batchId,
      'document_id': documentId,
      'page_order': pageOrder,
      'file_path': filePath,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
