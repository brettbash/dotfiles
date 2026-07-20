-- :: 󰘹 :: ───  FocalPane  ──────────────────────────────────────────────────────────── 00 ──  󰛡  --
-- Stateless by design: expansion is always recomputed from an equalized
-- baseline of the current layout, so windows opening/closing (Sidekick,
-- explorer, splits) can never corrupt a saved layout. Toggling off simply
-- re-equalizes the row.

local M = {}

M.config = {
  percent = 10,
  auto_expand = true,
  animate = false,
  duration = 120,
  fps = 60,
}

M.excluded_filetypes = {
  snacks_picker_list = true,
  snacks_picker_input = true,
  ["grug-far"] = true,
  sidekick_terminal = true,
}

local expanded_win = nil
local expanded_width = nil
local anim_timer = nil

-- :: 󰎞 :: ───  Window Eligibility  ─────────────────────────────────────────────────── 01 ──  󰛡  --
local function win_is_excluded(win)
  if not vim.api.nvim_win_is_valid(win) then
    return true
  end
  if vim.api.nvim_win_get_config(win).relative ~= "" then
    return true
  end
  local buf = vim.api.nvim_win_get_buf(win)
  return M.excluded_filetypes[vim.bo[buf].filetype] or false
end

local function win_is_expandable(win)
  if win_is_excluded(win) then
    return false
  end
  local buf = vim.api.nvim_win_get_buf(win)
  return vim.bo[buf].buftype == "" and not vim.wo[win].winfixwidth
end

-- :: 󰌨 :: ───  Layout Tree Helpers  ────────────────────────────────────────────────── 02 ──  󰛡  --
local function contains(node, winid)
  if node[1] == "leaf" then
    return node[2] == winid
  end
  for _, child in ipairs(node[2]) do
    if contains(child, winid) then
      return true
    end
  end
  return false
end

local function first_leaf(node)
  if node[1] == "leaf" then
    return node[2]
  end
  return first_leaf(node[2][1])
end

-- :: 󰁜 :: ───  Innermost Row Node  ──────────────────────────────────────────── 02.00 ──  󰛡  --
local function find_enclosing_row(node, winid)
  if node[1] == "leaf" then
    return nil
  end
  for _, child in ipairs(node[2]) do
    local deeper = find_enclosing_row(child, winid)
    if deeper then
      return deeper
    end
  end
  if node[1] == "row" and contains(node, winid) then
    return node
  end
  return nil
end

-- :: 󰋁 :: ───  Collect Row Entries  ─────────────────────────────────────────── 02.01 ──  󰛡  --
local function collect(cur_win)
  local row = find_enclosing_row(vim.fn.winlayout(), cur_win)
  if not row then
    return nil
  end
  local entries = {}
  local active_idx = nil
  for i, child in ipairs(row[2]) do
    local is_active = contains(child, cur_win)
    local rep = is_active and cur_win or first_leaf(child)
    entries[i] = {
      win = rep,
      width = vim.api.nvim_win_get_width(rep),
      fixed = not is_active and (vim.wo[rep].winfixwidth or win_is_excluded(rep)),
    }
    if is_active then
      active_idx = i
    end
  end
  return entries, active_idx
end

-- :: 󰕏 :: ───  Apply Widths  ────────────────────────────────────────────────── 02.02 ──  󰛡  --
local function apply_instant(entries, widths)
  for _ = 1, 2 do
    for i, e in ipairs(entries) do
      pcall(vim.api.nvim_win_set_width, e.win, widths[i])
    end
  end
end

local function apply(entries, widths)
  if not M.config.animate then
    apply_instant(entries, widths)
    return
  end

  if anim_timer then
    vim.fn.timer_stop(anim_timer)
    anim_timer = nil
  end

  local steps = math.max(1, math.floor(M.config.duration / (1000 / M.config.fps)))
  local interval = math.floor(1000 / M.config.fps)
  local step = 0

  local start_widths = {}
  for i, e in ipairs(entries) do
    if vim.api.nvim_win_is_valid(e.win) then
      start_widths[i] = vim.api.nvim_win_get_width(e.win)
    else
      start_widths[i] = widths[i]
    end
  end

  if steps <= 1 then
    apply_instant(entries, widths)
    return
  end

  anim_timer = vim.fn.timer_start(interval, function()
    step = step + 1
    local t = math.min(step / steps, 1)
    t = 1 - (1 - t) * (1 - t)

    for i, e in ipairs(entries) do
      if vim.api.nvim_win_is_valid(e.win) then
        local w = math.floor(start_widths[i] + (widths[i] - start_widths[i]) * t + 0.5)
        pcall(vim.api.nvim_win_set_width, e.win, w)
      end
    end

    if step >= steps then
      apply_instant(entries, widths)
      if anim_timer then
        vim.fn.timer_stop(anim_timer)
      end
      anim_timer = nil
    end
  end, { ['repeat'] = steps })
end

