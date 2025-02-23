return {
  {
    "github/copilot.vim",
    config = function()
      -- Enable Copilot
      vim.g.copilot_enabled = 1

      -- Map the key to accept Copilot suggestion (change <C-J> to your preferred keybinding)
      vim.api.nvim_set_keymap("i", "<C-l>", "copilot#Accept('<CR>')", { silent = true, expr = true })

      -- Disable Copilot in specific filetypes
      vim.g.copilot_filetypes = {
        ["TelescopePrompt"] = false,
      }
    end
  }
}
