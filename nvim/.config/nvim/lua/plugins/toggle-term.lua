return {
  -- amongst your other plugins
  -- {'akinsho/toggleterm.nvim', version = "*", config = true}
  {'akinsho/toggleterm.nvim', version = "*", opts = {
   direction = "float",
    float_opts = {
      border = "curved",
      width = 120,
      height = 30,
    },
    open_mapping = [[<C-\>]],
    hide_numbers = true,
    shade_terminals = false,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    close_on_exit = true,
    shell = vim.o.shell,
    }}
}
