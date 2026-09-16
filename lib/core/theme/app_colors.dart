import 'package:flutter/material.dart';

/// Color tokens for Shelf.
///
/// Light values are synchronized with DESIGN.md's frontmatter `colors:`
/// block (the authoritative M3 export). Where the DESIGN.md prose disagrees
/// with the frontmatter on a hex value, the frontmatter value is used
/// provisionally — conflicts are documented in the Phase 0 summary.
/// Dark values marked as approximations have no explicit dark token in
/// DESIGN.md (single-mode export) and are engineering judgment calls.
class AppColors {
  AppColors._();

  // Base surface (light)
  static const background = Color(0xFFFBF9F9); // DESIGN.md 'background' (prose conflicts: cream F9F7F2)
  static const surfaceCard = Color(0xFFFFFFFF); // DESIGN.md 'surface-container-lowest' — Level 1 pure white

  // Text (light)
  static const textPrimary = Color(0xFF1B1C1C); // DESIGN.md 'on-surface' (prose conflicts: charcoal 2D2D2D)
  static const textSecondary = Color(0xFF444748); // DESIGN.md 'on-surface-variant' (prose conflicts: grey 717171)

  // Structure (light)
  static const border = Color(0xFFC4C7C7); // DESIGN.md 'outline-variant' (prose conflicts: EAE7E0)
  static const divider = Color(0xFFC4C7C7); // DESIGN.md 'outline-variant' (prose conflicts: EAE7E0)

  // Primary action (buttons) — same for both themes
  static const primaryButton = Color(0xFF181919); // DESIGN.md 'primary' (prose conflicts: charcoal 2D2D2D)
  static const onPrimaryButton = Color(0xFFFFFFFF); // DESIGN.md 'on-primary' (prose conflicts: cream text)
  // Destructive (delete) color — DESIGN.md 'error'
  static const destructive = Color(0xFFBA1A1A);

  // Subject accents — used sparingly (side borders, pips, underlines).
  // Rooms are intentionally NOT assigned a color from this set.
  static const mathAccent = Color(0xFF8A9A7E); // Sage Green
  static const physicsAccent = Color(0xFF7C93A8); // Dusty Blue
  static const literatureAccent = Color(0xFFC97B63); // Muted Coral
  static const chemistryAccent = Color(0xFFB08D57); // Warm Ochre
  static const historyAccent = Color(0xFF9E7B8C); // Muted Plum

  // Base surface (dark) — DESIGN.md 'inverse-surface'
  static const backgroundDark = Color(0xFF303031);
  // Approximation: ~1 tonal step lighter than backgroundDark, preserving
  // inverse-surface's slight tint (+1 blue); DESIGN.md has no dark card token.
  static const surfaceCardDark = Color(0xFF3A3A3B);

  // Text (dark) — DESIGN.md 'inverse-on-surface'
  static const textPrimaryDark = Color(0xFFF2F0F0);
  // Approximation: neutral grey tuned to keep the existing dark-theme
  // secondary-text contrast ratio (~6.4:1) on the new, lighter background.
  static const textSecondaryDark = Color(0xFFB5B5B5);

  // Structure (dark) — DESIGN.md 'outline' (M3 keeps the outline role
  // mode-invariant, so dark borders/dividers map to it; DESIGN.md defines
  // no explicit dark border token).
  static const borderDark = Color(0xFF747878);
  static const dividerDark = Color(0xFF747878);

  // Primary action (dark) — DESIGN.md 'primary-fixed-dim' (dark-mode accent)
  static const primaryFixedDim = Color(0xFFC8C6C6);

  /// Looks up a subject's accent color by subject name.
  /// Falls back to textSecondary (neutral) for unrecognized subjects,
  /// rather than guessing a color.
  static Color subjectAccent(String subjectName) {
    switch (subjectName.toLowerCase()) {
      case 'math':
      case 'mathematics':
        return mathAccent;
      case 'physics':
        return physicsAccent;
      case 'literature':
        return literatureAccent;
      case 'chemistry':
        return chemistryAccent;
      case 'history':
        return historyAccent;
      default:
        return textSecondary;
    }
  }
}
