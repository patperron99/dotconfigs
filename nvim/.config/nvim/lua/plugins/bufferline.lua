# Add and activate the bufferline plugin from akinsho/nvim-bufferline.lua
return {
  "akinsho/nvim-bufferline.lua",
  name = "bufferline",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional dependency for buffer icons
  },
  opts = {
    options = {
      -- create an offset over nvim-tree
      offsets = {
        {
          filetype = "NvimTree", -- filetype of the offset
          text = "File Explorer", -- text to display in the offset
          highlight = "Directory", -- highlight group for the offset text
          text_align = "left", -- alignment of the offset text
          separator = true, -- whether to show a separator line
        },
      },
      -- mode = "buffers", -- set to "tabs" to use tabs instead of buffers
      -- numbers = "none", -- disable line numbers in bufferline
      -- close_command = "bdelete! %d", -- command to close the buffer
      -- right_mouse_command = "bdelete! %d", -- command for right-click close
      -- left_mouse_command = "buffer %d", -- command for left-click switch to buffer
      -- indicator_icon = '▎', -- icon for the active buffer indicator
      -- buffer_close_icon = '', -- icon for closing buffers
      -- modified_icon = '●', -- icon for modified buffers
      -- close_icon = '', -- icon for closing buffers
      -- show_buffer_icons = true, -- show icons in the bufferline
      -- show_buffer_close_icons = true, -- show close icons in the bufferline
      -- show_close_icon = false, -- hide close icon on the right side of the bufferline
      -- -- separator_style = "slant", -- style of separators between buffers
      -- enforce_regular_tabs = false, -- enforce regular tabs (not recommended)
    },
  },
}
