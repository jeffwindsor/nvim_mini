-- Clone 'mini.nvim manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/echasnovski/mini.nvim",
        mini_path,
    }
    vim.fn.system(clone_cmd)
    vim.cmd("packadd mini.nvim | helptags ALL")
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
    vim.g.mapleader = " "
    vim.o.backup = false
    vim.o.number = true
    vim.o.relativenumber = true
    vim.o.laststatus = 2
    vim.o.list = true
    vim.o.listchars = table.concat({ "extends:…", "nbsp:␣", "precedes:…", "tab:> " }, ",")
    vim.o.autoindent = true
    vim.o.shiftwidth = 4
    vim.o.tabstop = 4
    vim.o.expandtab = true
    vim.o.scrolloff = 10
    vim.o.clipboard = "unnamed,unnamedplus"
    vim.opt.iskeyword:append("-")
    vim.o.spelllang = "de,en"
    vim.o.spelloptions = "camel"
    vim.opt.complete:append("kspell")

    vim.cmd("filetype plugin indent on")
    vim.cmd("colorscheme randomhue")
end)

now(function()
    if vim.g.neovide then
        vim.g.neovide_scroll_animation_length = 0.1
        vim.opt.mousescroll = "ver:10,hor:6"
        vim.g.neovide_theme = "light"

        vim.g.neovide_floating_shadow = true
        vim.g.neovide_floating_z_height = 2
        vim.g.neovide_light_angle_degrees = 45
        vim.g.neovide_light_radius = 15

        vim.g.neovide_floating_blur_amount_x = 10.0
        vim.g.neovide_floating_blur_amount_y = 10.0

        -- vim.g.neovide_transparency = 0.9
        -- vim.g.neovide_window_blurred = true

        vim.o.guicursor =
        "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait100-blinkoff700-blinkon700-Cursor/lCursor,sm:block-blinkwait0-blinkoff300-blinkon300"
        vim.g.neovide_cursor_animation_length = 0.03
        vim.g.neovide_cursor_smooth_blink = true
        vim.g.neovide_cursor_vfx_mode = "pixiedust"
    end
end)

