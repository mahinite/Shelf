# Shelf UI Token Direction Plan

**Goal:** make every color/style in Shelf flow through replaceable, reusable, theme-aware
tokens, so that enabling dark mode later (or changing the palette at all) touches **only the
token layer** — never a screen or widget.

**Basis:** investigation of 2026-09-15 (first-launch UI inconsistencies). Root causes:
dark mode silently active while screens hardcode light colors; M3 `ColorScheme.fromSeed`
hue instability on near-neutral seeds; triple `ThemeModeNotifier` instance bug. This plan
prevents all three classes of failure structurally. No code changes are made yet — fixes
await approval.

---

## 1. Principles

1. **Widgets never reference raw colors.** No `AppColors.*`, no `Colors.*` outside
   `lib/core/theme/`. All 51 current direct usages (inventoried in §5) migrate to tokens.
2. **Semantic, not decorative.** Tokens describe *roles* (`surface`, `textPrimary`,
   `accent`), not hex values. Swapping the palette = swapping two token instances.
3. **Theme-resolved by the framework.** A widget must not need to know the current
   brightness. Tokens resolve from `Theme.of(context)` (ThemeExtension).
4. **Component themes stay complete.** Every Material widget type used by the app gets its
   color slots pinned in `AppTheme` for both variants (this is what broke with the FABs:
   `floatingActionButtonTheme` was missing, so M3 defaults derived unpredictable colors
   from a neutral seed — light blue in light mode, olive green in dark mode).
5. **One theme-mode source of truth.** Single `ThemeModeNotifier` instance. Today three
   exist (main.dart:49 discarded, main.dart:63 drives MaterialApp, settings_screen.dart:44
   never-loaded), which makes theme changes appear launch-dependent.

---

## 2. Token architecture (3 layers)

### Layer 1 — Primitives (exists, stays)

`AppColors` keeps the raw hex constants as the **only** place hex values live:

- Light: `background F9F7F2`, `surfaceCard FFFFFF`, `textPrimary 2D2D2D`,
  `textSecondary 717171`, `border/divider EAE7E0`, `primaryButton 2D2D2D`,
  `onPrimaryButton F9F7F2`, `destructive B05A5A`
- Dark: `backgroundDark 1E1E1E`, `surfaceCardDark 2A2A2A`, `textPrimaryDark F9F7F2`,
  `textSecondaryDark A0A0A0`, `borderDark/dividerDark 3A3A3A`
- Subject accents (mode-independent by design): math/physics/literature/chemistry/history.

### Layer 2 — Semantic role tokens (new, theme-aware)

A `ThemeExtension` so tokens resolve from context and both modes are defined side by side:

```dart
// lib/core/theme/shelf_colors.dart
class ShelfColors extends ThemeExtension<ShelfColors> {
  final Color background;    // page/scaffold + app bar (was AppColors.background)
  final Color surface;       // cards, bottom bar, sheets, picker selection (was surfaceCard)
  final Color surfaceSubtle; // soft fills/chips (replaces primaryButton.withValues(alpha:0.1))
  final Color border;        // 1px outlines
  final Color divider;
  final Color gridLine;      // notebook background grid (alpha 0.035 today)
  final Color textPrimary;
  final Color textSecondary;
  final Color accent;        // primary-action fill (FABs, scan circle, save button)
  final Color onAccent;      // icon/text on accent (replaces Colors.white spinners)
  final Color destructive;

  static const light = ShelfColors(
    background: AppColors.background, surface: AppColors.surfaceCard,
    surfaceSubtle: Color(0x1A2D2D2D), border: AppColors.border, divider: AppColors.divider,
    gridLine: AppColors.textPrimary, // painted with alpha 0.035
    textPrimary: AppColors.textPrimary, textSecondary: AppColors.textSecondary,
    accent: AppColors.primaryButton, onAccent: AppColors.onPrimaryButton,
    destructive: AppColors.destructive,
  );
  static const dark = ShelfColors(
    background: AppColors.backgroundDark, surface: AppColors.surfaceCardDark,
    surfaceSubtle: Color(0x1AF9F7F2), border: AppColors.borderDark, divider: AppColors.dividerDark,
    gridLine: AppColors.textPrimaryDark,
    textPrimary: AppColors.textPrimaryDark, textSecondary: AppColors.textSecondaryDark,
    accent: /* decision D2 */, onAccent: AppColors.backgroundDark,
    destructive: AppColors.destructive,
  );
  // lerp() required by ThemeExtension — copyWith pattern.
}

// Context accessor — the ONLY public API widgets use:
extension ShelfColorsX on BuildContext {
  ShelfColors get colors => Theme.of(this).extension<ShelfColors>()!;
}
```

