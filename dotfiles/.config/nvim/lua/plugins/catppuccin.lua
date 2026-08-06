return {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",

    config = function()
        require("plugins.setup.catppuccin_setup").setup()
        vim.cmd.colorscheme("catppuccin")
    end,
}