later(function()
    require("mini.align").setup()
end)
later(function()
    -- This is needed for mini.animate to work with mouse scrolling
    local animate = require("mini.animate")
    animate.setup({
        scroll = {
            -- Disable Scroll Animations, as the can interfer with mouse Scrolling
            enable = false,
        },
        cursor = {
            timing = animate.gen_timing.cubic({ duration = 50, unit = "total" }),
        },
    })
end)
-- Disabled Here. This is called directly from our Colorscheme in the colors/ folder
-- You can enable this by uncommenting.
-- We provide a basic Catppuccin Colorscheme here
-- later(function()
--     require('mini.base16').setup({
--         palette = {
--             base00 = '#1e1e2e',
--             base01 = '#181825',
--             base02 = '#313244',
--             base03 = '#45475a',
--             base04 = '#585b70',
--             base05 = '#cdd6f4',
--             base06 = '#f5e0dc',
--             base07 = '#b4befe',
--             base08 = '#f38ba8',
--             base09 = '#fab387',
--             base0A = '#f9e2af',
--             base0B = '#a6e3a1',
--             base0C = '#94e2d5',
--             base0D = '#89b4fa',
--             base0E = '#cba6f7',
--             base0F = '#f2cdcd'
--         }
--     })
-- end)
later(function()
    require("mini.basics").setup({
        options = {
            basic = true,
            extra_ui = true,
            win_borders = "bold",
        },
        mappings = {
            basic = true,
            windows = true,
        },
        autocommands = {
            basic = true,
            relnum_in_visual_mode = true,
        },
    })
end)
later(function()
    require("mini.bracketed").setup()
end)
later(function()
    require("mini.bufremove").setup()
end)
later(function()
    require("mini.clue").setup({
        triggers = {
            -- Leader triggers
            { mode = "n", keys = "<Leader>" },
            { mode = "x", keys = "<Leader>" },

            { mode = "n", keys = "\\" },

            -- Built-in completion
            { mode = "i", keys = "<C-x>" },

            -- `g` key
            { mode = "n", keys = "g" },
            { mode = "x", keys = "g" },

            -- Marks
            { mode = "n", keys = "'" },
            { mode = "n", keys = "`" },
            { mode = "x", keys = "'" },
            { mode = "x", keys = "`" },

            -- Registers
            { mode = "n", keys = '"' },
            { mode = "x", keys = '"' },
            { mode = "i", keys = "<C-r>" },
            { mode = "c", keys = "<C-r>" },

            -- Window commands
            { mode = "n", keys = "<C-w>" },

            -- `z` key
            { mode = "n", keys = "z" },
            { mode = "x", keys = "z" },
        },

        clues = {
            { mode = "n", keys = "<Leader>b", desc = " Buffer" },
            { mode = "n", keys = "<Leader>f", desc = " Find" },
            { mode = "n", keys = "<Leader>g", desc = "󰊢 Git" },
            { mode = "n", keys = "<Leader>i", desc = "󰏪 Insert" },
            { mode = "n", keys = "<Leader>l", desc = "󰘦 LSP" },
            { mode = "n", keys = "<Leader>q", desc = " NVim" },
            { mode = "n", keys = "<Leader>s", desc = "󰆓 Session" },
            { mode = "n", keys = "<Leader>u", desc = "󰔃 UI" },
            { mode = "n", keys = "<Leader>w", desc = " Window" },
            require("mini.clue").gen_clues.g(),
            require("mini.clue").gen_clues.builtin_completion(),
            require("mini.clue").gen_clues.marks(),
            require("mini.clue").gen_clues.registers(),
            require("mini.clue").gen_clues.windows(),
            require("mini.clue").gen_clues.z(),
        },
        window = {
            delay = 300,
        },
    })
end)
-- later(function() require('mini.colors').setup() end)
later(function()
    require("mini.comment").setup()
end)
later(function()
    require("mini.completion").setup({
        mappings = {
            go_in = "<RET>",
        },
        window = {
            info = { border = "rounded" },
            signature = { border = "rounded" },
        },
    })
end)
later(function()
    require("mini.cursorword").setup()
end)
later(function()
    require("mini.diff").setup({
        view = {
            style = "sign",
            signs = { add = "█", change = "▒", delete = "" },
        },
    })
end)
later(function()
    require("mini.doc").setup()
end)
later(function()
    require("mini.extra").setup()
end)
later(function()
    require("mini.files").setup({
        windows = {
            preview = true,
            width_preview = 80,
        },
    })
end)
later(function()
    require("mini.fuzzy").setup()
end)
later(function()
    require("mini.git").setup()
end)
now(function()
    local hipatterns = require("mini.hipatterns")

    local censor_extmark_opts = function(_, match, _)
        local mask = string.rep("*", vim.fn.strchars(match))
        return {
            virt_text = { { mask, "Comment" } },
            virt_text_pos = "overlay",
            priority = 200,
            right_gravity = false,
        }
    end

    local password_table = {
        pattern = {
            "password: ()%S+()",
            "password_usr: ()%S+()",
            ".*_pw: ()%S+()",
            "password_.*: ()%S+()",
            "gpg_pass: ()%S+()",
            "passwd: ()%S+()",
        },
        group = "",
        extmark_opts = censor_extmark_opts,
    }
    -- TODO Make the "mask" Text a variale based on the match
    local mattern_tbl = {
        "'.*bakup_path:", "Rollout new Backup",
        "'.*base_pw:", "base_pw is deprecated",
    }

    local mattern_extmark_opts = function(_, match, _)
        local mask = mattern_tbl[match]
        if mask == nil then
            mask = "No Pattern"
        end
        return {
            virt_text = { { mask, "FoldColumn" } },
            virt_text_pos = "eol",
            priority = 199,
            right_gravity = true,
        }
    end

    local mattern = {
        pattern = {
            ".*backup_path:",
            ".*base_pw:",
        },
        group = "MiniHipatternsNote",
        extmark_opts = mattern_extmark_opts,
    }
    hipatterns.setup({
        highlighters = {
            -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
            fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
            hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
            todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
            note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

            -- Cloaking Passwords
            pw = password_table,
            -- mattern = mattern,

            -- Highlight hex color strings (`#rrggbb`) using that color
            hex_color = hipatterns.gen_highlighter.hex_color(),
        },
    })

    vim.keymap.set("n", "<leader>up", function()
        if next(hipatterns.config.highlighters.pw) == nil then
            hipatterns.config.highlighters.pw = password_table
        else
            hipatterns.config.highlighters.pw = {}
        end
        vim.cmd("edit")
    end, { desc = "Toggle Password Cloaking" })
end)
-- We disable this, as we use the randomhue Colorscheme
-- You can enable this by uncommenting
-- We Provide a Modus Operandi inspired setup here
-- later(function()
--     require('mini.hues').setup({
--         background = '#fbf7f0',
--         foreground = '#000000',
--         n_hues     = 8,
--         accent     = 'bg',
--         saturation = 'high'
--     })
-- end)
later(function()
    require("mini.icons").setup()
end)
later(function()
    require("mini.indentscope").setup({
        draw = {
            animation = function()
                return 1
            end,
        },
        symbol = "│",
    })
end)
later(function()
    require("mini.jump").setup()
end)
later(function()
    require("mini.jump2d").setup()
end)
later(function()
    require("mini.map").setup()
end)
later(function()
    require("mini.misc").setup()
end)
later(function()
    require("mini.move").setup({})
end)
later(function()
    -- We took this from echasnovski's personal configuration
    -- https://github.com/echasnovski/nvim/blob/master/init.lua
    local filterout_lua_diagnosing = function(notif_arr)
        local not_diagnosing = function(notif)
            return not vim.startswith(notif.msg, "lua_ls: Diagnosing")
        end
        notif_arr = vim.tbl_filter(not_diagnosing, notif_arr)
        return MiniNotify.default_sort(notif_arr)
    end
    require("mini.notify").setup({
        content = { sort = filterout_lua_diagnosing },
        window = { config = { border = "double" } },
    })
    -- vim.notify = MiniNotify.make_notify()
end)
later(function()
    require("mini.operators").setup()
end)
later(function()
    require("mini.pairs").setup()
end)
later(function()
    local win_config = function()
        local height = math.floor(0.618 * vim.o.lines)
        local width = math.floor(0.618 * vim.o.columns)
        return {
            anchor = "NW",
            height = height,
            width = width,
            border = "rounded",
            row = math.floor(0.5 * (vim.o.lines - height)),
            col = math.floor(0.5 * (vim.o.columns - width)),
        }
    end
    require("mini.pick").setup({
        mappings = {
            choose_in_vsplit = "<C-CR>",
        },
        options = {
            use_cache = true,
        },
        window = {
            config = win_config,
        },
    })
    vim.ui.select = MiniPick.ui_select
end)
now(function()
    require("mini.sessions").setup({
        autowrite = true,
    })
end)
later(function()
    require("mini.splitjoin").setup()
end)
now(function()
    Mvim_starter_custom = function()
        return {
            { name = "Recent Files", action = function() require("mini.extra").pickers.oldfiles() end, section = "Search" },
            { name = "Session", action = function() require("mini.sessions").select() end, section = "Search" },
        }
    end
    require("mini.starter").setup({
        autoopen = true,
        items = {
            -- require("mini.starter").sections.builtin_actions(),
            Mvim_starter_custom(),
            require("mini.starter").sections.recent_files(5, false, false),
            require("mini.starter").sections.recent_files(5, true, false),
            require("mini.starter").sections.sessions(5, true),
        },
        header = [[
╔═════════════════════╗
║                     ║
║     ╔╦╗┬  ┬┬╔╦╗     ║
║     ║║║└┐┌┘│║║║     ║
║     ╩ ╩ └┘ ┴╩ ╩     ║
║                     ║
╚═════════════════════╝
        ]]
        -- header = [[
        --         ███╗   ███╗██╗   ██╗██╗███╗   ███╗
        --         ████╗ ████║██║   ██║██║████╗ ████║
        --         ██╔████╔██║██║   ██║██║██╔████╔██║
        --         ██║╚██╔╝██║╚██╗ ██╔╝██║██║╚██╔╝██║
        --         ██║ ╚═╝ ██║ ╚████╔╝ ██║██║ ╚═╝ ██║
        --         ██║     ██║  ╚═══╝  ╚═╝██║     ██║
        --         ██║     ██║ini      nvi██║     ██║
        --         ╚═╝     ╚═╝            ╚═╝     ╚═╝]],
    })
end)
later(function()
    require("mini.statusline").setup({
        use_icons = true,
    })
end)
later(function()
    require("mini.surround").setup()
end)
later(function()
    require("mini.tabline").setup()
end)
later(function()
    require("mini.trailspace").setup()
end)
later(function()
    require("mini.visits").setup()
end)