`ColorScheme.fromSeed` is retained as Material machinery but is **no longer trusted for
hue-sensitive roles** — every component theme slot pins explicit colors from
`ShelfColors` (see §4). This removes the fromSeed instability class entirely.

### Layer 3 — Theme-aware text styles

`AppTextStyles` currently hardcodes light colors in parameterless getters; the dark theme
has to `copyWith` dark colors separately, and direct call sites (every screen) always get
light colors. Make styles token-driven:

```dart
class ShelfTextStyles {
  TextStyle largeTitle(ShelfColors c) => GoogleFonts.inter(
      fontSize: 30, fontWeight: FontWeight.w700, height: 1.2, color: c.textPrimary);
  // sectionTitle, body, bodySecondary, metadata, buttonLabel same pattern.
}

extension ShelfTextStylesX on BuildContext {
  ShelfTextStyles get textStyles => ShelfTextStyles();
}
// Call site: Text('Welcome back', style: context.textStyles.largeTitle(context.colors))
```

`AppTheme` builds both `textTheme`s from the same functions with each mode's token set —
the `copyWith(color: …)` duplication in `darkTheme` disappears.

---

## 3. Component theme completeness (the "nothing breaks" guarantee)

Add the missing slots to **both** `AppTheme.theme` and `AppTheme.darkTheme`, pinned to
tokens (never fromSeed-derived defaults):

| Slot | Why it must exist (evidence from investigation) |
|---|---|
| `floatingActionButtonTheme` | **Missing today** → FABs got fromSeed defaults: light blue (light) / olive green (dark). Pin `backgroundColor: accent`, `foregroundColor: onAccent`. |
| `listTileTheme` | Settings/room/chapter ListTiles inherit `onSurface` (near-white in dark) on cream scaffold → the reported contrast bug. Pin `iconColor`, `textColor`, `titleTextStyle`, `subtitleTextStyle`. |
| `dialogTheme` / `AlertDialog` text styles | Dialogs currently inherit fromSeed surfaces; in dark mode they render dark surfaces over cream screens. |
| `snackBarTheme` | SnackBars used everywhere for errors; pin bg/text/action colors for both modes. |
| `switchTheme` | Dark Mode toggle in Settings. |
| `filledButtonTheme` | Dialog confirm buttons (Create/Join/Delete) use `FilledButton` — currently unpinned. |
| `progressIndicatorTheme` | Replaces the three hardcoded `Colors.white` spinners. |
| `appBarTheme` | `AppScaffold` hardcodes bg/icon colors today; centralize here. |
| `bottomSheetTheme` | `rename_delete_sheet`, `HierarchyPickerSheet`. |
| `switch`/`iconTheme`/`dividerTheme`/`inputDecorationTheme` | Already partially present; keep and retoken. |

---

## 4. Migration map (current hardcode → token)

Inventory from codebase grep (51 direct `AppColors` usages + 3 `Colors.white`):

| Current | Files | New token |
|---|---|---|
| `AppColors.background` | app_scaffold.dart:100,102 · notebook_background.dart:18 | `colors.background` |
| `AppColors.surfaceCard` | room_card.dart:31 · subject_list_item.dart:32 · bottom_action_bar.dart:30 · hierarchy_picker_sheet.dart:363,389 · google_sign_in_button.dart:76 | `colors.surface` |
| `AppColors.border` | room_card.dart:33 · subject_list_item.dart:34 · bottom_action_bar.dart:31 · hierarchy_picker_sheet.dart:248 · scan_config_screen.dart:231,259 | `colors.border` |
| `AppColors.textPrimary` | bottom_action_bar.dart:43,72 · app_scaffold.dart:106 · hierarchy_picker_sheet.dart:205 · scan_config_screen.dart:149 · google_sign_in_button.dart:77,92,110 · all AppTextStyles | `colors.textPrimary` |
| `AppColors.textSecondary` | room_card.dart:52 · subject_list_item.dart:70 · subject_screen.dart:315 · document_list_item.dart:59 · hierarchy_picker_sheet.dart:257,361,387 · scan_config_screen.dart:205,241,269 | `colors.textSecondary` |
| `AppColors.primaryButton` (fills) | bottom_action_bar.dart:57 · scan_config_screen.dart:181 · room_members_screen.dart:549 (`withValues(alpha:.1)`) | `colors.accent` / `colors.surfaceSubtle` |
| `AppColors.onPrimaryButton` | bottom_action_bar.dart:62 · scan_config_screen.dart:205 | `colors.onAccent` |
| `AppColors.destructive` | settings_screen.dart:73,74,317 · rename_delete_sheet | `colors.destructive` |
| `Colors.white` spinners | login_screen.dart:162 · settings_screen.dart:343 · pdf_badge_icon.dart:27 | theme progress color / `colors.onAccent` |
| Grid line `withValues(alpha:0.035)` | notebook_background.dart:34 | `colors.gridLine` painted with alpha |
| fromSeed-derived (FABs, ListTiles, dialogs, switch) | app_theme.dart (missing slots) | pinned component themes (§3) |

