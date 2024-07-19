return {
    "preservim/nerdcommenter",
    event = "VeryLazy",
    config = function()
        -- 启用默认的映射创建
        vim.g.NERDCreateDefaultMappings = 1
        -- 默认在注释分隔符后添加空格
        vim.g.NERDSpaceDelims = 1
        -- 为格式化的多行注释使用紧凑语法
        vim.g.NERDCompactSexyComs = 1
        -- 在取消注释时启用尾随空格的修剪
        vim.g.NERDTrimTrailingWhitespace = 1
        -- 将逐行注释分隔符对齐到左侧而不是跟随代码
        vim.g.NERDDefaultAlign = 'left'
        -- 允许注释和反转空行（在注释一个区域时非常有用）
        vim.g.NERDCommentEmptyLines = 1
        -- 在取消注释时启用尾随空格的修剪
        vim.g.NERDTrimTrailingWhitespace = 1
        -- 启用NERDCommenterToggle以检查所有选定的行是否已注释或未注释
        vim.g.NERDToggleCheckAllLines = 1
        -- NERDCommenterToggle 以 ctrl+/ 触发
        vim.keymap.set({'n', 'v'}, '<C-_>', '<Plug>NERDCommenterToggle', { noremap = true, silent = true })
    end
}
