return {
    name = "run script",
    builder = function()
        local file = vim.fn.expand("%:p")
        local cmd = { file }
        if vim.bo.filetype == "sh" then
            cmd = { "bash", file }
        elseif vim.bo.filetype == "python" then
            cmd = { "python", file }
        elseif vim.bo.filetype == "go" then
            cmd = { "go", "run", file }
        elseif vim.bo.filetype == "javascript" then
            cmd = { "node", file }
        elseif vim.bo.filetype == "perl" then
            cmd = { "perl", file }
        elseif vim.bo.filetype == "ruby" then
            cmd = { "ruby", file }
        elseif vim.bo.filetype == "c" then
            cmd = { "bash", "-c", "gcc '" .. file .. "' -o /tmp/a.out && /tmp/a.out" }
        elseif vim.bo.filetype == "cpp" then
            cmd = { "bash", "-c", "g++ '" .. file .. "' -O3 -DNDEBUG -std=c++20 -o /tmp/a.out && /tmp/a.out" }
        end
        return {
            cmd = cmd,
            components = {
                { "on_output_quickfix", set_diagnostics = true },
                "on_result_diagnostics",
                "default",
            },
        }
    end,
    condition = {
        filetype = {
            "sh",
            "python",
            "go",
            "javascript",
            "perl",
            "ruby",
            "c",
            "cpp",
        },
    },
}
