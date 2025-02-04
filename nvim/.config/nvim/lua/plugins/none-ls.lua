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
        null_ls.builtins.formatting.beautysh,    -- Bash formatter
        null_ls.builtins.diagnostics.shellcheck, -- Bash linter
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
