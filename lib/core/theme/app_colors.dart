import 'package:flutter/material.dart';

/// Color tokens for Shelf.
///
/// This is a deliberately small subset of DESIGN.md's full token set —
/// only what the MVP scope actually uses. DESIGN.md defines many more
/// tokens (tertiary-fixed, inverse-surface, etc.) that exist for future
/// screens we are not building yet.
class AppColors {
  // Destructive action (e.g., delete) – a muted red that fits the notebook aesthetic
  AppColors._();

  // Base surface (light)
  static const background = Color(0xFFF9F7F2); // warm cream
  static const surfaceCard = Color(0xFFFFFFFF); // level-1 card surface

  // Text (light)
  static const textPrimary = Color(0xFF2D2D2D); // charcoal
  static const textSecondary = Color(0xFF717171); // muted grey

  // Structure (light)
  static const border = Color(0xFFEAE7E0); // very subtle 1px borders
  static const divider = Color(0xFFEAE7E0);

  // Primary action (buttons) — same for both themes
  static const primaryButton = Color(0xFF2D2D2D); // charcoal fill
  static const onPrimaryButton = Color(0xFFF9F7F2); // cream text
  // Destructive (delete) color – muted red matching the notebook aesthetic
  static const destructive = Color(0xFFB05A5A);

  // Subject accents — used sparingly (side borders, pips, underlines).
  // Rooms are intentionally NOT assigned a color from this set.
  static const mathAccent = Color(0xFF8A9A7E); // Sage Green
  static const physicsAccent = Color(0xFF7C93A8); // Dusty Blue
  static const literatureAccent = Color(0xFFC97B63); // Muted Coral
  static const chemistryAccent = Color(0xFFB08D57); // Warm Ochre
  static const historyAccent = Color(0xFF9E7B8C); // Muted Plum

  // Base surface (dark)
  static const backgroundDark = Color(0xFF1E1E1E); // near-black
  static const surfaceCardDark = Color(0xFF2A2A2A); // elevated surface

  // Text (dark)
  static const textPrimaryDark = Color(0xFFF9F7F2); // cream
  static const textSecondaryDark = Color(0xFFA0A0A0); // muted grey

  // Structure (dark)
  static const borderDark = Color(0xFF3A3A3A); // subtle borders
  static const dividerDark = Color(0xFF3A3A3A);

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
