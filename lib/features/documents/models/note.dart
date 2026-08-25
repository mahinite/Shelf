/// A single notes document within a chapter (or an exercise).
/// This is a placeholder model for the MVP — no real pages/scans yet,
/// just enough shape to render the Notes screen.
class NoteDocument {
  const NoteDocument({
    required this.title,
    required this.pageCount,
  });

  final String title;
  final int pageCount;
}
