return {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      require("catppuccin").setup({
        transparent_background = true,  -- Enable transparency
        integrations = {
          notify = true, -- Enable notify integration
    }
      })
      vim.cmd.colorscheme "catppuccin"
    end
}
