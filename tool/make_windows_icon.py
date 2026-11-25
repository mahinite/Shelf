#!/usr/bin/env python3
"""
Generate Windows ICO from the Android glyph PNG.
Places the black glyph centered on a cream (#F9F7F2) rounded-square tile with ~12% padding.
Outputs multi-size ICO: 16, 24, 32, 48, 64, 128, 256.
"""
from pathlib import Path
from PIL import Image, ImageDraw

SRC_PNG = Path(r"D:\Code\Shelf dart\assets\Shelf-icon-black-transparent.png")
DST_ICO = Path(r"D:\Code\Shelf dart\windows\runner\resources\app_icon.ico")

CREAM = (0xF9, 0xF7, 0xF2, 0xFF)  # #F9F7F2
SIZES = [16, 24, 32, 48, 64, 128, 256]
PADDING_RATIO = 0.12  # 12% padding
CORNER_RADIUS_RATIO = 0.18  # rounded-square corner radius


def make_rounded_square_mask(size: int, radius_ratio: float) -> Image.Image:
    """Create a rounded-square alpha mask."""
    radius = int(size * radius_ratio)
    mask = Image.new("L", (size, size), 0)
    draw = ImageDraw.Draw(mask)
    draw.rounded_rectangle([0, 0, size - 1, size - 1], radius=radius, fill=255)
    return mask


def generate_icon_for_size(glyph: Image.Image, size: int) -> Image.Image:
    """Generate a single size icon with glyph on cream rounded-square background."""
    # Create cream background
    bg = Image.new("RGBA", (size, size), CREAM)

    # Apply rounded-square mask
    mask = make_rounded_square_mask(size, CORNER_RADIUS_RATIO)
    bg.putalpha(mask)

    # Compute glyph size with 12% padding
    padding = int(size * PADDING_RATIO)
    max_glyph_size = size - 2 * padding

    # Scale glyph to fit within max_glyph_size, preserving aspect ratio
    glyph_ratio = min(max_glyph_size / glyph.width, max_glyph_size / glyph.height)
    new_glyph_size = (int(glyph.width * glyph_ratio), int(glyph.height * glyph_ratio))

    glyph_resized = glyph.resize(new_glyph_size, Image.Resampling.LANCZOS)

    # Center glyph on background
    x = (size - new_glyph_size[0]) // 2
    y = (size - new_glyph_size[1]) // 2

    # Composite glyph onto background (glyph is black on transparent)
    bg.alpha_composite(glyph_resized, (x, y))

    return bg


def main():
    # Load source glyph (black on transparent)
    glyph = Image.open(SRC_PNG).convert("RGBA")
    print(f"Loaded glyph: {glyph.size}, mode={glyph.mode}")

    # Generate all sizes
    icons = []
    for size in SIZES:
        icon = generate_icon_for_size(glyph, size)
        icons.append(icon)
        print(f"Generated {size}x{size}")

    # Save as multi-size ICO
    # Pillow's ICO support requires saving each size as a separate frame
    # We need to save with the largest first and include all sizes
    icons.sort(key=lambda im: im.width, reverse=True)  # Largest first
    icons[0].save(
        DST_ICO,
        format="ICO",
        append_images=icons[1:],
    )
    print(f"Saved ICO to {DST_ICO}")

    # Verify
    verify = Image.open(DST_ICO)
    print(f"Verified ICO: default size={verify.size}, available sizes={verify.info.get('sizes')}")


if __name__ == "__main__":
    main()