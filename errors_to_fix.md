Failed to run `config` for lualine.nvim
/home/cturnrq/.config/nvim/lua/plugins/coding.lua:246: attempt to index field 'sections' (a nil value)
# stacktrace:
  - lua/plugins/coding.lua:246 _in_ **values**


Failed to run `config` for nvim-lspconfig

/home/cturnrq/.config/nvim/lua/plugins/lsp/init.lua:199: bad argument #1 to 'lsp_get_config' (table expected, got string)

# stacktrace:
  - lua/plugins/lsp/init.lua:199 _in_ **config**
  - vim/_editor.lua:0
  - /neo-tree.nvim/lua/neo-tree/utils/init.lua:643 _in_ **open_file**
  - /neo-tree.nvim/lua/neo-tree/sources/common/commands.lua:687 _in_ **open**
  - /neo-tree.nvim/lua/neo-tree/sources/common/commands.lua:718 _in_ **open_with_cmd**
  - /neo-tree.nvim/lua/neo-tree/sources/common/commands.lua:727 _in_ **open**
  - /neo-tree.nvim/lua/neo-tree/sources/filesystem/commands.lua:184 _in_ **func**
  - /neo-tree.nvim/lua/neo-tree/ui/renderer.lua:842
