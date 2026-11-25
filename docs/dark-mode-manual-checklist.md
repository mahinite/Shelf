# Dark-Mode Manual Verification Checklist

> **Purpose**: Human-run on-device verification that the dark-mode migration (Phases 0-4) works end-to-end. Run **in both light and dark mode** on a physical device or emulator.
>
> **Known deferred items (NOT expected to pass — do not file as bugs):**
> - `pdf_badge_icon.dart` — hardcoded PDF-red (`#D32F2F`) icon + white text; no `onDestructive` token exists yet.
> - `Switch` widget unselected state — track/thumb colors remain `fromSeed`-derived (only `selected` state pinned to accent).
> - `GoogleSignInButton` — decision D4 unresolved; current inline buttons in Login/SignUp are migrated, the standalone widget exists but is unused.

---

## Auth Screens

### Login Screen
- [ ] "Welcome back" — readable (charcoal on cream / off-white on dark)
- [ ] Subtitle — muted grey readable
- [ ] Email / password fields — labels, hints, borders visible
- [ ] "Log In" button — charcoal bg + cream text (light) / off-white bg + charcoal text (dark)
- [ ] Loading spinner inside button — `onAccent` (white on charcoal / dark on light-grey)
- [ ] "or" divider — muted, visible
- [ ] Google button — readable (charcoal text/border on cream / off-white text/border on dark)
- [ ] "Don't have an account? Sign up" — bodySecondary, readable
- [ ] Navigation to SignUp works

### Signup Screen
- [ ] "Create your Shelf" — largeTitle, readable
- [ ] Subtitle — bodySecondary, readable
- [ ] Name / Email / Password fields — labels, hints, borders visible
- [ ] "Create Account" button — charcoal + cream / off-white + charcoal
- [ ] Loading spinner — `onAccent` color
- [ ] "or" divider — metadata, muted
- [ ] Google button — same visual as login
- [ ] "Already have an account? Log in" — bodySecondary, readable

---

## Home Screen
- [ ] Greeting ("Good to see you") — largeTitle, readable
- [ ] Section header ("Your Study Rooms") — sectionTitle, readable
- [ ] Room cards — room names (sectionTitle), subject counts (metadata), chevron icons (textSecondary)
- [ ] Create Room FAB — charcoal circle + white icon (light) / light-grey circle + dark icon (dark)
- [ ] Join Room FAB (small) — same accent logic
- [ ] Bottom Action Bar — "Home"/"Settings" labels (metadata), icons (textPrimary)
- [ ] Scan button circle — accent fill + onAccent icon
- [ ] Empty state ("No study rooms yet.") — readable

---

## Room Screen (Room Detail)
- [ ] AppBar title (room name) — sectionTitle, readable
- [ ] Subject cards — subject names (sectionTitle), chapter counts (metadata), left border strip (subject accent), chevron icons (textSecondary)
- [ ] Create Subject FAB — accent logic
- [ ] Bottom Action Bar — same as Home
- [ ] Long-press → Rename/Delete sheet:
  - [ ] "Rename Room" — body, readable
  - [ ] "Delete Room" — body + `destructive` red, readable
- [ ] AppBar actions (if any) — icons textPrimary

---

## Room Members Screen
- [ ] "Invite Members" header — sectionTitle
- [ ] Invite code display — body + monospace, readable
- [ ] Member list — names (body), "Creator" badge (metadata on accentSubtle bg + accent text), remove icon (destructive)
- [ ] Leave Room button (non-creators) — body + `destructive` red
- [ ] Remove member icon — `destructive` red
- [ ] Error state ("Could not load members") — body + `destructive`
- [ ] Retry button — FilledButton on accent

---

## Subject Screen
- [ ] AppBar title (subject name) — sectionTitle
- [ ] Chapter list — chapter names (body), chevron icons (textSecondary — **const context uses `AppColors.textSecondary`**, verify both modes)
- [ ] Create Chapter FAB — accent logic
- [ ] Long-press chapter → Rename/Delete/Download sheet:
  - [ ] "Rename Document" — body
  - [ ] "Download Document" — body
  - [ ] "Delete Document" — body + `destructive`
- [ ] Create Document FAB — accent logic
- [ ] Long-press on empty → Rename/Delete sheet for chapter

---

