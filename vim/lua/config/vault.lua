--  ╭──────────────────────────────────────────────────────────╮
--  │ Vault: バッシュ Obsidian daily-log automation            │
--  ╰──────────────────────────────────────────────────────────╯
--
--  Opens (and creates) today's daily log with the vault's breadcrumb
--  convention, then keeps the Log index tree in sync:
--
--    Log.md            -> lists every year
--    Log/YYYY.md       -> lists every month + Weekly
--    Log/YYYY/MM.md    -> lists every day
--
--  Missing indexes are created from scratch; existing ones only ever
--  get *added* to, never rewritten or pruned.

local M = {}

local VAULT = vim.fn.expand("~/Library/Mobile Documents/iCloud~md~obsidian/Documents/バッシュ")

local MONTH_NAMES = {
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
}

--  ── filesystem ────────────────────────────────────────────

local function exists(path)
  return (vim.uv or vim.loop).fs_stat(path) ~= nil
end

local function read_lines(path)
  local fd = io.open(path, "r")
  if not fd then
    return nil
  end
  local content = fd:read("*a")
  fd:close()
  return vim.split(content, "\n", { plain = true })
end

local function write_lines(path, lines)
  vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
  local fd = io.open(path, "w")
  if not fd then
    vim.notify("vault: cannot write " .. path, vim.log.levels.ERROR)
    return false
  end
  fd:write(table.concat(lines, "\n"))
  fd:close()
  return true
end

