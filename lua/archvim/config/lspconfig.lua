require'lspconfig'.pyright.setup{}
-- require'lspconfig'.clangd.setup{}
require'lspconfig'.lua_ls.setup{}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.cmake.setup{}
require'lspconfig'.tsserver.setup{}

require('lspconfig').clangd.setup{
    on_new_config = function(new_config, new_cwd)
        local status, cmake = pcall(require, "cmake-tools")
        if status then
            cmake.clangd_on_new_config(new_config)
        end
    end,
}
