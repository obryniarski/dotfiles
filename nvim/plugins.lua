local plugins = {

	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",

		opts = function()
			return require("custom.configs.copilot")
		end,
		config = function(_, opts)
			require("copilot").setup(opts)

			vim.keymap.set("i", "<Tab>", function()
				if require("copilot.suggestion").is_visible() then
					require("copilot.suggestion").accept()
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
				end
			end, {
				silent = true,
			})
		end,
	},

	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		lazy = false,
		keys = {
			-- {
			--    "<leader>cp",
			--    function()
			--      local input = vim.fn.input("Quick Chat: ")
			--      if input ~= "" then
			--        require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
			--      end
			--    end,
			--    desc = "CopilotChat - Quick chat",
			--  },
			{
				"cp",
				mode = "v",
				function()
					local chat = require("CopilotChat")
					chat.reset()
					-- Yank the selected text into the "v" register
					vim.cmd('normal! "vy')
					local selected_text = vim.fn.getreg("v")
					vim.ui.input({ prompt = "Enter your question: " }, function(input)
						if input then
							-- chat.ask(input, { selection = require("CopilotChat.select").buffers })
							local prompt = "Use this context for the following command:\n\n"
								.. selected_text
								.. "\n\nCommand:\n\n"
								.. input
							chat.ask(prompt)
						end
					end)
				end,
				desc = "CopilotChat - Chat with selected text and buffers",
			},

			{
				"<leader>cp",
				function()
					local chat = require("CopilotChat")
					chat.reset()
					chat.open()
				end,
				desc = "CopilotChat - Quick chat",
			},
			{
				"<leader>cp",
				function()
					local chat = require("CopilotChat")
					chat.reset()
					chat.open({ selection = require("CopilotChat.select").buffers })
				end,
				desc = "CopilotChat - Quick chat",
			},
			{
				"<leader>ct",
				function()
					require("CopilotChat").toggle()
				end,
				desc = "CopilotChat - Toggle window",
			},
		},

		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			debug = false, -- Enable debugging
			temperature = 0.3,
			clear_chat_on_new_prompt = false,
			context = "buffers",
			window = {
				layout = "float", -- 'vertical', 'horizontal', 'float', 'replace'
				width = 0.7, -- fractional width of parent, or absolute width in columns when > 1
				height = 0.7, -- fractional height of parent, or absolute height in rows when > 1
				-- Options below only apply to floating windows
				relative = "editor", -- 'editor', 'win', 'cursor', 'mouse'
				border = "rounded", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
				row = nil, -- row position of the window, default is centered
				col = nil, -- column position of the window, default is centered
				title = "ai bullshit", -- title of chat window
				footer = nil, -- footer of chat window
				zindex = 1, -- determines if window is on top or below other floating windows
			},
		},
	},

	{
		"hrsh7th/nvim-cmp",
		opts = function()
			return require("custom.configs.cmp")
		end,
		config = function(_, opts)
			require("cmp").setup(opts)
		end,
	},

	{
		"onsails/lspkind.nvim",
	},

	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},

	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"css",
				"dockerfile",
				"html",
				"javascript",
				"json",
				"jsonc",
				"lua",
				"python",
				"regex",
				"rust",
				"scss",
				"toml",
				"typescript",
				"yaml",
				"vimdoc",
				"markdown",
				"diff",
			},

			textobjects = {

				-- keymaps are defined in init.lua
				swap = {
					enable = true,
				},

				select = {
					enable = true,

					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,

					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["ap"] = "@parameter.outer",
						["ip"] = "@parameter.inner",
						-- You can also use captures from other query groups like `locals.scm`
						["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
					},
					-- You can choose the select mode (default is charwise 'v')
					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@function.outer"] = "V", -- linewise
						["@class.outer"] = "V", -- linewise
					},
				},
			},
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
	},

	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"lua-language-server",
				"pyright",
				"rust-analyzer",
				"shfmt",
				"rustfmt",
				"isort",
				"ruff",
			},
		},
	},

	{
		"williamboman/mason-lspconfig.nvim",
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},

	{
		"hrsh7th/cmp-nvim-lsp",
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		opts = function()
			return require("custom.configs.telescope")
		end,
	},

	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		config = function()
			require("custom.configs.conform")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		lazy = false,
		config = function()
			require("custom.configs.treesittercontext")
		end,
	},

	-- disable autopairs, I don't like it
	{
		"windwp/nvim-autopairs",
		enabled = false,
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			messages = {
				enabled = false,
			},
			notify = {
				enabled = false,
			},
      lsp = {
        hover = {
            enabled = false
          },
        signature = {
          enabled = false
        },
      },
			views = {
				cmdline_popup = {
					position = {
						row = "95%", -- Adjust the row position (use percentage or absolute values)
						col = "50%", -- Adjust the column position (use percentage or absolute values)
					},
					size = {
						width = 60, -- Set the width of the popup
						height = "auto", -- Set the height (or you can provide a specific number)
					},
					border = {
						style = "rounded", -- Optional: set a border style (e.g., "rounded", "double", "none")
					},
					win_options = {
						wrap = true, -- Enable wrapping
						scrolloff = 0, -- Disable scroll offset to see the newest text
					},
				},
			},
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
		},
	},

	-- {
	-- 	"sindrets/diffview.nvim",
	-- 	keys = {
	-- 		{ "d", mode = "n", desc = "Open diffview" },
	-- 	},
	-- 	init = function()
	-- 		require("core.utils").load_mappings("diffview")
	-- 	end,
	-- 	opts = {
	-- 		view = {
	-- 			merge_tool = {
	-- 				layout = "diff4_mixed",
	-- 			},
	-- 		},
	-- 	},
	-- },

	-- adds <leader>gy command to copy current line github link
	{
		"ruifm/gitlinker.nvim",
		keys = {
			{ "<leader>gy", mode = "n", desc = "Yank git link" },
		},
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			-- config here: https://github.com/ruifm/gitlinker.nvim?tab=readme-ov-file#configuration
			require("gitlinker").setup({})
		end,
	},

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	-- make csv a bit easier to read in nvim
	{
		"cameron-wags/rainbow_csv.nvim",
		config = true,
		ft = {
			"csv",
			"tsv",
			"csv_semicolon",
			"csv_whitespace",
			"csv_pipe",
			"rfc_csv",
			"rfc_semicolon",
		},
		cmd = {
			"RainbowDelim",
			"RainbowDelimSimple",
			"RainbowDelimQuoted",
			"RainbowMultiDelim",
		},
	},

	-- movement
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			-- labels = "asdfghjklqwertyuiopzxcvbnm",
			labels = "nrtsgyhaei", -- updated based on my graphite keyboard layout
			highlight = {
				backdrop = false,
				groups = { backdrop = "" },
			},
		},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter( { labels = "nrtsgyhaei" }) end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
	},
}

return plugins
