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
	  config = function ()
	    require("copilot_cmp").setup()
	  end
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
				"<leader>cp",
				function()
					local chat = require("CopilotChat")
					chat.reset()
					-- chat.open({ selection = require("CopilotChat.select").buffers })
					chat.open()
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
			clear_chat_on_new_prompt = false,
			context = "buffers",
			window = {
				layout = "float", -- 'vertical', 'horizontal', 'float', 'replace'
				width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
				height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
				-- Options below only apply to floating windows
				relative = "editor", -- 'editor', 'win', 'cursor', 'mouse'
				border = "single", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
				row = nil, -- row position of the window, default is centered
				col = nil, -- column position of the window, default is centered
				title = "Copilot Chat", -- title of chat window
				footer = nil, -- footer of chat window
				zindex = 1, -- determines if window is on top or below other floating windows
			},
		},
		-- See Commands section for default commands if you want to lazy load on them
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
		},
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
        "ruff"
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

	{
		"sindrets/diffview.nvim",
		keys = {
			{ "d", mode = "n", desc = "Open diffview" },
		},
		init = function()
			require("core.utils").load_mappings("diffview")
		end,
		opts = {
			view = {
				merge_tool = {
					layout = "diff4_mixed",
				},
			},
		},
	},

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
}

return plugins
