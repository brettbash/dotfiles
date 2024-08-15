return {
  {
    "David-Kunz/gen.nvim",
    opts = {
      model = "codegemma", -- The default model to use.
      host = "192.168.0.121", -- The host running the Ollama service.
      port = "11434", -- The port on which the Ollama service is listening.
      quit_map = "q", -- set keymap for close the response window
      retry_map = "<c-r>", -- set keymap to re-send the current prompt
      init = function(options)
        pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
      end,
      -- Function to initialize Ollama
      command = function(options)
        local body = { model = options.model, stream = true }
        return "curl --silent --no-buffer -X POST http://"
          .. options.host
          .. ":"
          .. options.port
          .. "/api/chat -d $body"
      end,
      -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
      -- This can also be a command string.
      -- The executed command must return a JSON object with { response, context }
      -- (context property is optional).
      -- list_models = '<omitted lua function>', -- Retrieves a list of model names
      display_mode = "split", -- The display mode. Can be "float" or "split" or "horizontal-split".
      show_prompt = false, -- Shows the prompt submitted to Ollama.
      show_model = false, -- Displays which model you are using at the beginning of your chat session.
      no_auto_close = false, -- Never closes the window automatically.
      debug = false, -- Prints errors and the command which is run.
    },
  },

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- Optional
      {
        "stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
        opts = {},
      },
    },
    opts = function()
      require("codecompanion").setup({
        adapters = {
          ollama = require("codecompanion.adapters").use("ollama", {
            url = "http://192.168.0.121:11434",
            schema = {
              model = {
                default = "codegemma",
              },
            },
          }),
        },

        strategies = {
          chat = "ollama",
          inline = "ollama",
          agent = "ollama",
        },
      })
    end,
  },

  {
    "tzachar/cmp-ai",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      local cmp_ai = require("cmp_ai.config")
      cmp_ai:setup({
        max_lines = 100,
        provider = "Ollama",
        provider_options = {
          base_url = "http://192.168.0.121:11434/api/generate",
          model = "codegemma",
          stream = true,
        },
        notify = true,
        notify_callback = function(msg)
          vim.notify(msg)
        end,
        run_on_every_keystroke = true,
        ignored_file_types = {
          -- default is not to ignore
          -- uncomment to ignore in lua:
          -- lua = true
        },
      })
    end,
  },
}
