# nvim-gpt

Integrated ChatGPT or Bing AI in NeoVim just for neo-pioneers like you :)

## Install

It's suggested to use [packer.nvim]() to manage NeoVim plugins.

```lua
use({
    'archibate/nvim-gpt',
    config = function()
        require'nvim-gpt'.setup {
            model = 'gpt-3.5-turbo',
        }
    end,
})
```

- [openai-python]() is required for using the ChatGPT backend.

```bash
pip install openai
```

1. Obtain an API key from OpenAI: https://beta.openai.com

2. Add this to your `~/.bashrc`:

```bash
export OPENAI_API_KEY=sk-**********  # replace this with your API key
```

3. and then restart your shell, enter nvim and choose `gpt-3.5-turbo` as model.

- [EdgeGPT]() is required for using the Bing AI backend.

```bash
pip install EdgeGPT
```

1. Obtain the cookies JSON via [Cookie Editor](https://microsoftedge.microsoft.com/addons/detail/cookieeditor/neaplmfkghagebokkhpjpoebhdledlfi) plugin from the [Bing site](https://bing.com/chat).

2. Paste the cookies into file `~/.bing-cookies.json`.

3. Enter nvim and choose `bing-balanced` as backend.

## Keymaps

Add this to your `init.lua` to enable [suggested keymaps](nvim_gpt/keymaps.py):

```lua
local _gpt_add_key_map_timer = vim.loop.new_timer()
_gpt_add_key_map_timer:start(100, 100, vim.schedule_wrap(function ()
    if _gpt_add_key_map_timer and pcall(function () vim.cmd [[GPTSuggestedKeymaps]] end) then
        _gpt_add_key_map_timer:stop()
        _gpt_add_key_map_timer = nil
    end
end))
```