local function scandir(dir)
  local out = {}
  if not exists(dir) then
    return out
  end
  for name, kind in vim.fs.dir(dir) do
    out[#out + 1] = { name = name, kind = kind }
  end
  return out
end

--  ── formatting ────────────────────────────────────────────

local function ordinal(n)
  local suffix = "th"
  local mod100 = n % 100
  if mod100 < 11 or mod100 > 13 then
    local last = n % 10
    if last == 1 then
      suffix = "st"
    elseif last == 2 then
      suffix = "nd"
    elseif last == 3 then
      suffix = "rd"
    end
  end
  return n .. suffix
end

local function human_date(time)
  local t = os.date("*t", time)
  return string.format("%s, %s %s, %d", os.date("%A", time), MONTH_NAMES[t.month], ordinal(t.day), t.year)
end

--- Build the tree-style breadcrumb block.
--- @param ancestors table list of { path, label } ordered root -> parent
local function breadcrumb(ancestors)
  local out = { "[[index|🔮️]]", "┬", "│" }
  for i, a in ipairs(ancestors) do
    local branch = (i == #ancestors) and "╰" or "├"
    out[#out + 1] = branch .. string.rep("─", 2 * i) .. " [[" .. a[1] .. "|" .. a[2] .. "]]"
  end
  return out
end

--  ── index syncing ─────────────────────────────────────────

--- Wikilink target of a `- [[Target|Label]]` list line, used as sort key.
local function link_target(line)
  return line:match("^%-%s+%[%[([^|%]]+)")
end

--- Add any missing `- [[...]]` lines to an index file, keeping sort order.
--- Never removes or rewrites existing entries.
local function ensure_links(path, wanted)
  local lines = read_lines(path)
  if not lines then
    return
  end

  local present = {}
  for _, line in ipairs(lines) do
    local target = link_target(line)
    if target then
      present[target] = true
    end
  end

  local changed = false
  for _, entry in ipairs(wanted) do
    local target = link_target(entry)
    if target and not present[target] then
      local first, last
      for i, line in ipairs(lines) do
        if link_target(line) then
          first = first or i
          last = i
        end
      end

      if not first then
        -- No list yet: append after the last non-empty line.
        local tail = #lines
        while tail > 0 and lines[tail]:match("^%s*$") do
          tail = tail - 1
        end
        table.insert(lines, tail + 1, "")
        table.insert(lines, tail + 2, entry)
      else
        local idx = last + 1
        for i = first, last do
          local other = link_target(lines[i])
          if other and target < other then
            idx = i
            break
          end
        end
        table.insert(lines, idx, entry)
      end

      present[target] = true
      changed = true
    end
  end

  if changed then
    write_lines(path, lines)
  end
end

--  ── index creation ────────────────────────────────────────

local function log_index()
  local path = VAULT .. "/Log.md"
  if not exists(path) then
    write_lines(path, {
      "---",
      'title: "Daily Log"',
      'tags: ["#log", "#journal"]',
      'type: "log"',
      "---",
      "",
      "",
    })
  end
  return path
end

local function year_index(year)
  local path = string.format("%s/Log/%s.md", VAULT, year)
  if not exists(path) then
    local lines = {
      "---",
      string.format('title: "%s"', year),
      'tags: ["#log", "#journal"]',
      'type: "log-year"',
      "---",
      "",
    }
    vim.list_extend(lines, breadcrumb({ { "Log", "Log" } }))
    vim.list_extend(lines, { "", string.format("- [[Log/%s/weekly|Weekly]]", year), "" })
    write_lines(path, lines)
  end

  ensure_links(log_index(), { string.format("- [[Log/%s|%s]]", year, year) })
  return path
end

local function month_index(year, month)
  local path = string.format("%s/Log/%s/%s.md", VAULT, year, month)
  if not exists(path) then
    local lines = {
      "---",
      string.format('title: "%s %s"', MONTH_NAMES[tonumber(month)], year),
      'tags: ["#log", "#journal"]',
      'type: "log-month"',
      "---",
      "",
    }
    vim.list_extend(lines, breadcrumb({ { "Log", "Log" }, { "Log/" .. year, year } }))
    vim.list_extend(lines, { "" })
    write_lines(path, lines)
  end

  ensure_links(year_index(year), {
    string.format("- [[Log/%s/%s|%s]]", year, month, MONTH_NAMES[tonumber(month)]),
  })
  return path
end

--  ── backfill ──────────────────────────────────────────────

--- List every day note that exists in Log/YYYY/MM/ in the month index.
local function sync_days(year, month)
  local wanted = {}
  for _, e in ipairs(scandir(string.format("%s/Log/%s/%s", VAULT, year, month))) do
    local date = e.name:match("^(%d%d%d%d%-%d%d%-%d%d)%.md$")
    if date then
      wanted[#wanted + 1] = string.format("- [[Log/%s/%s/%s|%s]]", year, month, date, date)
    end
  end
  table.sort(wanted)
  ensure_links(month_index(year, month), wanted)
end

--- List every month folder that exists in Log/YYYY/ in the year index.
local function sync_months(year)
  local wanted = {}
  for _, e in ipairs(scandir(string.format("%s/Log/%s", VAULT, year))) do
    local mm = e.name:match("^(%d%d)$")
    if mm and e.kind == "directory" then
      wanted[#wanted + 1] = string.format("- [[Log/%s/%s|%s]]", year, mm, MONTH_NAMES[tonumber(mm)])
    end
  end
  table.sort(wanted)
  ensure_links(year_index(year), wanted)
end

--- List every year folder that exists in Log/ in the log index.
local function sync_years()
  local wanted = {}
  for _, e in ipairs(scandir(VAULT .. "/Log")) do
    local yyyy = e.name:match("^(%d%d%d%d)$")
    if yyyy and e.kind == "directory" then
      wanted[#wanted + 1] = string.format("- [[Log/%s|%s]]", yyyy, yyyy)
    end
  end
  table.sort(wanted)
  ensure_links(log_index(), wanted)
end

--  ── daily note ────────────────────────────────────────────

local function render_template(time, year, month, date)
  local lines = read_lines(VAULT .. "/Templates/daily.md")
  if not lines then
    lines = { "---", 'title: "{{hdate}}"', "---", "", "# {{hdate}}", "" }
  end

  local subs = {
    hdate = human_date(time),
    date = date,
    year = year,
    month = month,
    day = os.date("%d", time),
    week = os.date("%V", time),
  }

  for i, line in ipairs(lines) do
    lines[i] = line:gsub("{{(%w+)}}", function(key)
      return subs[key] or ("{{" .. key .. "}}")
    end)
  end

  -- Insert the breadcrumb block right below the frontmatter.
  local close
  if lines[1] == "---" then
    for i = 2, #lines do
      if lines[i] == "---" then
        close = i
        break
      end
    end
  end

  local crumbs = breadcrumb({
    { "Log", "Log" },
    { "Log/" .. year, year },
    { string.format("Log/%s/%s", year, month), month },
  })

  -- Frontmatter is followed by a blank line already; slot the breadcrumb in
  -- between so it ends up as: `---` / blank / crumbs / blank / `# Title`.
  local at = close or 0
  table.insert(lines, at + 1, "")
  for i, crumb in ipairs(crumbs) do
    table.insert(lines, at + 1 + i, crumb)
  end

  return lines
end

--- Open the daily log for `time`, creating it and every missing index.
--- @param time integer|nil os.time() value, defaults to now
function M.open_daily(time)
  time = time or os.time()

  local year = os.date("%Y", time)
  local month = os.date("%m", time)
  local date = os.date("%Y-%m-%d", time)
  local path = string.format("%s/Log/%s/%s/%s.md", VAULT, year, month, date)

  local created = false
  if not exists(path) then
    write_lines(path, render_template(time, year, month, date))
    created = true
  end

  sync_years()
  sync_months(year)
  sync_days(year, month)

  vim.cmd.edit(vim.fn.fnameescape(path))

  if created then
    vim.notify("Created " .. date, vim.log.levels.INFO)
  end
end

--- Open the daily log offset by `n` days from today (negative = past).
function M.open_relative(n)
  M.open_daily(os.time() + (n or 0) * 86400)
end

--- Rebuild every Log index from what is actually on disk.
function M.sync_all()
  sync_years()
  for _, e in ipairs(scandir(VAULT .. "/Log")) do
    local yyyy = e.name:match("^(%d%d%d%d)$")
    if yyyy and e.kind == "directory" then
      sync_months(yyyy)
      for _, m in ipairs(scandir(string.format("%s/Log/%s", VAULT, yyyy))) do
        local mm = m.name:match("^(%d%d)$")
        if mm and m.kind == "directory" then
          sync_days(yyyy, mm)
        end
      end
    end
  end
  vim.notify("Log indexes synced", vim.log.levels.INFO)
end

--- Point telekasten's daily/weekly folders at the current month.
--- Its config is resolved once at startup, so without this the daily
--- pickers keep searching last month's folder after a rollover.
function M.refresh_telekasten()
  local ok, tk = pcall(require, "telekasten")
  if not ok or not tk.Cfg then
    return
  end
  local year = os.date("%Y")
  tk.Cfg.dailies = string.format("%s/Log/%s/%s", VAULT, year, os.date("%m"))
  tk.Cfg.weeklies = string.format("%s/Log/%s/weekly", VAULT, year)
end

return M
