return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,

    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true, -- Keeps your primary text area transparent
        
        -- Forces floating windows (LSP hovers, etc.) to also be transparent
        float = {
          transparent = true,
        },

        -- Explicitly strip the background from stubborn UI elements
        custom_highlights = function(colors)
          return {
            -- Floating windows & borders
            NormalFloat = { bg = "none" },
            FloatBorder = { fg = colors.blue, bg = "none" },

            -- Clean up line numbers and git sign columns
            SignColumn = { bg = "none" },
            LineNr = { fg = colors.surface1, bg = "none" },
            CursorLineNr = { fg = colors.lavender, bg = "none" },

            -- Telescope picker backgrounds (the usual suspect for breaking OLED)
            TelescopeNormal = { bg = "none" },
            TelescopeBorder = { fg = colors.surface1, bg = "none" },
            TelescopePromptNormal = { bg = "none" },
            TelescopePromptBorder = { fg = colors.surface1, bg = "none" },
            TelescopeResultsNormal = { bg = "none" },
            TelescopeResultsBorder = { fg = colors.surface1, bg = "none" },
            TelescopePreviewNormal = { bg = "none" },
            TelescopePreviewBorder = { fg = colors.surface1, bg = "none" },

            -- File tree sidebars (Neo-tree / Nvim-tree)
            NeoTreeNormal = { bg = "none" },
            NeoTreeNormalNC = { bg = "none" },
            NvimTreeNormal = { bg = "none" },
            NvimTreeNormalNC = { bg = "none" },

            -- LSP Diagnostics blocky backgrounds
            DiagnosticVirtualTextError = { bg = "none" },
            DiagnosticVirtualTextWarn = { bg = "none" },
            DiagnosticVirtualTextInfo = { bg = "none" },
            DiagnosticVirtualTextHint = { bg = "none" },
          }
        end,
      })

      vim.cmd.colorscheme "catppuccin-mocha"
    end
  }
}