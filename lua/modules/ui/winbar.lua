local api = vim.api
local winbar = {}

local function get_file_name()
  local sep = vim.loop.os_uname().sysname == 'Windows_NT' and '\\' or '/'
  local path_list = string.gsub(vim.fn.expand('%:p:h'), '/', '\\')
  path_list = vim.split(path_list, sep)

  local file_path = path_list[#path_list] ~= nil and path_list[#path_list] or ''
  -- Then generate winbar string. For example:
  -- for _, cur in ipairs(path_list) do
  --   file_path = (cur == '.' or cur == '~') and ''
  --     or file_path .. cur .. ' ' .. '%#LspSagaWinbarSep#>%*' .. ' %*'
  -- end
  local ok, devicons = pcall(require, 'nvim-web-devicons')
  local f_icon = ''
  local f_hl = ''
  if ok then
    f_icon, f_hl = devicons.get_icon_by_filetype(vim.bo.filetype)
  end -- if filetype doesn't match devicon will set f_icon to nil so add a patch
  f_icon = f_icon == nil and '' or (f_icon .. ' ') -- No icon no space after separator
  f_hl = f_hl == nil and '' or f_hl
  return '%#' .. 'DevIconJs' .. '#' .. '  ' .. '%*'
    .. file_path
    .. '%#LspSagaWinbarSep#>%* '
    .. '%#'
    .. f_hl
    .. '#'
    .. f_icon
    .. '%*'
    .. '%#LspSagaWinbarFile#'
    .. vim.fn.expand('%:t')
    .. '%*'
end

local exclude_buffer = {
  ['TelescopePrompt'] = true,
  ['terminal'] = true,
  ['dashboard'] = true,
  ['lspsagaoutline'] = true,
  ['help'] = true,
  ['lspsagafinder'] = true,
  ['sagacodeaction'] = true,
}

local function config_winbar()
  if vim.bo.filetype == '' then
    vim.wo.winbar = nil
    return
  end
  if exclude_buffer[vim.bo.filetype] then
    vim.wo.winbar = nil
    return
  end

  local ok, lspsaga = pcall(require, 'lspsaga.symbolwinbar')
  local sym
  if ok then
    sym = lspsaga.get_symbol_node()
  end
  local win_val = ''
  win_val = get_file_name()
  if sym ~= nil then
    win_val = win_val .. sym
  end
  vim.wo.winbar = win_val
end

api.nvim_create_autocmd(
  { 'BufEnter', 'CursorMoved', 'WinLeave', 'BufWinEnter' },
  {
    pattern = '*',
    callback = function()
      if vim.fn.winheight(0) > 1 then
        config_winbar()
      end
    end,
  }
)

return winbar
