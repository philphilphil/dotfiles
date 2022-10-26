local wezterm = require 'wezterm'
return {
  font = wezterm.font("Cascadia Mono", {weight="Regular", stretch="Normal", style="Normal"}),
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  -- color_scheme = 'Batman',
  default_prog = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe' },
  font_size = 9,
}


