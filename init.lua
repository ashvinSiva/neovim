-- Line Numbers
vim.opt.number = true
-- Relative Numbers
vim.opt.relativenumber = true
-- Tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- UI
vim.opt.termguicolors = true
-- Mouse
vim.opt.mouse = "a"

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")

local lazypath = vim.fn.stdpath("data").. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then 
    vim.fn.system ({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ 
	spec = {
		{
			"folke/tokyonight.nvim",
			lazy = false, 
			priority = 1000, opts = {},
		},
		{ import = "plugins"},
	},
})

vim.cmd.colorscheme("tokyonight")
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")

vim.keymap.set("n", "<leader>t", function()
    vim.cmd("split")
    vim.cmd("terminal")
end)

vim.api.nvim_create_autocmd("FileType", {
	pattern = {"c", "cpp", "lua", "python"},
	callback = function() 
		vim.treesitter.start()
	end,
})

vim.keymap.set("n", "<leader>nf", "<cmd>rightbelow vsplit<CR>")

vim.lsp.config("clangd", {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

vim.lsp.enable("clangd")

vim.keymap.set("n", "def", vim.lsp.buf.definition)
vim.keymap.set("n", "ref", vim.lsp.buf.references)
vim.keymap.set("n", "info", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)

local cmp = require("cmp")

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({select = true}),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    }),

    sources = {
        { name = "nvim_lsp"},
    },
})



