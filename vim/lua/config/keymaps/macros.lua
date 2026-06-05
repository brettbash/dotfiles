-- ╔════════════════════════════════════════════════════════════════════════════╗
-- ║  🎞️  MACROS  //                                                            ║
-- ╚════════════════════════════════════════════════════════════════════════════╝

-- Breaks `<div class="class class class">` into a multi-line format
vim.keymap.set(
  "n",
  "<leader>mb",
  '^ea<Cr><Tab><Esc>f"a<Cr><Tab><esc>f"i<Cr><BS><Esc>$i<Cr><BS><Esc>',
  { remap = true, desc = "Break HTML Tag Attributes" }
)
