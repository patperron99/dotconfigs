return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- your noice.nvim options here
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({
      -- your noice.nvim setup options here
    })

    -- Configure nvim-notify
    require("notify").setup({
      background_colour = "#000000",
      stages = "fade_in_slide_out",
      timeout = 3000,
    })
  end,
}
