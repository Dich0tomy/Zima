-- TODO: Zima vim options module
return zf.modules.create({
  name = "options",
  entry = function()
    vim.opt.exrc = true -- Loads .nvim.lua
    vim.opt.splitbelow = true
    vim.opt.splitright = true
    vim.opt.shiftround = true -- Round indent to multiple of shiftwidth
    vim.opt.hlsearch = true
    vim.opt.cursorline = true -- Highlights line the cursor is on
    vim.opt.swapfile = false
    vim.opt.undofile = true
    vim.opt.copyindent = true -- Copies indent style of previous line
    vim.opt.lazyredraw = true -- Don't redraw screen while executing macros and such
    vim.opt.incsearch = true
    vim.opt.autoread = true -- Auto reads file if changed outside of neovim
    vim.opt.smartcase = true
    vim.opt.wrap = true

    vim.opt.selection = 'old'
    vim.opt.clipboard = "unnamedplus"
    vim.opt.virtualedit = "block"
    vim.opt.inccommand = "split" -- Shows the effects of certain commands like :s

    vim.opt.confirm = true -- Asks for confirmation instead of failing for :q and such

    vim.opt.conceallevel = 2
    vim.opt.shiftwidth = 2
    vim.opt.updatetime = 100
    vim.opt.sidescrolloff = 8
    vim.opt.scrolloff = 999
    vim.opt.tabstop = 2

    vim.opt.showtabline = 1 -- Only display tabline if there are 2 or more tabs
    vim.opt.laststatus = 3 -- When will the last window have a statusline, 3 means uniform on all
    vim.opt.colorcolumn = 120

    vim.opt.list = true -- Shows tabs, spaces, etc.
    vim.opt.listchars = {
      tab = '  ',
      lead = '·',
      nbsp = '␣',
      precedes = '«',
      extends = '»'
    }
    vim.opt.fillchars = {
      stl = ' ',
      stlnc = ' ',
      diff = '╱',
      fold = ' ',
      foldsep = ' ',
      foldclose = '',
      foldopen = '',
      eob = ' ',
      msgsep = '─'
    }

    -- TODO: Revise
    vim.opt.diffopt = {
      algorithm = 'histogram',
      internal = true,
      ['indent-heuristic'] = true,
      filler = true,
      closeoff = true,
      iwhite = true,
      vertical = true
    }
    vim.opt.showbreak = "⤷ "
  end
})
