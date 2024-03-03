require'marks'.setup{
    sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
    -- builtin_marks = { "'", "." },
    -- bookmark_0 = {
    --     sign = "⚑",
    --     virt_text = "hello world",
    --     -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
    --     -- defaults to false.
    --     annotate = false,
    -- },
    refresh_interval = 200,
}