require("autocmds")
require("filetypes")
require("highlights")
require("keybinds")

later(function()
    add("domsch1988/mattern.nvim")

    require('mattern').setup({
        markers = {
            { { [[base_pw:]] },                              'base_pw is deprecated! Replace with root_pw', "Error",             "yaml" },
            {
                {
                    [[version_string:]],
                    [[evd_stereo:]],
                    [[start_acs:]],
                    [[copy_script_config:]],
                    [[wait_before_install:]],
                    [[release:]],
                    [[asgard_logging_path:]],
                    [[evd_logging_path:]]
                },
                'This Variable is potentially unused',
                "MiniHipatternsNote"
            },
            { { [[asgard_backup_path:]] },                   'Rollout New Backup!',                         "@comment.error",    "yaml" },
            { { [[evd_backup_path:]] },                      'Rollout New Backup!',                         "@comment.error",    "yaml" },
        }
    })

    vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" },
        { callback = function() require("mattern").mattern_print() end })
end)

later(function()
    local ts_spec = {
        source = "nvim-treesitter/nvim-treesitter",
        checkout = "master",
        hooks = {
            post_checkout = function()
                vim.cmd("TSUpdate")
            end,
        },
    }
    add({ source = "nvim-treesitter/nvim-treesitter-textobjects", depends = { ts_spec } })
    local ensure_installed = {
        "bash",
        "css",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "yaml",
        "vim",
        "vimdoc",
    }

    require("nvim-treesitter.configs").setup({
        ensure_installed = ensure_installed,
        highlight = { enable = true },
        incremental_selection = { enable = false },
        textobjects = { enable = false },
        indent = { enable = false },
    })

    -- Disable injections in 'lua' language. In Neovim<0.9 it is
    -- `vim.treesitter.query.set_query()`; in Neovim>=0.9 it is
    -- `vim.treesitter.query.set()`.
    local ts_query = require("vim.treesitter.query")
    local ts_query_set = ts_query.set or ts_query.set_query
    ts_query_set("lua", "injections", "")
end)

