-- 'Minicyan' color scheme
-- Derived from base16 (https://github.com/chriskempson/base16) and
-- mini_palette palette generator
local use_cterm, palette

-- Dark palette is an output of 'MiniBase16.mini_palette':
-- - Background '#0A2A2A' (LCh(uv) = 15-10-192)
-- - Foreground '#D0D0D0' (Lch(uv) = 83-0-0)
-- - Accent chroma 50
if vim.o.background == 'dark' then
  palette = {
    base00 = '#24283b' ,
    base01 = '#1f2335' ,
    base02 = '#292e42' ,
    base03 = '#565f89' ,
    base04 = '#a9b1d6' ,
    base05 = '#c0caf5' ,
    base06 = '#c0caf5' ,
    base07 = '#c0caf5' ,
    base08 = '#4fd6be' ,
    base09 = '#ff966c' ,
    base0A = '#ffc777' ,
    base0B = '#c3e88d' ,
    base0C = '#4fd6be' ,
    base0D = '#82aaff' ,
    base0E = '#c099ff' ,
    base0F = '#86e1fc'
  }
  use_cterm = {
    base00 = 235,
    base01 = 238,
    base02 = 241,
    base03 = 102,
    base04 = 250,
    base05 = 252,
    base06 = 254,
    base07 = 231,
    base08 = 186,
    base09 = 136,
    base0A = 29,
    base0B = 115,
    base0C = 132,
    base0D = 153,
    base0E = 218,
    base0F = 67,
  }
end

-- Light palette is an 'inverted dark', output of 'MiniBase16.mini_palette':
-- - Background '#C0D2D2' (LCh(uv) = 83-10-192)
-- - Foreground '#262626' (Lch(uv) = 15-0-0)
-- - Accent chroma 80
if vim.o.background == 'light' then
  palette = {
    base00 = '#a9b1d6',
    base01 = '#1f2335',
    base02 = '#292e42',
    base03 = '#565f89',
    base04 = '#a9b1d6',
    base05 = '#c0caf5',
    base06 = '#c0caf5',
    base07 = '#c0caf5',
    base08 = '#ff757f',
    base09 = '#ff966c',
    base0A = '#ffc777',
    base0B = '#c3e88d',
    base0C = '#4fd6be',
    base0D = '#86e1fc',
    base0E = '#c099ff',
    base0F = '#c53b53'
  }
  use_cterm = {
    base00 = 252,
    base01 = 248,
    base02 = 102,
    base03 = 241,
    base04 = 237,
    base05 = 235,
    base06 = 234,
    base07 = 232,
    base08 = 235,
    base09 = 94,
    base0A = 29,
    base0B = 22,
    base0C = 126,
    base0D = 25,
    base0E = 89,
    base0F = 25,
  }
end

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = 'catppuccin'
end
