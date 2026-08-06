local noc = require("noctalia.colors")

return {
    custom_highlights = function()
        return {
            Normal = { fg = noc.fg, bg = noc.bg },

            CursorLine = { bg = "#1a1a12" },

            LineNr = { fg = noc.border },
            CursorLineNr = { fg = noc.yellow },

            Comment = { fg = noc.border, italic = false },

            String = { fg = noc.green },
            Function = { fg = noc.blue },
            Keyword = { fg = noc.red },

            FloatBorder = { fg = noc.border },
            NormalFloat = { bg = noc.bg },
        }
    end,
}