## Chapter Screen
- [ ] AppBar title (chapter name) — sectionTitle
- [ ] Document list — titles (body), PDF badge (PDF red icon, white text — **deferred**), chevron icons (textSecondary)
- [ ] Long-press document → Rename/Delete/Download sheet:
  - [ ] "Rename Document" — body
  - [ ] "Download Document" — body
  - [ ] "Delete Document" — body + `destructive`
- [ ] Create Document FAB — accent logic
- [ ] Long-press on empty → Rename/Delete sheet for chapter

---

## Document Screen (PDF Viewer)
- [ ] Loading spinner — `accent` color
- [ ] Error state — body + `destructive` red, Retry button (FilledButton on accent + `onAccent` label)
- [ ] Empty state ("Document is empty") — bodySecondary readable
- [ ] PDF content — native viewer (no theme concerns)

---

## Scan Config Screen
- [ ] Form fields — labels (bodySecondary), borders visible
- [ ] Save button:
  - [ ] Enabled — `buttonLabel` on accent, `onAccent` text color
  - [ ] Disabled — `buttonLabel` on `textSecondary` (muted)
- [ ] Upload progress — `buttonLabel` on `onAccent`
- [ ] Hierarchy picker (Room → Subject → Chapter):
  - [ ] Headers — sectionTitle
  - [ ] List items — body, check icon (accent), chevron (textSecondary)
  - [ ] Select button — `buttonLabel` conditional `onAccent`/`textSecondary`
  - [ ] Error retry — `buttonLabel` on `onAccent`

---

## Settings Screen
- [ ] Account section header — sectionTitle
- [ ] Email — bodySecondary readable
- [ ] Change Password button — FilledButton on accent
- [ ] Delete Account button — FilledButton on `destructive`, spinner `onAccent`
- [ ] Appearance header — sectionTitle
- [ ] Dark Mode switch:
  - [ ] Active thumb/track — accent (light: charcoal/cream, dark: light-grey/dark)
  - [ ] Inactive — Material default (fromSeed, **known deferred**)
  - [ ] Subtitle ("Light"/"Dark") — bodySecondary readable
- [ ] Debug header — sectionTitle
- [ ] View Crash Logs — body readable
- [ ] About header — sectionTitle
- [ ] Version — bodySecondary readable
- [ ] Crash Logs screen:
  - [ ] Logs — body + monospace readable
  - [ ] Clear button — OutlinedButton, readable
- [ ] Log Out button — FilledButton readable

---

## Shared Dialogs & Sheets (verify in context)
- [ ] Rename sheet (rooms, subjects, chapters, documents) — "Rename X" (body), "Download X" (body), "Delete X" (body + `destructive`)
- [ ] Delete confirm dialog — title "Delete X?" (body), body text, "Delete" FilledButton on `destructive`
- [ ] Hierarchy picker sheet — headers (sectionTitle), list items (body), select button conditional `onAccent`/`textSecondary`, error retry (`onAccent`)
- [ ] SnackBars (errors, success) — inverse tokens (dark bg + light text on light mode; light bg + dark text on dark mode)
- [ ] Create Room/Subject/Chapter dialogs — titles/inputs readable, buttons accent

---

## Visual Consistency Checks (per mode)
- [ ] All text has sufficient contrast (WCAG AA minimum)
- [ ] No charcoal-on-charcoal or cream-on-cream invisibility
- [ ] Accent color (FABs, scan circle, save buttons, active switch) is **charcoal/cream in light**, **light-grey/dark in dark**
- [ ] Borders/dividers are visible but subtle (`outline-variant` light / `outline` dark)
- [ ] No hardcoded `Colors.white`/`Colors.black` on text (except deferred items above)
- [ ] `Scaffold` background is `context.colors.background` (cream light / near-black dark)
- [ ] `AppBar` background matches scaffold, icons/title use `textPrimary`
- [ ] Bottom Action Bar background = `surface`, icons/labels = `textPrimary`/`metadata`

---

## Quick Regression Smoke Test
1. Launch in light mode → verify all above
2. Toggle dark mode in Settings → verify all above **without restart**
3. Restart app in dark mode → verify all above persist
4. Toggle back to light → verify all above
5. Restart in light → verify all above

---

**Sign-off**: _________________ Date: ___________