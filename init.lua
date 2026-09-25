-- ============================================================
-- Minimal Work Neovim Config
-- ============================================================

-- ============================================================
-- General Settings
-- ============================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.scrolloff = 8

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- ============================================================
-- jk = Escape
-- ============================================================

vim.keymap.set("i", "jk", "<Esc>", {
	desc = "Exit insert mode",
})

-- ============================================================
-- Midnight Crystal Colors
-- ============================================================

vim.cmd("highlight clear")
vim.cmd("syntax reset")

vim.g.colors_name = "midnight-crystal"

local colors = {
	bg = "#10131a",
	bg_dark = "#0b0e14",
	bg_light = "#181d27",

	fg = "#c9d1d9",
	fg_dim = "#7f8c9f",

	crystal = "#7dd3fc",
	blue = "#60a5fa",
	cyan = "#67e8f9",
	purple = "#c084fc",
	pink = "#f0abfc",

	green = "#86efac",
	yellow = "#fde68a",
	orange = "#fdba74",
	red = "#f87171",

	border = "#303849",
}

local hl = vim.api.nvim_set_hl

-- ============================================================
-- Base UI
-- ============================================================

hl(0, "Normal", {
	fg = colors.fg,
	bg = colors.bg,
})

hl(0, "NormalFloat", {
	fg = colors.fg,
	bg = colors.bg_light,
})

hl(0, "CursorLine", {
	bg = colors.bg_light,
})

hl(0, "LineNr", {
	fg = colors.fg_dim,
})

hl(0, "CursorLineNr", {
	fg = colors.crystal,
	bold = true,
})

hl(0, "SignColumn", {
	bg = colors.bg,
})

hl(0, "Visual", {
	bg = "#263247",
})

hl(0, "Search", {
	fg = colors.bg_dark,
	bg = colors.yellow,
})

hl(0, "IncSearch", {
	fg = colors.bg_dark,
	bg = colors.crystal,
})

hl(0, "MatchParen", {
	fg = colors.crystal,
	bold = true,
	underline = true,
})

-- ============================================================
-- Status / Floating UI
-- ============================================================

hl(0, "StatusLine", {
	fg = colors.fg,
	bg = colors.bg_light,
})

hl(0, "StatusLineNC", {
	fg = colors.fg_dim,
	bg = colors.bg_dark,
})

hl(0, "WinSeparator", {
	fg = colors.border,
	bg = colors.bg,
})

hl(0, "FloatBorder", {
	fg = colors.crystal,
	bg = colors.bg_light,
})

hl(0, "Pmenu", {
	fg = colors.fg,
	bg = colors.bg_light,
})

hl(0, "PmenuSel", {
	fg = colors.bg_dark,
	bg = colors.crystal,
})

hl(0, "PmenuBorder", {
	fg = colors.border,
	bg = colors.bg_light,
})

-- ============================================================
-- Syntax
-- ============================================================

hl(0, "Comment", {
	fg = colors.fg_dim,
	italic = true,
})

hl(0, "Constant", {
	fg = colors.purple,
})

hl(0, "String", {
	fg = colors.green,
})

hl(0, "Character", {
	fg = colors.green,
})

hl(0, "Number", {
	fg = colors.orange,
})

hl(0, "Boolean", {
	fg = colors.purple,
})

hl(0, "Identifier", {
	fg = colors.fg,
})

hl(0, "Function", {
	fg = colors.crystal,
})

hl(0, "Statement", {
	fg = colors.pink,
})

hl(0, "Keyword", {
	fg = colors.purple,
})

hl(0, "Type", {
	fg = colors.yellow,
})

hl(0, "Special", {
	fg = colors.cyan,
})

hl(0, "Operator", {
	fg = colors.cyan,
})

hl(0, "PreProc", {
	fg = colors.pink,
})

hl(0, "Error", {
	fg = colors.red,
})

hl(0, "Todo", {
	fg = colors.bg_dark,
	bg = colors.yellow,
	bold = true,
})

-- ============================================================
-- Diagnostics
-- ============================================================

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,

	float = {
		border = "rounded",
	},
})

hl(0, "DiagnosticError", {
	fg = colors.red,
})

hl(0, "DiagnosticWarn", {
	fg = colors.yellow,
})

