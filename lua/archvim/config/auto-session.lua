-- https://github.com/rmagatti/auto-session

-- 推荐设置
vim.o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

require("auto-session").setup {
    auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
    auto_session_enable_last_session = false,
    auto_session_enabled = true,
    auto_session_create_enabled = true,
    -- 保存会话时自动关闭 nvim-tree
    -- 这是因为 nvim-tree 如果处于开启
    -- 状态，会破坏会话的保存
    pre_save_cmds = {
        "tabdo NvimTreeClose",
        "tabdo noautocmd bufdo exec \"if &bt == 'terminal' | bdelete | endif\"",
    },
}

-- 在每次退出 neovim 时自动保存会话
-- 其实该插件不加这个自动命令也能
-- 自动保存会话，但总是感觉效果不理想
-- 所以这里我就自己加了个自动命令
vim.cmd [[
augroup save_session_on_exit
autocmd!
autocmd VimLeavePre * silent! :SaveSession
augroup end
]]