-- Install LSP/formatting/linter executables
later(function()
    add("williamboman/mason.nvim")
    require("mason").setup()
end)

-- Formatting
later(function()
    add("stevearc/conform.nvim")
    require("conform").setup({
        -- Map of filetype to formatters
        formatters_by_ft = {
            javascript = { "prettier" },
            json = { "prettier" },
            lua = { "stylua" },
            python = { "black" },
            r = { "my_styler" },
        },

        formatters = {
            my_styler = {
                command = "R",
                -- A list of strings, or a function that returns a list of strings
                -- Return a single string instead of a list to run the command in a shell
                args = { "-s", "-e", "styler::style_file(commandArgs(TRUE)[1])", "--args", "$FILENAME" },
                stdin = false,
            },
        },
    })
end)

-- Language server configurations
later(function()
    add("neovim/nvim-lspconfig")
end)

later(function()
    add("williamboman/mason-lspconfig")
    require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ansiblels", "pyright", "efm" },
    })
    require("lspconfig").lua_ls.setup({
        on_init = function(client)
            local path = client.workspace_folders[1].name
            if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
                return
            end

            client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                runtime = {
                    -- Tell the language server which version of Lua you're using
                    -- (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                },
                -- Make the server aware of Neovim runtime files
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                        -- Depending on the usage, you might want to add additional paths here.
                        -- "${3rd}/luv/library"
                        -- "${3rd}/busted/library",
                    },
                    -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                    -- library = vim.api.nvim_get_runtime_file("", true)
                },
            })
        end,
        settings = {
            Lua = {},
        },
    })

    -- require('lspconfig').efm.setup {
    --     init_options = { documentFormatting = false },
    --     filetypes = { 'yaml' },
    --     settings = {
    --         rootMarkers = { ".git/" },
    --         languages = {
    --             yaml = {
    --                 {
    --                     lintCommand = 'python3.11 /home/dosa/Development/dosa-lint/dosa-lint.py',
    --                     lintFormats = { '%f:%l:%c: %m' },
    --                     lintStdin = true
    --                 }
    --             }
    --         }
    --     }
    -- }

    require("lspconfig").ansiblels.setup({
        filetypes = {
            "yaml",
        },
        settings = {
            ansible = {
                validation = {
                    lint = {
                        arguments = "-c ~/.config/ansible-lint.yml",
                    },
                },
            },
        },
    })
end)
