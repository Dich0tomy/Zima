local silent_noremap = { silent = true, noremap = true }
local silent_remap = { silent = true, remap = true }

local keymap = function(modes, left, right, opts)
  vim.keymap.set(modes, left, right, opts or silent_noremap)
end

local with_desc = function(opts, description)
  return vim.tbl_extend('force', opts, { desc = description })
end

local extend = function(right, left)
  return vim.tbl_extend('force', left, right)
end

-- NOTE: LEADER IS SET TO SPACE

keymap('n', '<A-j>', [[:m .+1<CR>==]])
keymap('v', '<A-j>', [[:m '>+1<CR>gv=gv]])
keymap('i', '<A-j>', [[<Esc>:m .+1<CR>==gi]])
keymap('n', '<A-k>', [[:m .-2<CR>==]])
keymap('v', '<A-k>', [[:m '<-2<CR>gv=gv]])
keymap('i', '<A-k>', [[<Esc>:m .-2<CR>==gi]])

-- Fuzzy findable `/` and `/`
keymap(
  'c',
  "<space>",
  function()
    local mode = vim.fn.getcmdtype()
    if mode == "?" or mode == "/" then
      return ".*"
    else
      return " "
    end
  end,
  { expr = true, silent = true, noremap = true }
)

-- Makes * nad # work in visual mode
vim.cmd([[
  function! g:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
  endfunction

  xnoremap * :<C-u>call g:VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
  xnoremap # :<C-u>call g:VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
]])

-- Ctrl + C as Esc
keymap('i', '<C-c>', '<Esc>')

-- Ctrl + q goes into normal mode in terminal
keymap('t', '<C-q>', '<C-\\><C-n>')

-- Tab specific keymaps
keymap('n', '<C-n>', '<cmd>tabnew<cr>')
keymap('n', '<C-h>', '<cmd>tabprev<cr>')
keymap('n', '<C-l>', '<cmd>tabnext<cr>')

keymap('i', '<C-n>', '<C-o><cmd>tabnew<cr>')
keymap('i', '<C-h>', '<C-o><cmd>tabprev<cr>')
keymap('i', '<C-l>', '<C-o><cmd>tabnext<cr>')

-- j and k use gj and gk
keymap({'n', 'v'}, 'k', 'gk')
keymap({'n', 'v'}, 'j', 'gj')

-- <C-w>n opens a new split, let <C-w>N open a new vsplit
keymap('n', '<C-w>N', '<cmd>vnew<cr>')

-- <C-w>T moves current window to a new tab, let <C-w>t replicate current window in a new tab
keymap('n', '<C-w>t', '<cmd>tabnew%<cr>')

local replication_fun = function(direction, magic)
  return function()
    local a = vim.api

    local line_nr = a.nvim_win_get_cursor(0)[1]
    local pos = (direction == 'down') and line_nr or line_nr - 1
    local data = magic or a.nvim_get_current_line()

    a.nvim_buf_set_lines(0, pos, pos, false, { data })
  end
end

-- C-k and C-j replicate lines in normal mode
keymap('n', '<C-k>', replication_fun('down'))

keymap('n', '<C-J>', replication_fun('up'))

-- quickfix shit, useful for Ggrep, GEdit and shi
keymap({ 'n', 'v' }, ']q', '<cmd>cnext<cr>')
keymap({ 'n', 'v' }, '[q', '<cmd>cprev<cr>')
keymap('n', ']Q', '<cmd>cnfile<cr>')
keymap('n', '[Q', '<cmd>cpfile<cr>')

local copy_to_plus_reg = function(data)
  vim.fn.setreg('+', data)
end
local expand = vim.fn.expand

-- <C-f><C-f> copies the filename
keymap(
  { 'n', 'v', 'i' },
  '<C-f><C-f>',
  function()
    copy_to_plus_reg(expand('%:t'))
  end,
  with_desc(silent_noremap, 'Copy filename')
)
-- <C-f><C-f> copies the full path
keymap(
  { 'n', 'v', 'i' },
  '<C-f>p',
  function()
    copy_to_plus_reg(expand('%:p'))
  end,
  with_desc(silent_noremap, 'Copy full path')
)
-- <C-f><C-f> copies the relative path
keymap(
  { 'n', 'v', 'i' },
  '<C-f>r',
  function()
    copy_to_plus_reg(expand('%:.'))
  end,
  with_desc(silent_noremap, 'Copy relative path')
)

-- hitting J doesnt change the cursor pos
keymap({ 'n' }, 'J', 'mxJ`x')

-- TODO: Make p behave like P in visual mode
keymap({ 'v' }, 'p', 'P', silent_noremap)
keymap({ 'v' }, 'P', 'p', silent_noremap)
-- keymap({ 'n', 'x' }, 'p', 'p=`]')
-- keymap({ 'n', 'x' }, 'P', 'P=`]')

-- keymap({ 'n', 'x' }, '<leader>p', 'p', silent_noremap)
-- keymap({ 'n', 'x' }, '<leader>P', 'P', silent_noremap)

-- dD deletes matching region
keymap({ 'x', 'n' }, 'dD', 'd%')
-- cC deletes matching region
keymap({ 'x', 'n' }, 'cC', 'c%')
-- yY yanks matching region
keymap({ 'x', 'n' }, 'yY', 'y%')
-- vv selects matching region
keymap({ 'n' }, 'vv', 'v%o')
keymap({ 'n' }, 'VV', 'V%o')

-- selecting something in insert mode and going back doesnt change the cursor poz
keymap('n', 'v', 'mzv')
keymap('n', 'V', 'mzV')
keymap('x', '<C-c>', '<Esc>`z')

keymap(
  'n',
  '<C-g>',
  function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row = cursor[1]
    local col = cursor[2] + 1

    local lines = vim.api.nvim_buf_line_count(0)

    vim.print(('%s:%s / %s'):format(row, col, lines))
  end
)

-- H and L go to the beggining and end of the line
keymap({'n', 'x', 'o'}, 'H', '^')
keymap({'n', 'x', 'o'}, 'L', 'g_')
