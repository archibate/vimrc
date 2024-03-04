vim.notify = require('notify')
vim.notify.setup {
    background_colour = "#000000",
    render = 'minimal',
    minimum_width = 50,
    max_width = 100,
    timeout = 1000,
}

local old_notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    old_notify(msg, ...)
end
