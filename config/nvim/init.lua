-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Sec: Options 
-- Make sure to setup `mapleader` and `maplocalleader` before
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Auto read file when changed from outside
vim.o.autoread = true

-- Disable hlsearch after pressing Esc in normal mode
-- vim.o.hlsearch = false
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR><CR>')

-- Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
-- vim.o.clipboard = 'unnamedplus'

-- Always have at least 15 lines visible top and bottom
vim.o.scrolloff = 15

-- Tabbing
-- vim.o.tabstop = 8
-- vim.o.shiftwidth = 8
-- vim.o.expandtab = true
vim.o.eol = false

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 100

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Hide commandline below lualine
vim.o.ch = 0

-- Alternate escape
-- vim.keymap.set('i', 'kj', '<Esc>')

-- don't load netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Assembly syntax highlighting
vim.cmd 'autocmd BufNewFile,BufRead *.asm setfiletype asm'
-- vim.cmd.colorscheme("retrobox")

-- Sec: Keymaps 
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Close buffer with leader+q
vim.keymap.set("n", "<leader>q", "<cmd>bd<cr>", { desc = "Close buffer" })

-- Go to next buffer with Tab
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Go to previous buffer with Shift+Tab
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

-- open quickfixlist
vim.keymap.set('n', '<leader>l', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- highlight groups for indentation
-- vim.cmd.highlight('IndentLine guifg=#504945')
-- vim.cmd.highlight('IndentLineCurrent guifg=#689d6a')


-- Sec: Plugins 
-- Setup lazy.nvim
require("lazy").setup({
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "tokyonight" } },
    performance = {
        rtp = {
            disabled_plugins = {
                'gzip',
                'netrwPlugin',
                'tarPlugin'
            }
        }
    },

    -- Git changes
    {
        'tpope/vim-fugitive',
        event = "VimEnter",
        keys = {
            { "<leader>gs", vim.cmd.G, desc = "Fugitive" },
        },
    },

    -- Surround text with symbols
    {
        'kylechui/nvim-surround',
        version = '*', -- Use for stability; omit to use `main` branch for the latest features
        event = 'InsertEnter',
        opts = {},
    },

    -- Automatic opening and closing html tags
    {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPre", "BufNewFile", "InsertEnter" },
        config = function()
            require('nvim-ts-autotag').setup({
                opts = {
                    -- Defaults
                    enable_close = true,          -- Auto close tags
                    enable_rename = true,         -- Auto rename pairs of tags
                    enable_close_on_slash = false -- Auto close on trailing </
                },
                -- Also override individual filetype configs, these take priority.
                -- Empty by default, useful if one of the "opts" global settings
                -- doesn't work well in a specific filetype
                per_filetype = {
                    ["html"] = {
                        enable_close = false
                    }
                }
            })
        end,
    },

    -- Automatic closing bracket pairs
    {
        'windwp/nvim-autopairs',
        -- Optional dependency
        event = "InsertEnter",
        dependencies = { 'hrsh7th/nvim-cmp' },
        config = function()
            require('nvim-autopairs').setup({
                fast_wrap = {}
            })
            -- If you want to automatically add `(` after selecting a function or method
            -- local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
            -- local cmp = require 'cmp'
            -- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end,
    },

    -- Adds git related signs to the gutter, as well as utilities for managing changes
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '│' },
                change = { text = '│' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
                untracked = { text = '│' },
            },
            on_attach = function(bufnr)
                vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk,
                    { buffer = bufnr, desc = 'Preview git hunk' })

                -- don't override the built-in and fugitive keymaps
                local gs = package.loaded.gitsigns
                vim.keymap.set({ 'n', 'v' }, ']c', function()
                    if vim.wo.diff then
                        return ']c'
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return '<Ignore>'
                end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
                vim.keymap.set({ 'n', 'v' }, '[c', function()
                    if vim.wo.diff then
                        return '[c'
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return '<Ignore>'
                end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
            end,
        },
    },

    -- Visual indentation guide
    -- {
    --     "nvimdev/indentmini.nvim",
    --     opts = {}
    -- },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    },
    -- { 
    --     'echasnovski/mini.indentscope',
    --     version = '*',
    --     opts = {
    --       draw = {
    --         -- Delay (in ms) between event and start of drawing scope indicator
    --         delay = 0,
    --
    --         -- Animation rule for scope's first drawing. A function which, given
    --         -- next and total step numbers, returns wait time (in ms). See
    --         -- |MiniIndentscope.gen_animation| for builtin options. To disable
    --         -- animation, use `require('mini.indentscope').gen_animation.none()`.
    --
    --         -- Symbol priority. Increase to display on top of more symbols.
    --         priority = 2,
    --       },
    --
    --       -- Module mappings. Use `''` (empty string) to disable one.
    --       mappings = {
    --         -- Textobjects
    --         object_scope = 'ii',
    --         object_scope_with_border = 'ai',
    --
    --         -- Motions (jump to respective border line; if not present - body line)
    --         goto_top = '[i',
    --         goto_bottom = ']i',
    --       },
    --
    --       -- Options which control scope computation
    --       options = {
    --         -- Type of scope's border: which line(s) with smaller indent to
    --         -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
    --         border = 'both',
    --
    --         -- Whether to use cursor column when computing reference indent.
    --         -- Useful to see incremental scopes with horizontal cursor movements.
    --         indent_at_cursor = true,
    --
    --         -- Whether to first check input line to be a border of adjacent scope.
    --         -- Use it if you want to place cursor on function header to get scope of
    --         -- its body.
    --         try_as_border = false,
    --       },
    --
    --       -- Which character to use for drawing scope indicator
    --       symbol = '│',
    --     }
    -- },

    -- Detech tabstop and shiftwidth automatically
    {
        "Darazaki/indent-o-matic",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            max_lines = 2048,
            -- Space indentations that should be detected
            standard_widths = { 2, 4, 8 },
            -- Skip multi-line comments and strings (more accurate detection but less performant)
            skip_multiline = true,
        },
    },

    -- Copilot
    -- {
    --   'github/copilot.vim',
    --   event = 'VeryLazy',
    --   config = function()
    --     vim.g.copilot_no_tab_map = true
    --     vim.api.nvim_set_keymap('i', '<A-j>', 'copilot#Accept("<CR>")', { silent = true, expr = true })
    --   end,
    -- },

    -- Statusline
    {
        "sschleemilch/slimline.nvim",
        event = "VeryLazy",
        opts = {
            style = "fg",
            components = {
                right = {
                    "recording",
                    "diagnostics",
                    "filetype_lsp",
                    "progress"
                },
                configs = {
                    recording = {
                        icon = ' recording:'
                    },
                }
            },
        }
    },

    -- Bufferline
    {
        'akinsho/bufferline.nvim',
        version = '*',
        dependencies = 'nvim-tree/nvim-web-devicons',
        event = "VeryLazy",
        opts = {}
    },

    -- Filetree
    {
        'nvim-neo-tree/neo-tree.nvim',
        version = '*',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
        event = "VeryLazy",
        keys = {
            { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
        },
        config = function()
            require('neo-tree').setup {
                window = {
                    position = 'right',
                    width = 40,
                },
                filesystem = {
                    hijack_netrw_behavior = "open_default",
                }
            }
        end,
    },

    {
        'nvim-telescope/telescope.nvim',
        event = "VeryLazy",
        cmd = "Telescope",
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            "nvim-telescope/telescope-live-grep-args.nvim",
        },
        config = function()
            local actions = require('telescope.actions')
            local tbuiltin = require('telescope.builtin')
            pcall(require('telescope').load_extension, 'fzf')

            require("telescope").load_extension("live_grep_args")

            require('telescope').setup {
                defaults = {
                    layout_strategy = 'vertical',
                    layout_config = {
                        prompt_position = 'top',
                        preview_cutoff = 22,
                        height = 0.98,
                        width = 0.98,

                        -- alternate view
                        -- preview_cutoff = 80,
                        -- height = 0.6,
                    },
                    mappings = {
                        i = {
                            ['<esc>'] = actions.close,
                            ['<C-j>'] = actions.move_selection_next,
                            ['<C-k>'] = actions.move_selection_previous,
                        },
                    },
                },
            }

            -- Telescope keymaps
            vim.keymap.set('n', '<leader>?', tbuiltin.oldfiles, { desc = '[?] Find recently opened files' })
            vim.keymap.set('n', '<leader>b', tbuiltin.buffers, { desc = '[ ] Find existing buffers' })
            vim.keymap.set('n', '<leader>/', function()
                -- You can pass additional configuration to telescope to change theme, layout, etc.
                tbuiltin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = true,
                })
            end, { desc = '[/] Fuzzily search in current buffer' })
            vim.keymap.set("n", "<leader>r", require('telescope').extensions.live_grep_args.live_grep_args)


            vim.keymap.set('n', '<leader>gf', tbuiltin.git_files, { desc = 'Search [G]it [F]iles' })
            vim.keymap.set('n', '<leader>f', tbuiltin.find_files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>sh', tbuiltin.help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sw', tbuiltin.grep_string, { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>j', tbuiltin.live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>h', tbuiltin.help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
            vim.keymap.set('n', '<leader>sd', tbuiltin.diagnostics, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>sr', tbuiltin.resume, { desc = '[S]earch [R]esume' })

        end,
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        event = "BufRead",
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },
                sync_install = false,
                ignore_install = { 'haskell' },
                modules = {},
                auto_install = false,
                highlight = { enable = true },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<c-space>',
                        node_incremental = '<c-space>',
                        scope_incremental = '<c-s>',
                        node_decremental = '<M-space>',
                    },
                },
            }
        end,
    },

    -- Harpoon
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
        cmd = "Telescope",
        config = function()
            local harpoon = require("harpoon")
            -- REQUIRED
            harpoon:setup({})
            -- REQUIRED

            vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end)
            vim.keymap.set("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<leader>h2>", function() harpoon:list():select(3) end)
            -- these are cnext/cprev
            -- vim.keymap.set("n", "<F4>", function() harpoon:list():select(4) end)
            -- vim.keymap.set("n", "<F5>", function() harpoon:list():select(5) end)
            vim.keymap.set("n", "<F6>", function() harpoon:list():select(6) end)

            -- Toggle previous & next buffers stored within Harpoon list
            vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end)
            vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end)

            -- basic telescope configuration
            local conf = require("telescope.config").values
            local function toggle_telescope(harpoon_files)
                local file_paths = {}
                for _, item in ipairs(harpoon_files.items) do
                    table.insert(file_paths, item.value)
                end

                require("telescope.pickers").new({}, {
                    prompt_title = "Harpoon",
                    finder = require("telescope.finders").new_table({
                        results = file_paths,
                    }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                }):find()
            end

            vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
                { desc = "Open harpoon window" })
        end
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        dependencies = {
            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
        },
        config = function()
            local cmp = require 'cmp'
            cmp.setup {
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                completion = {
                    completeopt = 'menu,menuone,noinsert',
                },
                mapping = cmp.mapping.preset.insert {
                    ['<C-j>'] = cmp.mapping.select_next_item(),
                    ['<C-k>'] = cmp.mapping.select_prev_item(),
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete {},
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                },
                sources = {
                    { name = "cmp_nvim_lsp" },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                },
            }
        end,
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "LspInfo", "LspInstall", "LspUninstall" },
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',
        },
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
            capabilities = require('cmp_nvim_lsp').default_capabilities()

            local on_attach = function(_, bufnr)

                local nmap = function(keys, func, desc)
                    if desc then
                        desc = 'LSP: ' .. desc
                    end

                    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
                end

                local tbuiltin = require('telescope.builtin')

                nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

                nmap('gd', tbuiltin.lsp_definitions, '[G]oto [D]efinition')
                nmap('gr', tbuiltin.lsp_references, '[G]oto [R]eferences')
                nmap('gI', tbuiltin.lsp_implementations, '[G]oto [I]mplementation')
                nmap('<leader>D', tbuiltin.lsp_type_definitions, 'Type [D]efinition')
                nmap('<leader>ds', tbuiltin.lsp_document_symbols, '[D]ocument [S]ymbols')
                nmap('<leader>ws', tbuiltin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

                -- See `:help K` for why this keymap
                nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
                nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

                -- Lesser used LSP functionality
                nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
                nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
                nmap('<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, '[W]orkspace [L]ist Folders')

                -- Create a command `:Format` local to the LSP buffer
                vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                    vim.lsp.buf.format()
                end, { desc = 'Format current buffer with LSP' })
            end

            require('mason').setup()
            require('mason-lspconfig').setup()

            local servers = {
                -- clangd = {},
                -- rust_analyzer = {},
                -- html = { filetypes = { 'html', 'twig', 'hbs'} },
                pyright = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            typeCheckingMode = 'off',
                            diagnosticMode = 'openFilesOnly',
                        },
                    },
                },
                ts_ls = {},
                gopls = {},
                cmake = {},
            }

            local mason_lspconfig = require 'mason-lspconfig'

            mason_lspconfig.setup {
                ensure_installed = vim.tbl_keys(servers),
            }

            mason_lspconfig.setup_handlers {
                function(server_name)
                    require('lspconfig')[server_name].setup {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes,
                    }
                end,
            }
        end,
    },

    -- Colorschemes
    {
        "Mofiqul/dracula.nvim",
        lazy = false,
        priority = 1000,
        init = function()
            vim.cmd[[colorscheme dracula-soft]]
        end
    },
    {
        "kvrohit/substrata.nvim",
        lazy = true,
        priority = 1000,
        opts = {
            substrata_italic_comments = true
        },
        -- config = function() vim.cmd.colorscheme("substrata") end
    },
    {
        "folke/tokyonight.nvim",
        lazy = true,
        priority = 1000,
        opts = {},
        -- config = function() vim.cmd.colorscheme("tokyonight-night") end,
    },
    {
        "catppuccin/nvim",
        lazy = true,
        priority = 1000,
        opts = {},
        -- config = function() vim.cmd.colorscheme("catppuccin-macchiato") end,
    },
    {
        "gbprod/nord.nvim",
        lazy = true,
        priority = 1000,
        opts = {},
        -- config = function() vim.cmd.colorscheme("nord") end,
    },
    {
        "askfiy/visual_studio_code",
        lazy = true,
        priority = 100,
        -- config = function() vim.cmd.colorscheme("visual_studio_code")end,
    },
    {
      "blazkowolf/gruber-darker.nvim",
      opts = {
        bold = false,
        italic = {
          strings = false,
        },
      },
    },

    -- {
    --     "Isrothy/neominimap.nvim",
    --   version = "v3.x.x",
    --   lazy = false, -- NOTE: NO NEED to Lazy load
    --   -- Optional. You can alse set your own keybindings
    --   keys = {
    --     -- Global Minimap Controls
    --     { "<leader>nm", "<cmd>Neominimap toggle<cr>", desc = "Toggle global minimap" },
    --     { "<leader>no", "<cmd>Neominimap on<cr>", desc = "Enable global minimap" },
    --     { "<leader>nc", "<cmd>Neominimap off<cr>", desc = "Disable global minimap" },
    --     { "<leader>nr", "<cmd>Neominimap refresh<cr>", desc = "Refresh global minimap" },
    --
    --     -- Window-Specific Minimap Controls
    --     { "<leader>nwt", "<cmd>Neominimap winToggle<cr>", desc = "Toggle minimap for current window" },
    --     { "<leader>nwr", "<cmd>Neominimap winRefresh<cr>", desc = "Refresh minimap for current window" },
    --     { "<leader>nwo", "<cmd>Neominimap winOn<cr>", desc = "Enable minimap for current window" },
    --     { "<leader>nwc", "<cmd>Neominimap winOff<cr>", desc = "Disable minimap for current window" },
    --
    --     -- Tab-Specific Minimap Controls
    --     { "<leader>ntt", "<cmd>Neominimap tabToggle<cr>", desc = "Toggle minimap for current tab" },
    --     { "<leader>ntr", "<cmd>Neominimap tabRefresh<cr>", desc = "Refresh minimap for current tab" },
    --     { "<leader>nto", "<cmd>Neominimap tabOn<cr>", desc = "Enable minimap for current tab" },
    --     { "<leader>ntc", "<cmd>Neominimap tabOff<cr>", desc = "Disable minimap for current tab" },
    --
    --     -- Buffer-Specific Minimap Controls
    --     { "<leader>nbt", "<cmd>Neominimap bufToggle<cr>", desc = "Toggle minimap for current buffer" },
    --     { "<leader>nbr", "<cmd>Neominimap bufRefresh<cr>", desc = "Refresh minimap for current buffer" },
    --     { "<leader>nbo", "<cmd>Neominimap bufOn<cr>", desc = "Enable minimap for current buffer" },
    --     { "<leader>nbc", "<cmd>Neominimap bufOff<cr>", desc = "Disable minimap for current buffer" },
    --
    --     ---Focus Controls
    --     { "<leader>nf", "<cmd>Neominimap focus<cr>", desc = "Focus on minimap" },
    --     { "<leader>nu", "<cmd>Neominimap unfocus<cr>", desc = "Unfocus minimap" },
    --     { "<leader>ns", "<cmd>Neominimap toggleFocus<cr>", desc = "Switch focus on minimap" },
    --   },
    --   init = function()
    --     -- The following options are recommended when layout == "float"
    --     vim.opt.wrap = false
    --     vim.opt.sidescrolloff = 36 -- Set a large value
    --
    --     --- Put your configuration here
    --     ---@type Neominimap.UserConfig
    --     vim.g.neominimap = {
    --       auto_enable = true,
    --     }
    --   end,
    -- }

})

-- Apply automatic indentation in BufRead
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*",
    callback = function()
        require('indent-o-matic').detect()
    end,
})
