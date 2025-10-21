-- NOTE: Specify the trigger character(s) used for luasnip
local trigger_text = ";"

return {
  "saghen/blink.cmp",
  enabled = true,
  dependencies = {
    "moyiz/blink-emoji.nvim",
    "Kaiser-Yang/blink-cmp-dictionary",
    "mikavilpas/blink-ripgrep.nvim",
  },
  opts = function(_, opts)
    opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
      default = { "lsp", "path", "snippets", "buffer", "ripgrep", "copilot", "emoji" },
      providers = {
        lsp = {
          name = "lsp",
          enabled = true,
          module = "blink.cmp.sources.lsp",
          kind = "LSP",
          fallbacks = { "snippets", "buffer" },
          score_offset = 90,
        },
        path = {
          name = "Path",
          module = "blink.cmp.sources.path",
          score_offset = 25,
          fallbacks = { "snippets", "buffer" },
          opts = {
            trailing_slash = false,
            label_trailing_slash = true,
            get_cwd = function(context)
              return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
            end,
            show_hidden_files_by_default = true,
          },
        },
        buffer = {
          name = "Buffer",
          enabled = true,
          max_items = 3,
          module = "blink.cmp.sources.buffer",
          min_keyword_length = 4,
          score_offset = 15,
        },

        ripgrep = {
          module = "blink-ripgrep",
          name = "Ripgrep",
          opts = {
            prefix_min_len = 3,
            project_root_marker = ".git",
            fallback_to_regex_highlighting = true,
            debug = false,

            backend = {
              use = "ripgrep",
              ripgrep = {
                context_size = 5,
                max_filesize = "1M",
                project_root_fallback = true,
                search_casing = "--ignore-case",
                additional_rg_options = {},
                ignore_paths = {},
                additional_paths = {},
              },
            },
          },
          -- (optional) customize how the results are displayed. Many options
          -- are available - make sure your lua LSP is set up so you get
          -- autocompletion help
          -- transform_items = function(_, items)
          --   for _, item in ipairs(items) do
          --     -- example: append a description to easily distinguish rg results
          --     item.labelDetails = {
          --       description = "⚡",
          --     }
          --   end
          --   return items
          -- end,
        },

        emoji = {
          module = "blink-emoji",
          name = "Emoji",
          score_offset = 15,
          opts = { insert = true },
        },

        copilot = {
          name = "copilot",
          enabled = true,
          module = "blink-copilot",
          kind = "Copilot",
          min_keyword_length = 6,
          score_offset = -100,
          async = true,
        },
      },
    })

    opts.cmdline = {
      enabled = true,
    }

    opts.completion = {
      menu = {
        border = "rounded",
      },
      documentation = {
        auto_show = true,
        window = {
          border = "rounded",
        },
      },
    }

    -- opts.keymap = {
    --   ["<Tab>"] = {
    --     "snippet_forward",
    --     function() -- sidekick next edit suggestion
    --       return require("sidekick").nes_jump_or_apply()
    --     end,
    --       function() -- if you are using Neovim's native inline completions
    --       return vim.lsp.inline_completion.get()
    --     end,
    --     "fallback",
    --   },
    -- }

    opts.snippets = {
      preset = "luasnip",
      expand = function(snippet)
        require("luasnip").lsp_expand(snippet)
      end,
      active = function(filter)
        if filter and filter.direction then
          return require("luasnip").jumpable(filter.direction)
        end
        return require("luasnip").in_snippet()
      end,
      jump = function(direction)
        require("luasnip").jump(direction)
      end,
    }

    return opts
  end,
}
