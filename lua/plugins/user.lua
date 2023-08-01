-- You can also add new plugins here as well using the lazy syntax:
return {
  -- disable some stuff
  { "better-escape.nvim", enabled = false },
  { "nvim-autopairs", enabled = false },
  { "mason.nvim", opts = { PATH = "append" } }, -- Mason binaries will have the lowest priority
  { "theHamsta/nvim-dap-virtual-text", opts = {} },
  { "which-key.nvim", enabled = false, opts = { window = { winblend = 10 } } },
  {
    "smart-splits.nvim",
    opts = function(_, opts) opts.at_edge = require("smart-splits.types").AtEdgeBehavior.stop end,
  },
  {
    "nvim-notify",
    opts = {
      stages = "slide",
      timeout = 3000,
      max_height = function() return math.floor(vim.o.lines * 0.75) end,
      max_width = function() return math.floor(vim.o.columns * 0.75) end,
    },
  },
  {
    "gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = { ignore_whitespace = true },
      numhl = true,
      signcolumn = false,
    },
  },
  {
    "toggleterm.nvim",
    keys = {
      { "<C-BS>", mode = { "t" }, "<C-\\><C-n>", desc = "Terminal normal mode" },
      { "<esc><esc>", mode = { "t" }, "<C-\\><C-n>:q<cr>", desc = "Terminal quit" },
    },
    opts = { terminal_mappings = false },
  },
  {
    "lspkind.nvim",
    opts = function(_, opts)
      -- use codicons preset
      opts.preset = "codicons"
      -- set some missing symbol types
      opts.symbol_map = {
        Array = "",
        Boolean = "",
        Key = "",
        Namespace = "",
        Null = "",
        Number = "",
        Object = "",
        Package = "",
        String = "",
      }
      return opts
    end,
  },
  {
    "heirline.nvim",
    opts = function(_, opts)
      local status = require "astroui.status"
      opts.statusline[9] = status.component.lsp { lsp_progress = false }
      opts.statusline = {
        -- statusline
        hl = { fg = "fg", bg = "bg" },
        status.component.mode(),
        status.component.git_branch(),
        status.component.diagnostics { padding = { left = 0 } },
        status.component.file_info { -- add file_info to breadcrumbs
          file_icon = { padding = { left = 0 } },
          filename = false,
          padding = { left = 0 },
        },
        status.component.separated_path {
          padding = { left = 0 },
          path_func = status.provider.filename { modify = ":.:h" },
        },
        status.component.file_info { -- add file_info to breadcrumbs
          file_icon = false,
          file_modified = false,
          padding = { left = 0 },
        },
        status.component.breadcrumbs {
          icon = { hl = true },
          prefix = false,
          padding = { left = 0 },
        },
        status.component.fill(),
        status.component.cmd_info(),
        status.component.fill(),
        status.component.git_diff {
          padding = { right = 0 },
        },
        status.component.nav { padding = { left = 0, right = 0 }, percentage = false, scrollbar = false },
        -- {
        --   provider = function() return "  " .. os.date "%R" end,
        -- },
        status.component.mode { padding = { left = 0, right = 0 }, surround = { separator = "right" } },
      }
      opts.tabline[2] = status.heirline.make_buflist(status.component.tabline_file_info { close_button = false })
      opts.winbar = nil
    end,
  },
  {
    "echasnovski/mini.move",
    keys = {
      { "<leader>m", mode = "n", desc = "Move" },
      { "<leader>m", mode = "x", desc = "Move" },
    },
    opts = {
      mappings = {
        left = "<Leader>mh",
        right = "<Leader>ml",
        down = "<Leader>mj",
        up = "<Leader>mk",
        line_left = "<Leader>mh",
        line_right = "<Leader>ml",
        line_down = "<Leader>mj",
        line_up = "<Leader>mk",
      },
    },
  },
  {
    "echasnovski/mini.clue",
    event = "VeryLazy",
    config = function()
      local miniclue = require "mini.clue"
      miniclue.setup {
        window = {
          delay = 100,
        },
        triggers = {
          -- Leader triggers
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },

          -- Built-in completion
          { mode = "i", keys = "<C-x>" },
          -- `[ & ]` key
          { mode = "n", keys = "[" },
          { mode = "n", keys = "]" },
          -- `g` key
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },

          -- Marks
          { mode = "n", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "'" },
          { mode = "x", keys = "`" },

          -- Registers
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },

          -- Window commands
          { mode = "n", keys = "<C-w>" },

          -- `z` key
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },
        },

        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows {
            submode_move = true,
            submode_navigate = true,
            submode_resize = true,
          },
          miniclue.gen_clues.z(),
          { mode = "n", keys = "<Leader>b", desc = "+Buffers" },
          { mode = "n", keys = "<Leader>bs", desc = "+Sort" },
          { mode = "n", keys = "<Leader>d", desc = "+Diagnostics" },
          { mode = "n", keys = "<Leader>g", desc = "+Git" },
          { mode = "n", keys = "<Leader>gn", desc = "+NeoGit" },
          { mode = "n", keys = "<Leader>S", desc = "+Sessions" },
          { mode = "n", keys = "<Leader>t", desc = "+Terminal" },
          { mode = "n", keys = "<Leader>u", desc = "+Toggle UI" },
          { mode = "n", keys = "<Leader>x", desc = "+Trouble" },
          { mode = "n", keys = "<Leader><TAB>", desc = "+TAB" },
          { mode = "n", keys = "<Leader>l", desc = "+LSP" },
          { mode = "n", keys = "]b", postkeys = "]" },
          { mode = "n", keys = "]w", postkeys = "]" },
          { mode = "n", keys = "[b", postkeys = "[" },
          { mode = "n", keys = "[w", postkeys = "[" },
          { mode = "n", keys = "]B", postkeys = "]" },
          { mode = "n", keys = "]W", postkeys = "]" },
          { mode = "n", keys = "[B", postkeys = "[" },
          { mode = "n", keys = "[W", postkeys = "[" },
          { mode = "n", keys = "<Leader>mh", postkeys = "<Leader>m" },
          { mode = "n", keys = "<Leader>mj", postkeys = "<Leader>m" },
          { mode = "n", keys = "<Leader>mk", postkeys = "<Leader>m" },
          { mode = "n", keys = "<Leader>ml", postkeys = "<Leader>m" },
          { mode = "x", keys = "<Leader>mh", postkeys = "<Leader>m" },
          { mode = "x", keys = "<Leader>mj", postkeys = "<Leader>m" },
          { mode = "x", keys = "<Leader>mk", postkeys = "<Leader>m" },
          { mode = "x", keys = "<Leader>ml", postkeys = "<Leader>m" },
          { mode = "n", keys = "<Leader>s", desc = "+Search & Replace" },
          { mode = "n", keys = "<Leader>f", desc = "+Telescope" },
        },
      }
    end,
  },
  {
    "nvim-treesitter",
    dependencies = {

      { "nvim-treesitter/nvim-treesitter-context", config = true },
    },
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<nop>",
          node_decremental = "<bs>",
        },
      },
      auto_install = vim.fn.executable "tree-sitter" == 1,
      highlight = { disable = { "help", "latex" } },
      indent = { enable = true },
    },
  },
  {
    "astrotheme",
    opts = {
      palette = "astrodark", -- String of the default palette to use when calling `:colorscheme astrotheme`
      background = { -- :h background, palettes to use when using the core vim background colors
        light = "astrolight",
        dark = "astrodark",
      },
      style = {
        inactive = true, -- Bool value, toggles inactive window color.
        transparent = false, -- Bool value, toggles transperency.
        floating = true, -- Bool value, toggles floating windows background colors.
        popup = true, -- Bool value, toggles popup background color.
        neotree = false, -- Bool value, toggles neo-trees background color.
        italic_comments = true, -- Bool value, toggles italic comments.
      },
    },
  },
  {
    "todo-comments.nvim",
    keys = {
      -- { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      -- { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    },
  },
  {
    "echasnovski/mini.files",
    keys = {
      {
        "<leader>e",
        function() require("mini.files").open() end,
        desc = "Explorer",
      },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          vim.keymap.set("n", "<ESC>", function() require("mini.files").close() end, { buffer = args.buf_id })
        end,
      })
    end,
    opts = {},
  },

  {
    "portal.nvim",
    dependencies = {
      "cbochs/grapple.nvim",
      enabled = true,
      dependencies = { "nvim-lua/plenary.nvim" },
      keys = {
        { "<leader> ", function() require("grapple").popup_tags() end, desc = "Grapple" },
        { "<leader>a", function() require("grapple").toggle() end, desc = "Tag in Grapple" },
        { "<leader>1", function() require("grapple").select { key = 1 } end, desc = "Grapple 1" },
        { "<leader>2", function() require("grapple").select { key = 2 } end, desc = "Grapple 2" },
        { "<leader>3", function() require("grapple").select { key = 3 } end, desc = "Grapple 3" },
        { "<leader>4", function() require("grapple").select { key = 4 } end, desc = "Grapple 4" },
      },
    },
  },
  {
    "noice.nvim",
    opts = {
      messages = { enabled = true },
      cmdline = {
        format = {
          filter = { pattern = "^:%s*!", icon = "$ ", ft = "sh" },
          IncRename = {
            pattern = "^:%s*IncRename%s+",
            icon = " ",
            conceal = true,
          },
        },
      },
      views = {
        cmdline_popup = {
          border = { style = "none", padding = { 1, 2 } },
          win_options = {
            winblend = 5,
            winhighlight = {
              Normal = "NormalFloat",
              FloatBorder = "NoiceCmdlinePopupBorder",
              IncSearch = "",
              Search = "",
            },
            cursorline = false,
          },
        },
      },
      popupmenu = {
        enabled = true,
      },
      routes = {
        { view = "notify", filter = { event = "msg_showmode" } },
        { filter = { event = "msg_show", find = "%d+L, %d+B" }, view = "mini" },
        {
          view = "cmdline_output",
          filter = { cmdline = "^:", min_height = 5 },
          -- BUG: will be fixed after https://github.com/neovim/neovim/issues/21044 gets merged
        },
        { filter = { event = "msg_show", kind = "search_count" }, opts = { skip = true } },
        { filter = { event = "msg_show", find = "; before #" }, opts = { skip = true } },
        { filter = { event = "msg_show", find = "; after #" }, opts = { skip = true } },
        { filter = { event = "msg_show", find = " lines, " }, opts = { skip = true } },
        { filter = { event = "msg_show", find = "go up one level" }, opts = { skip = true } },
        { filter = { event = "msg_show", find = "yanked" }, opts = { skip = true } },
        { filter = { find = "No active Snippet" }, opts = { skip = true } },
        { filter = { find = "waiting for cargo metadata" }, opts = { skip = true } },
      },
      presets = {
        inc_rename = true,
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = "rounded",
      },
    },
  },
  {
    "copilot.lua",
    opts = {
      suggestion = {
        keymap = {
          accept = "<C-l>",
          accept_word = false,
          accept_line = false,
          next = "<C-.>",
          prev = "<C-,>",
          dismiss = "<C/>",
          --dismiss = false,
        },
      },
    },
  },
  {
    "neo-tree.nvim",
    enabled = false,
    dependencies = {
      "miversen33/netman.nvim",
      {
        "adelarsq/image_preview.nvim",
        opts = {},
      },
    },
    opts = {
      sources = {
        "filesystem",
        "netman.ui.neo-tree",
        "git_status",
      },
      source_selector = {
        winbar = false,
        statusline = false,
        sources = {
          { source = "filesystem", display_name = require("astroui").get_icon "FolderClosed" .. " File" },
          { source = "remote", display_name = "󰒍 Remote" },
          { source = "git_status", display_name = require("astroui").get_icon "Git" .. " Git" },
        },
      },
      filesystem = {
        hijack_netrw_behavior = "open_default",
        filtered_items = {
          always_show = { ".github", ".gitignore" },
        },
      },
    },
  },
}
