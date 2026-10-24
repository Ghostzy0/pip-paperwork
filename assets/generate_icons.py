#!/usr/bin/env python3
# Copyright 2026 Pip Paperwork contributors. SPDX-License-Identifier: MIT
"""Generate original Paperwork macOS app icons. Requires Pillow and macOS iconutil."""

from __future__ import annotations

import argparse
import subprocess
import tempfile
from pathlib import Path

from PIL import Image, ImageDraw


ROOT = Path(__file__).resolve().parent
PREVIEW = ROOT / "previews"
MASTER = 1024
ICONSET_FILES = (
    ("icon_16x16.png", 16),
    ("icon_16x16@2x.png", 32),
    ("icon_32x32.png", 32),
    ("icon_32x32@2x.png", 64),
    ("icon_128x128.png", 128),
    ("icon_128x128@2x.png", 256),
    ("icon_256x256.png", 256),
    ("icon_256x256@2x.png", 512),
    ("icon_512x512.png", 512),
    ("icon_512x512@2x.png", 1024),
)

INK = (30, 27, 22, 255)
PAPER = (255, 255, 255, 255)
PAPER_SURFACE = (246, 242, 234, 255)
NEUTRAL_TILE = (242, 242, 240, 255)
NEUTRAL_EDGE = (218, 218, 214, 255)
OAT_ACCENT = (180, 83, 42, 255)


def cubic(p0: tuple[float, float], p1: tuple[float, float], p2: tuple[float, float], p3: tuple[float, float], steps: int = 32) -> list[tuple[float, float]]:
    points = []
    for index in range(steps + 1):
        t = index / steps
        u = 1 - t
        points.append((
            u**3 * p0[0] + 3 * u**2 * t * p1[0] + 3 * u * t**2 * p2[0] + t**3 * p3[0],
            u**3 * p0[1] + 3 * u**2 * t * p1[1] + 3 * u * t**2 * p2[1] + t**3 * p3[1],
        ))
    return points


def round_tile(draw: ImageDraw.ImageDraw, fill: tuple[int, int, int, int]) -> None:
    draw.rounded_rectangle((12, 12, MASTER - 12, MASTER - 12), radius=218, fill=fill)


def draw_document(draw: ImageDraw.ImageDraw) -> None:
    # An original sheet silhouette with a turned corner and three restrained text lines.
    page = (228, 146, 796, 878)
    draw.rounded_rectangle(page, radius=46, fill=PAPER, outline=INK, width=12)
    fold = [(630, 152), (790, 152), (790, 310), (748, 302), (691, 282), (658, 250)]
    draw.polygon(fold, fill=(230, 230, 226, 255))
    draw.line([(630, 152), (630, 254), (658, 282), (790, 310)], fill=INK, width=11, joint="curve")
    for y, right in ((420, 686), (510, 738), (600, 665)):
        draw.rounded_rectangle((326, y, right, y + 23), radius=11, fill=INK)
    draw.rounded_rectangle((326, 700, 548, 723), radius=11, fill=NEUTRAL_EDGE)


def draw_pebble(draw: ImageDraw.ImageDraw) -> None:
    # A fresh cubic pebble drawing, guided by the small native mark in PipAppearance.swift.
    x, y, width, height = 217.0, 176.0, 590.0, 662.0
    point = lambda px, py: (x + px * width, y + py * height)
    segments = [
        ((0.15, 0.18), (0.02, 0.47), (0.09, 0.91), (0.28, 0.88)),
        ((0.28, 0.88), (0.47, 1.00), (0.78, 0.98), (0.88, 0.83)),
        ((0.88, 0.83), (1.02, 0.57), (0.99, 0.22), (0.76, 0.13)),
        ((0.76, 0.13), (0.54, 0.00), (0.30, 0.02), (0.15, 0.18)),
    ]
    outline: list[tuple[float, float]] = []
    for start, c1, c2, end in segments:
        outline.extend(point(px, py) for px, py in cubic(start, c1, c2, end, 36))
    draw.polygon(outline, fill=INK)

    eye_y = y + height * 0.49
    eye_radius = 23
    for eye_x in (x + width * 0.38, x + width * 0.62):
        draw.ellipse((eye_x - eye_radius, eye_y - eye_radius, eye_x + eye_radius, eye_y + eye_radius), fill=PAPER_SURFACE)

    # A fine Oat scarf line gives Pip one warm accessory; Paper keeps its ink tone.
    scarf = cubic(point(0.25, 0.70), point(0.39, 0.65), point(0.62, 0.65), point(0.77, 0.71), 36)
    draw.line(scarf, fill=OAT_ACCENT, width=16, joint="curve")


def create_icon(kind: str) -> Image.Image:
    image = Image.new("RGBA", (MASTER, MASTER), (0, 0, 0, 0))
    draw = ImageDraw.Draw(image)
    round_tile(draw, NEUTRAL_TILE if kind == "baseline" else PAPER_SURFACE)
    if kind == "baseline":
        draw_document(draw)
    else:
        draw_pebble(draw)
    return image


def write_iconset(image: Image.Image, directory: Path) -> None:
    directory.mkdir(parents=True, exist_ok=True)
    for name, size in ICONSET_FILES:
        image.resize((size, size), Image.Resampling.LANCZOS).save(directory / name, optimize=True)


def generate(output: Path) -> None:
    output.mkdir(parents=True, exist_ok=True)
    PREVIEW.mkdir(parents=True, exist_ok=True)
    try:
        with tempfile.TemporaryDirectory(prefix="paperwork-iconsets-") as temporary:
            temporary_path = Path(temporary)
            for kind, filename in (("baseline", "AppIcon-Baseline.icns"), ("pip", "AppIcon-Pip.icns")):
                artwork = create_icon(kind)
                artwork.resize((512, 512), Image.Resampling.LANCZOS).save(PREVIEW / f"AppIcon-{kind.title()}-preview.png", optimize=True)
                iconset = temporary_path / f"{kind}.iconset"
                write_iconset(artwork, iconset)
                subprocess.run(["iconutil", "-c", "icns", "-o", str(output / filename), str(iconset)], check=True)
    except FileNotFoundError as error:
        raise SystemExit(f"Required tool not found: {error.filename}") from error


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=ROOT, help="directory for generated ICNS files")
    args = parser.parse_args()
    generate(args.output.resolve())


if __name__ == "__main__":
    main()
