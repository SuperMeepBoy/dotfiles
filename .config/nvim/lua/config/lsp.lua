require('lspkind').init({
    -- defines how annotations are shown
    -- default: symbol
    -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
    mode = 'symbol_text',

    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = 'default',

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "",
    },
})

-- Python LSP config
local venv_python = vim.fn.getcwd() .. "/.venv/bin/python"

vim.lsp.config('pylsp', {
    settings = {
        pylsp = {
            cmd = {
                'uv',
                'run',
                '--with',
                'python-lsp-server,python-lsp-isort,pylsp-rope,python-lsp-ruff,pylsp-mypy,pyls-memestra',
                'pylsp'
            },
            configurationSources = { "flake8" },
            plugins = {
                -- Disable default linter
                pyflakes = {
                    enabled = false,
                },
                pycodestyle = {
                    enabled = false,
                },
                mccabe = {
                    enabled = false,
                },
                -- Plugins configuration
                flake8 = {
                    enabled = true,
                },
                isort = {
                    enabled = true,
                },
                jedi_completion = {
                    enabled = true,
                    fuzzy = true
                },
                ["pyls-memestra"] = {
                    enabled = true,
                    recursive = true
                },
                -- Cf. https://jdhao.github.io/2023/07/22/neovim-pylsp-setup/
                pylsp_mypy = {
                    enabled = true,
                    overrides = {"--python-executable", venv_python, true},
                },
                rope_autoimport = {
                    enabled = true
                },
                -- ruff = {
                --     enabled = true,
                --     formatEnabled = true,
                --     extendSelect = { "E", "F" },
                --     targetVersion = "py310",
                -- }
            }
        }
    }
})

-- vtsls LSP config
local vue_language_server_path = '/usr/lib/node_modules/@vue/language-server'
local vue_plugin = {
    name = '@vue/typescript-plugin',
    location = vue_language_server_path,
    languages = { 'vue' },
    configNamespace = 'typescript',
    enableForWorkspaceTypeScriptVersions = true,
}
vim.lsp.config('vtsls', {
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    vue_plugin,
                },
            },
        },
    },
})
vim.lsp.config('vue_ls', {})

-- Enable LSPs
vim.lsp.enable({
    'pylsp',
    'stylelint_lsp',
    'lua_ls',
    'vtsls',
    'vue_ls',
})

-- Config LSP
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
        end, opts)
    end,
})
