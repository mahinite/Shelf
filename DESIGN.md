---
name: Shelf
colors:
  surface: '#fbf9f9'
  surface-dim: '#dbdad9'
  surface-bright: '#fbf9f9'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f5f3f3'
  surface-container: '#efeded'
  surface-container-high: '#e9e8e7'
  surface-container-highest: '#e3e2e2'
  on-surface: '#1b1c1c'
  on-surface-variant: '#444748'
  inverse-surface: '#303031'
  inverse-on-surface: '#f2f0f0'
  outline: '#747878'
  outline-variant: '#c4c7c7'
  surface-tint: '#5f5e5e'
  primary: '#181919'
  on-primary: '#ffffff'
  primary-container: '#2d2d2d'
  on-primary-container: '#959494'
  inverse-primary: '#c8c6c6'
  secondary: '#5e5e5b'
  on-secondary: '#ffffff'
  secondary-container: '#e1dfdb'
  on-secondary-container: '#63635f'
  tertiary: '#0d1929'
  on-tertiary: '#ffffff'
  tertiary-container: '#222e3f'
  on-tertiary-container: '#8995aa'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e4e2e1'
  primary-fixed-dim: '#c8c6c6'
  on-primary-fixed: '#1b1c1c'
  on-primary-fixed-variant: '#474747'
  secondary-fixed: '#e4e2dd'
  secondary-fixed-dim: '#c8c6c2'
  on-secondary-fixed: '#1b1c19'
  on-secondary-fixed-variant: '#474744'
  tertiary-fixed: '#d7e3fa'
  tertiary-fixed-dim: '#bbc7dd'
  on-tertiary-fixed: '#101c2c'
  on-tertiary-fixed-variant: '#3c475a'
  background: '#fbf9f9'
  on-background: '#1b1c1c'
  surface-variant: '#e3e2e2'
typography:
  display:
    fontFamily: Inter
    fontSize: 34px
    fontWeight: '700'
    lineHeight: 42px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
    letterSpacing: -0.01em
  body-lg:
    fontFamily: Inter
    fontSize: 17px
    fontWeight: '400'
    lineHeight: 26px
    letterSpacing: 0.01em
  body-md:
    fontFamily: Inter
    fontSize: 15px
    fontWeight: '400'
    lineHeight: 22px
    letterSpacing: 0.01em
  label-md:
    fontFamily: Inter
    fontSize: 13px
    fontWeight: '500'
    lineHeight: 18px
    letterSpacing: 0.05em
  label-sm:
    fontFamily: Inter
    fontSize: 11px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.03em
  display-mobile:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 36px
    letterSpacing: -0.02em
rounded:
  sm: 0.125rem
  DEFAULT: 0.25rem
  md: 0.375rem
  lg: 0.5rem
  xl: 0.75rem
  full: 9999px
spacing:
  base: 4px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  xxl: 48px
  container-margin: 20px
  gutter: 12px
---

## Brand & Style

The design system is centered on the concept of "Digital Sanctuary"—a space for focused study that feels as tactile and warm as a physical notebook. The target audience includes students and researchers who find standard productivity apps too clinical or overstimulating. 

The aesthetic is **Warm Minimalism**. It utilizes a sophisticated off-white base to reduce eye strain and a "quiet" UI approach where interface chrome recedes to let the user's notes take center stage. The style blends the systematic logic of Modern Corporate design with the organic warmth of lifestyle editorial layouts. High-quality whitespace is treated as a functional element to separate ideas, rather than just an aesthetic choice.

## Colors

The palette is anchored by a warm cream base (`#F9F7F2`) which serves as the primary surface color, replacing harsh whites. Typography uses a deep charcoal (`#2D2D2D`) to ensure high contrast without the vibrating quality of pure black.

Functional accents are intentionally muted and desaturated. These are reserved for subject-specific categorization (e.g., Math is Sage Green, Literature is Muted Coral). These colors should be used primarily as subtle indicators—side borders on cards, small category chips, or tinted backgrounds—rather than dominant interface washes. 

