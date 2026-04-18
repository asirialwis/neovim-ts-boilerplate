-- ========================================================================== --
-- 1. GLOBAL OPTIONS
-- ========================================================================== --
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.termguicolors = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- IMPORTANT: This prevents "accidental" triggers. 
-- Neovim will only wait 300ms for you to finish a shortcut.
vim.opt.timeoutlen = 300 

-- ========================================================================== --
-- 2. BOOTSTRAP LAZY.NVIM
-- ========================================================================== --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- ========================================================================== --
-- 3. THE PLUGIN LIST
-- ========================================================================== --
require("lazy").setup({
  -- UI & Icons
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-web-devicons" }, config = function() require("nvim-tree").setup({ view = { width = 45 } }) end },
  { "nvim-telescope/telescope.nvim", tag = '0.1.6', dependencies = { 'plenary.nvim' } },
  { "lewis6991/gitsigns.nvim", config = function() require('gitsigns').setup() end },
  
  -- Syntax Highlighting
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- Theme
  { "folke/tokyonight.nvim", lazy = false, priority = 1000, config = function() vim.cmd[[colorscheme tokyonight]] end },

  -- LSP & Mason
  { "williamboman/mason.nvim", config = function() require("mason").setup() end },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },

  -- Autocomplete
  { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip" } },

  -- Terminal
  { 'akinsho/toggleterm.nvim', version = "*", config = true },

  -- GitHub Copilot (Core & Chat)
  { "zbirenbaum/copilot.lua" },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" }, 
    },
    opts = { debug = false },
  },
})

-- ========================================================================== --
-- 4. PLUGIN SETUP
-- ========================================================================== --

-- Mason-LSPConfig
local ok_ml, ml = pcall(require, "mason-lspconfig")
if ok_ml then
  ml.setup({ ensure_installed = { "ts_ls", "eslint", "html", "cssls" } })
end

-- Autocomplete UI
local ok_cmp, cmp = pcall(require, "cmp")
if ok_cmp then
  cmp.setup({
    snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
    mapping = cmp.mapping.preset.insert({
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<C-s>'] = function() vim.cmd("w") end, -- Custom save shortcut
    }),
    sources = { { name = 'nvim_lsp' } }
  })
end

-- Terminal (FIXED: Removed open_mapping to prevent Insert Mode triggers)
local ok_tt, toggleterm = pcall(require, "toggleterm")
if ok_tt then
  toggleterm.setup({
    size = 20,
    direction = 'horizontal',
    shade_terminals = true,
  })
end

-- Enable Language Servers (0.11 Way)
local servers = { "ts_ls", "eslint", "html", "cssls" }
local capabilities = require('cmp_nvim_lsp').default_capabilities()
for _, lsp in ipairs(servers) do
  if vim.lsp.config then
    vim.lsp.config(lsp, { capabilities = capabilities })
    vim.lsp.enable(lsp)
  end
end

-- Copilot Agent Setup
require("copilot").setup({
  suggestion = { enabled = true, auto_trigger = true, keymap = { accept = "<C-l>" } },
})
require("CopilotChat").setup()

-- ========================================================================== --
-- 5. KEYMAPS (STRICT NORMAL MODE ONLY)
-- ========================================================================== --

-- File Explorer (Only works in Normal Mode)
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })

-- Terminal (Only works in Normal Mode)
vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>", { silent = true })

-- Save File Shortcut (Works in Normal, Insert, and Visual)
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<Esc>:w<cr>", { silent = true })

-- COPILOT CHAT
vim.keymap.set("n", "<leader>cc", ":CopilotChatToggle<CR>", { silent = true })
vim.keymap.set("v", "<leader>ce", ":CopilotChatExplain<CR>", { silent = true })

-- Telescope
local ok_tele, builtin = pcall(require, 'telescope.builtin')
if ok_tele then
  vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
end

-- LSP Actions (Active when a language server is attached)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end,
})
