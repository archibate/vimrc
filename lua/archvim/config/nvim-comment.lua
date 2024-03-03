local function update_commentstring()
    require("ts_context_commentstring.internal").update_commentstring()
    if vim.bo.commentstring == '' then
        if vim.bo.filetype == 'glsl' then
            vim.bo.commentstring = '//%s'
        else
            vim.bo.commentstring = '#%s'
        end
    end
    -- end
end

-- vim.api.nvim_create_autocmd("BufEnter", {
--     callback = function()
--         update_commentstring()
--     end
-- })

require('nvim_comment').setup {
  -- Linters prefer comment and line to have a space in between markers
  marker_padding = true,
  -- should comment out empty or whitespace only lines
  comment_empty = true,
  -- trim empty comment whitespace
  comment_empty_trim_whitespace = true,
  -- Should key mappings be created
  create_mappings = true,
  -- Normal mode mapping left hand side
  line_mapping = "gcc",
  -- Visual/Operator mapping left hand side
  operator_mapping = "gc",
  -- text object mapping, comment chunk,,
  comment_chunk_text_object = "ic",
  -- Hook function to call before commenting takes place
  hook = update_commentstring,
}
