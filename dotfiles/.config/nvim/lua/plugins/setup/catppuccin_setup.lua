local M = {}

function M.setup()
    local noc = require("noctalia.colors")

    require("catppuccin").setup({
        flavour = "mocha",

        custom_highlights = function()
            return {
                Normal = { fg = noc.fg, bg = noc.bg },
                Comment = { fg = noc.border },
                Keyword = { fg = noc.red },
                String = { fg = noc.green },
                Function = { fg = noc.blue },
            }
        end,

        lsp_styles = {
            underlines = {
                errors = { "undercurl" },
                hints = { "undercurl" },
                warnings = { "undercurl" },
                information = { "undercurl" },
            },
        },

        integrations = {
            aerial = true,
            alpha = true,
            cmp = true,
            dashboard = true,
            flash = true,
            fzf = true,
            grug_far = true,
            gitsigns = true,
            headlines = true,
            illuminate = true,
            indent_blankline = { enabled = true },
            leap = true,
            lsp_trouble = true,
            mason = true,
            mini = true,
            navic = { enabled = true, custom_bg = "lualine" },
            neotest = true,
            neotree = true,
            noice = true,
            notify = true,
            snacks = true,
            telescope = true,
            treesitter_context = true,
            which_key = true,
        },
    })
end

return M
