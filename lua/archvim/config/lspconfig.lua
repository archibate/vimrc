vim.diagnostic.config{
    -- 诊断的虚拟文本
    virtual_text = {
        -- 显示的前缀，可选项：'●', '▎', 'x'
        -- 默认是一个小方块，不是很好看，所以这里改了
        prefix = "●",
        -- 是否总是显示前缀？是的
        source = "always",
    },
    float = {
        -- 是否显示诊断来源？是的
        source = "always",
    },
    -- 在插入模式下是否显示诊断？不要
    update_in_insert = false,
}

require'lspconfig'.pyright.setup{}
require'lspconfig'.clangd.setup{}