State colors (success, error) should lean into the Sage and Coral tones respectively to maintain the desaturated harmony of the system.

## Typography

This design system uses **Inter** exclusively to maintain a clean, systematic feel that balances the warmth of the color palette. The typographic hierarchy is designed for long-form reading and quick scanning.

**Key Rules:**
- **Tracking:** Generous letter spacing is applied to labels and body text to enhance legibility and create an "airy" feel.
- **Contrast:** Headlines should use the primary charcoal color, while secondary body text can drop to the neutral grey (`#717171`).
- **Scale:** On mobile devices, use the `display-mobile` token for page headers to prevent excessive line wrapping.
- **Emphasis:** Use medium weights for interactive labels rather than bold, maintaining the "quiet" aesthetic.

## Layout & Spacing

The layout follows a **Fluid Grid** model with a focus on generous internal margins. For mobile, a 4-column grid is standard, with 20px outer margins to give content breathing room from the edge of the device.

**Spacing Philosophy:**
- Use the `8px` (sm) and `16px` (md) units for internal component spacing (e.g., inside a card).
- Use `24px` (lg) or `32px` (xl) to separate distinct sections or groups of cards.
- Vertical rhythm is critical; ensure body text line-heights align to a 4px baseline where possible to maintain a structured, "lined paper" feel.
- Touch targets must be a minimum of 44x44px, even if the visual element (like a small icon) is smaller.

## Elevation & Depth

This design system avoids heavy shadows, instead using **Tonal Layers** and very soft, diffused ambient shadows to indicate hierarchy.

- **Level 0 (Base):** The main background (`#F9F7F2`).
- **Level 1 (Cards/Surface):** A slightly lighter or pure white surface with a 1px border of `#EAE7E0`.
- **Level 2 (Active/Floating):** Used for items being dragged or primary action buttons. It utilizes a very soft shadow: `0px 4px 12px rgba(45, 45, 45, 0.05)`.
- **Level 3 (Modals):** A backdrop blur (10px) with a semi-transparent overlay of the charcoal color at 10% opacity, and a soft shadow `0px 8px 24px rgba(45, 45, 45, 0.08)`.

The goal is to make elements feel like sheets of paper resting lightly on a wooden desk.

## Shapes

The shape language is **Soft**. This provides a gentle, approachable feel without becoming overly bubbly or juvenile.

- **Standard Components (Cards, Inputs):** 0.25rem (4px) or 0.5rem (8px) depending on size. Small cards use 4px, while large containers use 8px.
- **Interactive Elements:** Buttons use a slightly more rounded 8px corner to distinguish them from content containers.
- **Selection Indicators:** Small indicators (like subject accent pips) are fully rounded (circles).

## Components

**Buttons:**
- **Primary:** Charcoal background with cream text. High contrast, 8px rounded corners.
- **Secondary:** Transparent background with a 1px charcoal border.
- **Tactile Feedback:** All buttons must scale down to 96% on press with a swift 150ms spring animation.

**Cards:**
- Used for individual study notes. They feature a 1px soft border (`#EAE7E0`) and a 4px left-hand color strip using the subject’s accent color. Titles use `headline-md`.

**Chips (Categories):**
- Small, 4px rounded shapes with a subtle background tint (15% opacity) of the subject's accent color and the full-strength accent color for the text.

**Input Fields:**
- Minimalist design. Only a bottom border (1px) in the neutral color, which transforms to a 2px charcoal border when focused. Label moves from placeholder position to `label-sm` above the text when active.

**Lists:**
- Notes are separated by a subtle 1px divider (`#EAE7E0`) with 16px of vertical padding between items.

**Subject Accents (Unique Feature):**
- Every "Shelf" or "Subject" is assigned one of the 5 accent colors. This color should appear in the header of the folder and as a subtle glow or underline in the navigation bar when that section is active.