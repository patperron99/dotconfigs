return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.erb_lint,
        null_ls.builtins.formatting.black, -- Python code formatter
        null_ls.builtins.formatting.isort, -- Python import sorter
        null_ls.builtins.diagnostics.pylint.with({
          -- Customize pylint to match your project standards
          extra_args = { "--disable=C0111" } -- You can customize these args
        }),
        null_ls.builtins.diagnostics.mypy,   -- Static type checking for Python

        -- Ansible linting
        null_ls.builtins.diagnostics.ansiblelint,

        -- Bash linting and formatting
        null_ls.builtins.formatting.shfmt.with({
            extra_args = { "-i", "4" } -- Set indentation to 4 spaces (change as needed)
        }),
        -- null_ls.builtins.formatting.beautysh,    -- Bash formatter
        null_ls.builtins.diagnostics.shellcheck, -- Bash linter
      },
    })

    -- Function to toggle null-ls for the current buffer
    local function toggle_null_ls()
      local clients = vim.lsp.get_active_clients({ bufnr = 0 })
      for _, client in ipairs(clients) do
        if client.name == "null-ls" then
          if client.is_stopped() then
            client.start()
            print("null-ls enabled for the current buffer")
          else
            client.stop()
            print("null-ls disabled for the current buffer")
          end
          return
        end
      end
      print("null-ls is not active in the current buffer")
    end

    -- Map the function to a key combination, e.g., <leader>tn
    vim.keymap.set("n", "<leader>tn", toggle_null_ls, { noremap = true, silent = true })

    -- Existing key mapping for formatting
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
