local config = {}

function config.nvim_tree()
  require('nvim-tree').setup()
end

function config.telescope()
  if not packer_plugins['plenary.nvim'].loaded then
    vim.cmd([[packadd plenary.nvim]])
    vim.cmd([[packadd telescope-fzy-native.nvim]])
  end
  require('telescope').setup({
    defaults = {
      layout_config = {
        horizontal = { prompt_position = 'top', results_width = 0.6 },
        vertical = { mirror = false },
      },
      sorting_strategy = 'ascending',
      file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    },
    pickers = {
      find_files = {
        theme = 'cursor'
      }
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
      ["ui-select"] = {
        require("telescope.themes").get_cursor {

        }
      },
    },
  })
  require('telescope').load_extension('fzy_native')
  require('telescope').load_extension('ui-select')
end

return config
