require'nvim-gpt'.setup {
    -- which backend to use: gpt-3.5-turbo, gpt-4, gpt-4-32k, creative, balanced, percise, google-search
    model = 'gpt-3.5-turbo',
    -- model = 'deepseek-ai/deepseek-llm-7b-chat',
    -- model = 'balanced',
    -- model = 'dummy',
    -- may provide specific parameters like temperature depends on models
    params = {
        ['gpt-3.5-turbo'] = {
            -- see https://platform.openai.com/docs/api-reference/chat/create
            temperature = 0.85,
            top_p = 1,
            n = 1,
            presence_penalty = 0,
            frequency_penalty = 0,
        },
        ['google-search'] = {
            -- see https://pypi.org/project/googlesearch-python
            num_results = 10,
            sleep_interval = 0,
            timeout = 5,
            lang = 'en',
            format = '\n# {title}\n- {url}\n\n{desc}\n',
        },
    },
    -- '|/_\\' = rotating loading symbol, '_ ' = blinking on and off, '' = disable
    -- cursors = '|/_\\',
    cursors = '🌑🌒🌓🌔🌕🌖🌗🌘',
    -- cursors = '▙▛▜▟',
    -- cursors = '',
    -- this is how we quote code when :'<,'>GPTCode
    code_quote = '{question}\n```{filetype}\n{code}\n```',
    -- this is how we ask for code insertion when :GPTWrite
    code_insertion = {
        '### File: {file}\n',
        '### <do code insertion here>',
        '\n### Instruction\nDo code insertion at the <do code insertion here> mark. Note that you only need to output the text to be inserted, with no additional text.',
    },
    -- title indicating human question in GPT window
    question_title = '\n🙂:',
    -- title indicating bot answer in GPT window
    answer_title = '\n🤖:',
    -- marker use when human requests to regenerate
    regenerate_title = '🔄',
    -- whether to show bot's welcome messages on start up: 'fancy', '🤖 {}', 'none'
    welcome_messages = '🤖 {}',
    -- GPT window width
    window_width = 45,
    -- GPT window specific options
    window_options = {
        wrap = true,
        signcolumn = 'no',
        list = false,
        cursorline = true,
        number = false,
        relativenumber = false,
    },
    -- whether we lock to last line when answer: none, last-char, last-line, force
    lock_last_line = 'force',
    -- GPT window update interval (ms) when streaming the answer
    update_interval = 100,
    -- automatically add default keymaps (see 'Keymaps' section below)
    no_default_keymaps = false,
    question_templates = [[
Note that you shall only output the plain answer, with no additional text like 'Sure' or 'Here is the result'.
Please wrap the final answer with triple quotes like ```answer```.
The answer is wrong, please try again.
Write a test for this code.
Write an documentation or API reference for this code.
Could you find any possible BUGs in this code?
Write a benchmark for this code. You may want to use the Google Benchmark as framework.
Rewrite to simplify this.
Edit the code to fix the problem.
How to fix this error?
Explain the purpose of this code, step by step.
Rename the variable and function names to make them more readable.
Rewrite to make this code more readable and maintainable.
This line is too long and complex. Could you split it for readability?
Please reduce duplication by following the Don't Repeat Yourself principle.
Complete the missing part of code with given context.
Implement the function based on its calling signature.
Here is a markdown file that have several links in the format [name](link), please fill the links according to given name. You may want to search the web if you are not sure about the link.
Make this expression longer and fullfilling.
Let's think step by step.
Could you verify this?
You may want to search the web.
Since the output length is limited. Please omit the unchanged part with ellipses. Only output the changed or newly-added part.
Please provide multiple different versions of answer for reference.
Fix possible grammar issues or typos in my writing.
Rewrite with better choices of words.
Translate from Chinese to English, or English to Chinese.
请给出如何解决问题的bash指令，确保你给出的指令是可以直接正常执行的。不要输出伪代码，不要含有placeholder。我会回复你命令执行的结果。你总是以可执行的bash命令来告诉我下一步怎么做，你的回答总是应该包含一个bash命令块。如果问题太大，你可以一步一步来，把问题分解成若干个可实操的步骤，现在你只需要告诉我第一步该怎么用bash命令来做。如果我的问题中包含你不知道的信息，你可以输出ls命令来查看我的文件系统，或用cat来查看文件内容。如果我的问题需要创建或修改文件，请你用这种格式: cat > somefile.txt <<EOF <file content> EOF 来创建或修改文件内容。如果只需往文件里追加内容，可以用>>。如果只需查找替换部分内容，可以用sed。
]],
}
