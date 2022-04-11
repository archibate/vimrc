require("lint").linters_by_ft = {
    python = {"pylint"},
    c = {"clangtidy"},
    cpp = {"clangtidy"},
    cmake = {"cmakelint"},
    javascript = {"eslint"},
    typescript = {"eslint"},
    go = {"golangcilint"},
    markdown = {"vale"},
    yaml = {"yamllint"},
    bash = {"shellcheck"},
    -- INFO: add your language here
}
vim.cmd [[
augroup nvim_lint_try_lint_ont_write
autocmd!
autocmd BufWritePost <buffer> lua require('lint').try_lint()
augroup end
]]
