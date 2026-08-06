-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.langmap =
    "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
vim.opt.clipboard = "unnamedplus"
function ReloadCatppuccin()
    package.loaded["catppuccin"] = nil
    package.loaded["themes.catppuccin_setup"] = nil

    require("themes.catppuccin_setup").setup()

    vim.cmd("colorscheme catppuccin")

    vim.cmd("doautocmd ColorScheme")
end