hl(0, "DiagnosticInfo", {
	fg = colors.cyan,
})

hl(0, "DiagnosticHint", {
	fg = colors.purple,
})

-- ============================================================
-- Telescope
-- ============================================================

local plugin_dir = vim.fn.stdpath("config") .. "/plugins"

vim.opt.rtp:prepend(plugin_dir .. "/plenary.nvim")
vim.opt.rtp:prepend(plugin_dir .. "/telescope.nvim")

require("telescope").setup({})

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {
	desc = "Find files",
})

vim.keymap.set("n", "<leader>fg", builtin.live_grep, {
	desc = "Live grep",
})

vim.keymap.set("n", "<leader>fb", builtin.buffers, {
	desc = "Find buffers",
})

vim.keymap.set("n", "<leader>fh", builtin.help_tags, {
	desc = "Help",
})

-- ============================================================
-- Built-in Tabline
-- ============================================================

vim.opt.showtabline = 2
vim.opt.tabline = "%!v:lua.MyTabLine()"

function MyTabLine()
	local s = ""

	for i = 1, vim.fn.tabpagenr("$") do
		local winnr = vim.fn.tabpagewinnr(i)
		local bufnr = vim.fn.tabpagebuflist(i)[winnr]
		local name = vim.fn.bufname(bufnr)

		if name == "" then
			name = "[No Name]"
		else
			name = vim.fn.fnamemodify(name, ":t")
		end

		if i == vim.fn.tabpagenr() then
			s = s .. "%#TabLineSel#"
		else
			s = s .. "%#TabLine#"
		end

		s = s .. "  " .. i .. ": " .. name .. "  "
	end

	s = s .. "%#TabLineFill#%T"

	return s
end

hl(0, "TabLine", {
	fg = colors.fg_dim,
	bg = colors.bg_dark,
})

hl(0, "TabLineSel", {
	fg = colors.crystal,
	bg = colors.bg_light,
	bold = true,
})

hl(0, "TabLineFill", {
	fg = colors.fg_dim,
	bg = colors.bg_dark,
})

-- ============================================================
-- Tab Navigation
-- ============================================================

vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", {
	silent = true,
	desc = "New tab",
})

vim.keymap.set("n", "<Tab>", ":tabnext<CR>", {
	silent = true,
	desc = "Next tab",
})

vim.keymap.set("n", "<S-Tab>", ":tabprevious<CR>", {
	silent = true,
	desc = "Previous tab",
})

vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", {
	silent = true,
	desc = "Close tab",
})

-- ============================================================
-- Python LSP - BasedPyright
-- ============================================================

vim.lsp.config("basedpyright", {
	cmd = {
		"basedpyright-langserver",
		"--stdio",
	},

	filetypes = {
		"python",
	},

	root_markers = {
		"pyproject.toml",
		"pyrightconfig.json",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		".git",
	},

	settings = {
		basedpyright = {
			analysis = {
				typeCheckingMode = "basic",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
			},
		},
	},
})

vim.lsp.enable("basedpyright")

-- ============================================================
-- LSP Keybindings
-- ============================================================

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = {
			buffer = args.buf,
			silent = true,
		}

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)

		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format({
				async = false,
				timeout_ms = 5000,
			})
		end, opts)
	end,
})

-- ============================================================
-- Python Format on Save
-- Uses Ruff directly.
-- Does NOT depend on Ruff LSP.
-- ============================================================

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.py",

	callback = function(args)
		if vim.fn.executable("ruff") ~= 1 then
			return
		end

		local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)

		local input = table.concat(lines, "\n")
		local filename = vim.api.nvim_buf_get_name(args.buf)

		local result = vim.fn.system({
			"ruff",
			"format",
			"--stdin-filename",
			filename,
			"-",
		}, input)

		if vim.v.shell_error ~= 0 then
			vim.notify("Ruff formatting failed", vim.log.levels.WARN)
			return
		end

		result = result:gsub("\n$", "")

		local formatted = vim.split(result, "\n", {
			plain = true,
			trimempty = false,
		})

		vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, formatted)
	end,
})

-- ============================================================
-- Python Settings
-- ============================================================

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",

	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
	end,
})
