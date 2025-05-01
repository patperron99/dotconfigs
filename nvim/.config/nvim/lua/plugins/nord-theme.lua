return {
    'shaunsingh/nord.nvim',
    name = 'nord',
    config = function()
        vim.g.nord_contrast = true
        vim.g.nord_borders = false
        vim.g.nord_disable_background = true
        vim.g.nord_italic = false
        vim.g.nord_uniform_diff_background = true
        vim.g.nord_bold = false

        require("nord").set()
        vim.cmd.colorscheme "nord"

        -- Set background transparency
        vim.cmd([[
            highlight Normal guibg=NONE ctermbg=NONE
            highlight NonText guibg=NONE ctermbg=NONE
        ]])

        -- Adjust transparency percentage (0-100%)
        local alpha = 0.9 -- 90% transparency
        vim.cmd('highlight Normal guibg=#000000') -- Set background color with alpha
        vim.cmd('highlight NonText guibg=#000000') -- Set background color with alpha
    end
}
