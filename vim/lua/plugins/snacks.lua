return {
  "folke/snacks.nvim",
  init = function()
    vim.env.SNACKS_GHOSTTY = "true"
  end,
  opts = {
    image = {
      enabled = true,
      force = true,
    },
  },
  config = function(_, opts)
    -- Suppress known snacks picker race condition where input.picker is nil
    -- after picker close but a vim.schedule callback still tries to use it.
    -- The error is thrown async inside vim.schedule, so we patch vim.schedule itself.
    local _orig_schedule = vim.schedule
    vim.schedule = function(fn)
      _orig_schedule(function()
        local ok, err = pcall(fn)
        if not ok then
          local msg = tostring(err)
          if not msg:find("attempt to index field 'picker'") then
            error(err)
          end
        end
      end)
    end

    -- Also guard the synchronous win.on path for the same error patterns
    local ok, snacks_input = pcall(require, "snacks.picker.core.input")
    if ok and snacks_input then
      local _new = snacks_input.new
      snacks_input.new = function(picker)
        local self = _new(picker)
        if self and self.win then
          local old_on = self.win.on
          self.win.on = function(win, events, callback, on_opts)
            if
              type(events) == "table"
              and (
                vim.list_contains(events, "TextChangedI")
                or vim.list_contains(events, "TextChanged")
              )
              and type(callback) == "function"
            then
              local orig = callback
              callback = function(...)
                local ok2, err2 = pcall(orig, ...)
                if not ok2 then
                  local msg = tostring(err2)
                  if
                    not msg:find("attempt to index field 'picker'")
                    and not msg:find("attempt to index field 'opts'")
                  then
                    error(err2)
                  end
                end
              end
            end
            return old_on(win, events, callback, on_opts)
          end
        end
        return self
      end
    end

    require("snacks").setup(opts)
  end,
}
