/// Spacing scale, taken directly from DESIGN.md.
/// Generous spacing is a core part of the "calm notebook" feel —
/// prefer reaching for lg/xl between sections rather than cramming.
class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  /// Outer horizontal margin for screen content.
  static const double containerMargin = 20;
}

/// Corner radii. Kept small and simple per the brief —
/// no large rounded "pill" shapes anywhere.
class AppRadius {
  AppRadius._();

  static const double sm = 4;
  static const double md = 8;
}
