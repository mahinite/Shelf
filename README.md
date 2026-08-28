# Shelf (MVP)

A calm, notebook-inspired study notes app — this build includes live
Supabase authentication and full CRUD (rooms → subjects → chapters →
documents). Camera/scan, PDF viewer, OCR, and offline sync are not
yet implemented.

## Run it

```bash
flutter pub get
flutter analyze
flutter run
```

I wasn't able to run these three commands myself — this sandbox doesn't
have the Flutter SDK installed, and its network access is locked to a
fixed allowlist of domains (npm, pypi, crates, GitHub, apt) that doesn't
include pub.dev or the Flutter SDK's storage host. So please run
`flutter analyze` locally before you trust this compiles — I've done a
manual pass (brace balance, cross-file class/import references) but
that's not a substitute for the real analyzer.

## What's here

```
lib/
  main.dart              # MaterialApp entry point, no router package
  theme/                 # colors, spacing, type, ThemeData, grid background
  models/                # Room -> Subject -> Chapter -> Documents
  screens/               # Login, SignUp, Home, Room, Subject, Chapter, Document
  widgets/               # AppScaffold, BottomActionBar, cards, Tactile wrapper
```

## Design decisions worth knowing about

- **Navigation:** plain `Navigator.push` with constructor arguments, no
  named routes or router package. The hierarchy is a strict linear
  stack (Login → Home → Room → Subject → Chapter → Notes), so a router
  package would be pure overhead right now.
- **State:** no state management package. Nothing here needs to be
  shared or persisted across widgets yet — each screen just receives
  the data it needs as a constructor argument.
- **Rooms vs. Subjects:** Rooms are deliberately colorless (no accent,
  no left border strip). Only Subjects carry an accent color, and it
  only ever appears as a thin 4px border, a small pip, or a tinted
  chip — never a full colored surface.
- **Fonts:** `google_fonts` is the one dependency added beyond the
  Flutter SDK, since Inter isn't a system font and the brief calls for
  Inter specifically. Everything else (icons, navigation, layout) is
  vanilla Flutter.
- **Grid background:** a `CustomPainter` drawing 1px lines at 3.5%
  opacity — meant to be genuinely hard to notice consciously. If it
  looks like a visible design element on your device, that's a bug,
  not a feature.
- **Exercises:** modeled as `List<NoteDocument>` on `Chapter`, so a
  chapter with none simply renders no Exercises section — nothing is
  force-generated.

## Known gaps (intentional — out of scope for this build)

Camera/scan, PDF generation/viewing, cloud storage, OCR/search,
profiles, notifications, offline sync, AI, settings. All of these are
referenced in the UI (e.g. the Scan button) but not implemented.
