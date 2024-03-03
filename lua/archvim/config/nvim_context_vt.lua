require('nvim_context_vt').setup({
  enabled = true,
  prefix = '#',
})

local utils = require('nvim_context_vt.utils')
utils.default_parser = function(node, _, opts)
    local text = utils.get_node_text(node, 0)[1]
    if vim.bo.filetype == 'c' or vim.bo.filetype == 'cpp' or vim.bo.filetype == 'cuda' or vim.bo.filetype == 'glsl' then
        return string.format('// %s', text)
    end
    if vim.bo.commentstring == '' then
        return opts.prefix .. ' ' .. text
    end
    if vim.bo.commentstring:find('%s') then
        text = string.format(vim.bo.commentstring, text)
    else
        text = vim.trim(string.format(vim.bo.commentstring, ' ' .. text .. ' '))
    end
    return text
end