---

## 5. Rollout phases (each phase leaves light mode fully working)

- **Phase 0 — Theme-mode source of truth (prerequisite).**
  Singleton `ThemeModeNotifier.instance`; `main()` loads before `runApp`; MaterialApp and
  Settings both use the instance; delete main.dart:49 discarded instance and
  settings_screen.dart:44 per-build instance. *Acceptance: toggle applies live, switch
  shows the true state, mode is stable across restarts.*

- **Phase 1 — Token layer, additive only.**
  Add `ShelfColors` extension + context accessors; register on both themes; add missing
  component theme slots (§3). Existing call sites untouched. *Acceptance: `flutter analyze`
  clean; light mode unchanged except FABs become deterministic (see decision D1).*

- **Phase 2 — Core widgets.** app_scaffold, notebook_background, bottom_action_bar,
  room_card, subject_list_item, document_list_item, hierarchy_picker_sheet,
  rename_delete_sheet, tactile (no change), google_sign_in_button (or delete — decision D4),
  Google button styling in login/signup. *Acceptance: visual check per widget in both modes.*

- **Phase 3 — Screens.** login, signup, home, settings, room, room_members, subject,
  chapter, scan_config, document. *Acceptance: full-screen pass in both modes.*

- **Phase 4 — Text styles.** `ShelfTextStyles` + textTheme rebuild; remove darkTheme
  `copyWith` duplication. *Acceptance: no `AppTextStyles` parameterless color getters left.*

- **Phase 5 — Dark-mode enablement & regression guard.**
  - Pin a palette unit test (like the diagnostic test used in this investigation) that
    asserts `ShelfColors.light/dark` values and key component theme slots — catches any
    future fromSeed/default drift.
  - Manual checklist: auth screens, home (FABs, cards), room/subject/chapter/document
    screens, scan config, settings (tiles, switch, dialogs), room members (alpha chip),
    all dialogs/sheets/snackbars — in both modes.

---

## 6. Guardrails (so it never breaks again)

1. **No raw colors outside `lib/core/theme/`.** Enforce by convention + a grep check
   (`rg "AppColors\.|Colors\." lib --glob '!lib/core/theme/**'` must return zero), or the
   `custom_lint` package if CI-level enforcement is wanted.
2. **New color ⇒ two entries.** Any new color enters as a primitive in `AppColors` *and* is
   mapped in both `ShelfColors.light()` and `.dark()` before use.
3. **New Material widget ⇒ pinned theme slot first.** Before using a new Material widget
   type, add its theme slot to both ThemeData variants.
4. **Contrast bar.** text-on-surface and text-on-accent pairs must be readable in both
   modes (near-white-on-cream failures like the settings ListTiles are the failure class
   this prevents).

---

## 7. Open decisions (need a call before Phase 1)

- **D1 — `accent` color in light mode.** Current token is charcoal (`primaryButton 2D2D2D`),
  but the FABs are *perceived* as "supposed to be light blue" (that's what fromSeed produced).
  Options: keep charcoal (design intent, AppColors comment), introduce a dedicated
  light-blue token, or use `physicsAccent` dusty blue. One token, used by FABs + scan circle
  + save button, so the choice is a single-line change later.
- **D2 — `accent` in dark mode.** Charcoal-on-near-black is low contrast; cream
  (`textPrimaryDark`) or dusty blue recommended.
- **D3 — Auth screens in dark mode.** Fully theme-aware via tokens (recommended, no special
  case) or brand-locked light.
- **D4 — Duplicate Google button.** Delete unused `GoogleSignInButton` widget, or adopt it
  as the single implementation (it already has token-correct styling + logo fallback).

---

*Prepared 2026-09-15 from the first-launch UI inconsistency investigation. No code changes
applied; the investigation report and this plan are the deliverables.*
