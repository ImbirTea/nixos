-- lua/duskmire/palette/duskmire.lua
-- Duskmire — a color palette. v3
--
-- Base mood: miasma (fog / low-contrast neutrals). Style family: gruvbox-like
-- (systematic warm accent ramp + bright variants). Structure: modeled on kape's
-- palette module, extended with a 5-level background depth scale.
--
-- v3 change: chroma pulled back ~15% across accents/text (in OKLCH, hue and
-- lightness held steady) for a slightly paler, softer look, per request.
--
-- v2 change: every accent, background and foreground step is defined directly
-- in OKLCH (perceptually uniform lightness/chroma), not HSL. HSL lightness
-- doesn't track perceived brightness across hues — v1 had a mustard gold
-- accent almost as bright as body text purely by HSL accident. Rebuilding in
-- OKLCH fixed that and, as a side effect, brought every accent's contrast
-- against bg1 above 4.5:1 (Neovim's own colorscheme guideline threshold for
-- colored syntax) — something none of the three reference palettes
-- (miasma, gruvbox, kape) actually achieve for their red/orange accents.
-- Comments were deliberately kept below that bar (~3.4:1) to preserve the
-- "receded, foggy" comment feel that defines miasma — still an improvement
-- over miasma's own ~2.8:1, just not chasing full AA compliance there.
--
-- No hex value here is reused from any reference palette (checked
-- programmatically against all three source files).

---@class Duskmire.Palette
---@field bg0 string
---@field bg1 string
---@field bg2 string
---@field bg3 string
---@field bg4 string
---@field background string
---@field dimmed1 string
---@field dimmed2 string
---@field dimmed3 string
---@field dimmed4 string
---@field dimmed5 string
---@field text string
---@field accent1 string
---@field accent2 string
---@field accent3 string
---@field accent4 string
---@field accent5 string
---@field accent6 string
---@field blue string
---@field bright_red string
---@field bright_orange string
---@field bright_yellow string
---@field bright_green string
---@field bright_aqua string
---@field bright_blue string
---@field bright_purple string
---@field bg_visual_red string
---@field bg_visual_yellow string
---@field bg_visual_green string
---@field bg_visual_blue string
---@field bg_visual_purple string
---@field bg_diff_red string
---@field bg_diff_green string
---@field bg_diff_blue string

---@type Duskmire.Palette
return {
  -- Backgrounds: 5-level depth scale, subtle moss-black tint —
  -- distinct from miasma's neutral gray, gruvbox's brown-black and kape's
  -- red-black. OKLCH L 0.14 -> 0.37, hue held constant at 100°.
  bg0 = "#0a0905", -- deepest: floats, popups, sidebar
  bg1 = "#15140f", -- main editor background
  bg2 = "#201f1a", -- cursorline / subtle line highlight
  bg3 = "#2f2e27", -- selection base, popup borders, statusline bg
  bg4 = "#414038", -- active tab, lighter chrome
  background = "#15140f", -- alias for bg1

  -- Foreground / text: 5-level fade, warm cream (OKLCH H90) toward background.
  -- dimmed1 sits at L0.85 with deliberate headroom above the brightest
  -- accent (accent3, L0.80) so body text always reads as the brightest thing
  -- on screen.
  dimmed1 = "#d7cdb2", -- main text        (contrast vs bg1: 11.65)
  dimmed2 = "#aba492", -- secondary text   (contrast vs bg1: 7.43)
  dimmed3 = "#7e7a6e", -- dimmed/inactive  (contrast vs bg1: 4.30)
  dimmed4 = "#6f6c63", -- comments         (contrast vs bg1: 3.51)
  dimmed5 = "#34332e", -- faint borders
  text = "#d7cdb2", -- alias for dimmed1

  -- Accents: 6 abstract roles, assign to syntax groups as needed.
  -- (hue family: terracotta / amber / mustard gold / moss green /
  --  verdigris teal / dusty plum — every one clears 4.5:1 on bg1)
  accent1 = "#c26f5c", -- terracotta
  accent2 = "#d3a269", -- amber
  accent3 = "#d0be76", -- mustard gold
  accent4 = "#89ad70", -- moss green
  accent5 = "#6aa7a2", -- verdigris teal
  accent6 = "#b381a7", -- dusty plum

  -- Utility blue — kept separate from the main warm ramp (miasma has no
  -- blue at all; this exists purely for LSP info/hints, same role as in kape).
  blue = "#7d9cc7",

  -- Brights — same OKLCH hue as the accent above, +0.09 L / +0.018 C, for
  -- terminal ANSI colors, diagnostics and emphasis.
  bright_red    = "#e8866f",
  bright_orange = "#f7bc78",
  bright_yellow = "#f1da85",
  bright_green  = "#a1cb82",
  bright_aqua   = "#77c6c1",
  bright_blue   = "#92b8ee",
  bright_purple = "#d698c8",

  -- Visual-selection tinted backgrounds (dark, per-hue, same L as bg1).
  bg_visual_red    = "#220d08",
  bg_visual_yellow = "#191300",
  bg_visual_green  = "#0d1705",
  bg_visual_blue   = "#081425",
  bg_visual_purple = "#1e0d1b",

  -- ANSI-compatibility aliases
  bright_cyan      = "#77c6c1", -- = bright_aqua
  bright_violet    = "#d698c8", -- = bright_purple
  bg_visual_violet = "#1e0d1b", -- = bg_visual_purple

  -- Diff tinted backgrounds
  bg_diff_red   = "#200c08",
  bg_diff_green = "#0d1607",
  bg_diff_blue  = "#091322",
}
