require("lint").linters_by_ft = {
    python = {"pylint"},
    c = {"clangtidy"},
    cpp = {"cpplint"},
    cmake = {"cmakelint"},
    javascript = {"eslint"},
    typescript = {"eslint"},
    go = {"golangcilint"},
    markdown = {"vale"},
    yaml = {"yamllint"},
    bash = {"shellcheck"},
    lua = {"luacheck"},
    -- INFO: add your language here
}
-- vim.cmd [[
-- augroup nvim_lint_try_lint_ont_write
-- autocmd!
-- autocmd BufEnter,BufWritePost * lua require('lint').try_lint()
-- augroup end
-- ]]
vim.keymap.set({"n", "v"}, "gq", function () require('lint').try_lint() end)