-- :: 󰗴 :: ───  Expand / Equalize  ──────────────────────────────────────────────────── 03 ──  󰛡  --
local function release_lock()
  if expanded_win and vim.api.nvim_win_is_valid(expanded_win) then
    vim.wo[expanded_win].winfixwidth = false
  end
end

function M.expand(win)
  local cur_win = win or vim.api.nvim_get_current_win()
  release_lock()
  if not win_is_expandable(cur_win) then
    return
  end
  local entries, active_idx = collect(cur_win)
  if not entries or not active_idx or #entries < 2 then
    return
  end

  local avail = 0
  local flex_count = 0
  for i, e in ipairs(entries) do
    if not e.fixed then
      avail = avail + e.width
      if i ~= active_idx then
        flex_count = flex_count + 1
      end
    end
  end
  if flex_count == 0 then
    return
  end

  -- :: 󱙝 :: ───  Baseline Calculation  ──────────────────────────────────────── 03.00 ──  󰛡  --
  local equal = math.floor(avail / (flex_count + 1))
  local bonus = math.max(math.floor(equal * M.config.percent / 100), 1)
  local target = math.min(equal + bonus, avail - flex_count)

  local rest = avail - target
  local sibling_w = math.floor(rest / flex_count)
  local remainder = rest - sibling_w * flex_count

  local widths = {}
  for i, e in ipairs(entries) do
    if e.fixed then
      widths[i] = e.width
    elseif i == active_idx then
      widths[i] = target
    else
      widths[i] = sibling_w
      if remainder > 0 then
        widths[i] = widths[i] + 1
        remainder = remainder - 1
      end
    end
  end

  apply(entries, widths)
  expanded_win = cur_win
  expanded_width = target
  -- Lock the expanded pane so automatic equalization can't steal its width
  vim.wo[cur_win].winfixwidth = true
end

function M.equalize()
  local cur_win = vim.api.nvim_get_current_win()
  release_lock()
  local entries = collect(cur_win)
  if not entries then
    return
  end

  local avail = 0
  local flex_count = 0
  for _, e in ipairs(entries) do
    if not e.fixed then
      avail = avail + e.width
      flex_count = flex_count + 1
    end
  end
  if flex_count == 0 then
    return
  end

  local base = math.floor(avail / flex_count)
  local remainder = avail - base * flex_count

  local widths = {}
  for i, e in ipairs(entries) do
    if e.fixed then
      widths[i] = e.width
    else
      widths[i] = base
      if remainder > 0 then
        widths[i] = widths[i] + 1
        remainder = remainder - 1
      end
    end
  end

  apply(entries, widths)
  expanded_win = nil
  expanded_width = nil
end

function M.toggle_width()
  if expanded_win == vim.api.nvim_get_current_win() then
    M.equalize()
  else
    M.expand()
  end
end

function M.toggle_animation()
  M.config.animate = not M.config.animate
  local state = M.config.animate and "on" or "off"

  local ok, mini_animate = pcall(require, "mini.animate")
  if ok and mini_animate.config then
    mini_animate.config.resize.enable = M.config.animate
  end

  vim.notify("FocalPane animation " .. state, vim.log.levels.INFO)
end

-- :: 󰏲 :: ───  Setup  ──────────────────────────────────────────────────────────────── 04 ──  󰛡  --
function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})

  -- FocalPane owns widths; stop 'equalalways' from re-equalizing them
  -- whenever any window opens/closes (heights still auto-equalize).
  vim.o.eadirection = "ver"

  vim.api.nvim_create_user_command("FocalPaneToggleAnimation", function()
    M.toggle_animation()
  end, { desc = "Toggle FocalPane width animation" })

  local ok, mini_animate = pcall(require, "mini.animate")
  if ok and mini_animate.config then
    mini_animate.config.resize.enable = M.config.animate
  end

  if M.config.auto_expand then
    local group = vim.api.nvim_create_augroup("focal_pane_auto", { clear = true })

    -- :: 󱕅 :: ───  Reassert Expansion  ──────────────────────────────────────────── 04.00 ──  󰛡  --
    local function reassert()
      if anim_timer then
        return
      end
      if not expanded_win or not vim.api.nvim_win_is_valid(expanded_win) then
        expanded_win = nil
        expanded_width = nil
        return
      end
      if expanded_width and vim.api.nvim_win_get_width(expanded_win) < expanded_width then
        M.expand(expanded_win)
      end
    end

    vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
      group = group,
      callback = function()
        -- :: 󱕅 :: ───  Deferred Auto-Expand  ────────────────────────────────────── 04.01 ──  󰛡  --
        vim.schedule(function()
          local cur_win = vim.api.nvim_get_current_win()
          if win_is_expandable(cur_win) then
            M.expand(cur_win)
          else
            reassert()
          end
        end)
      end,
    })

    vim.api.nvim_create_autocmd("WinResized", {
      group = group,
      callback = function()
        vim.schedule(reassert)
      end,
    })
  end
end

return M
