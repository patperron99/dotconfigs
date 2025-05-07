return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  opts = {
    provider = "codestral",
    vendors = {
      codestral = {
        endpoint = "https://codestral.mistral.ai/v1/",
        model = "codestral-2501", -- Specify the Codestral model you want to use
        timeout = 30000, -- Timeout in milliseconds
        temperature = 0, -- Adjust if needed
        max_tokens = 4096,
        __inherited_from = "openai",
      },
    },
    suggestions = {
      enabled = true,
      provider = "codestral",
      model = "codestral-2501",
      timeout = 30000,
      temperature = 0,
      max_tokens = 4096,
    },
  },
  build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
}

