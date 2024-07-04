local api = vim.api
local command = function(name, thing, tab)
  if not name then
    zima.nerror('Name is nil, cannot register command')
    return
  end
  if not thing then
    zima.nerror(('For command [%s] - thing is nil, cannot register command'):format(name))
    return
  end

  if not tab or vim.tbl_isempty(tab) then
    api.nvim_create_user_command(name, thing, {})
  else
    api.nvim_create_user_command(name, thing, tab)
  end
end
command(
  'SBLL',
  zima.unimplemented(function(args)
    -- TODO: Write that in lua
    zima.Sx(
      args.line1,
      args.line2,
      [[awk '{ print length(), $0 | "sort -nr" }' | cut -f2- -d" "]]
    )
  end),
  { range = '%' }
)

command(
  'Uniq',
  zima.unimplemented(function(args)
    -- TODO: Write that in lua
    zima.Sx(
      args.line1,
      args.line2,
      [[awk '!visited[$0]++']]
    )
  end),
  { range = '%' }
)

command(
  'FK',
  zima.unimplemented(function(args)
    local split, trim = vim.fn.split, vim.fn.trim

    local last_5_history_entries = split(api.nvim_exec2('history : -5,', { output = true }).output, '\n')
    table.remove(last_5_history_entries, 1)

    for _, cmd in ipairs(last_5_history_entries) do
      cmd = trim(cmd):gmatch("%d+ (.*)")()

      local substitution_pat = [[.-s/(.-[^\])/(.-[^\])/(.*)]]
      local prev_sub_from, prev_sub_to, prev_sub_flags = cmd:gmatch(substitution_pat)()

      if prev_sub_from and prev_sub_to and prev_sub_to ~= '' then
        local beginning_row = api.nvim_buf_get_mark(0, '<')[1]
        local ending_row = api.nvim_buf_get_mark(0, '>')[1]

        -- still to do lol
        local prev_substitution = vim.fn.substitute(prev_sub_from, prev_sub_to, "", prev_sub_flags)

        -- b4.P(
        --   ('%s, %ss/%s/%s'):format(beginning_row, ending_row, substitution, args.args),
        --   substitution,
        --   beginning_row,
        --   ending_row
        -- )

        -- api.nvim_exec2('undo', { output = false })
        -- api.nvim_exec2(
        --   (('%s, %ss/%s/%s'):format(beginning_row, ending_row, cmd, args.args)),
        --   { output = false }
        -- )
        break
      end
    end
  end)
  { nargs = '*' }
)
