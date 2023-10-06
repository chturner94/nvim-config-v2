return {
	-- refactoring
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("refactoring").setup({
				prompt_func_return_type = {
					go = true,
					java = true,

					cpp = true,
					c = true,
					h = true,
					hpp = true,
					cxx = true,
				},
				prompt_func_param_type = {
					go = true,
					java = true,

					cpp = true,
					c = true,
					h = true,
					hpp = true,
					cxx = true,
				},
				printf_statements = {},
				print_var_statements = {},
			})
		end,
		keys = {
			{ "<leader>re", ":Refactor extract ", "x", desc = "Extract" },
			{ "<leader>rf", ":Refactor extract_to_file ", "x", desc = "Extract to file" },
			{ "<leader>rv", ":Refactor extract_var", "x", desc = "Extract variable" },
			{ "<leader>ri", ":Refactor inline_var", { "x", "n" }, desc = "Extract inline-variable" },
			{ "<leader>rI", ":Refactor inline_func", desc = "Extract inline-function" },
			{ "<leader>rb", ":Refactor extract_block", desc = "Extract block" },
			{ "<leader>rbf", ":Refactor extract_block_to_file", desc = "Extract block to file" },
		},
	},
	-- which key integration
	{
		"folke/which-key.nvim",
		optional = true,
		opts = {
			defaults = {
				["<leader>r"] = { name = "+refactor" },
			},
		},
	},
	-- snippets
	{
		"L3MON4D3/LuaSnip",
		build = (not jit.os:find("Windows"))
				and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
			or nil,
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
    -- stylua: ignore
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
	},
	-- auto-completion
	{
		"hrsh7th/nvim-cmp",
		version = false, -- last release is way too old
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
		opts = function()
			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
			local cmp = require("cmp")
			local defaults = require("cmp.config.default")()
			return {
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explidcitly selected items.

					["<S-CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				formatting = {
					format = function(_, item)
						local icons = require("config").defaults.icons.kinds
						if icons[item.kind] then
							item.kind = icons[item.kind] .. item.kind
						end
						return item
					end,
				},
				experimental = {
					ghost_text = {
						hl_group = "CmpGhostText",
					},
				},
				sorting = defaults.sorting,
			}
		end,
	},
	-- auto pairs
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {},
	},

	-- Fast and feature-rich surround actions. For text that includes
	-- surrounding characters like brackets or quotes, this allows you
	-- to select the text inside, change or modify the surrounding characters,
	-- and more.
	{
		"echasnovski/mini.surround",
		keys = function(_, keys)
			-- Populate the keys based on the user's options
			local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
			local opts = require("lazy.core.plugin").values(plugin, "opts", false)
			local mappings = {
				{ opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
				{ opts.mappings.delete, desc = "Delete surrounding" },
				{ opts.mappings.find, desc = "Find right surrounding" },
				{ opts.mappings.find_left, desc = "Find left surrounding" },
				{ opts.mappings.highlight, desc = "Highlight surrounding" },
				{ opts.mappings.replace, desc = "Replace surrounding" },
				{ opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
			}
			mappings = vim.tbl_filter(function(m)
				return m[1] and #m[1] > 0
			end, mappings)
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			mappings = {
				add = "gza", -- Add surrounding in Normal and Visual modes
				delete = "gzd", -- Delete surrounding
				find = "gzf", -- Find surrounding (to the right)
				find_left = "gzF", -- Find surrounding (to the left)
				highlight = "gzh", -- Highlight surrounding
				replace = "gzr", -- Replace surrounding
				update_n_lines = "gzn", -- Update `n_lines`
			},
		},
	},

	-- comments
	{ "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
			},
		},
	},

	-- Better text-objects
	{
		"echasnovski/mini.ai",
		-- keys = {
		--   { "a", mode = { "x", "o" } },
		--   { "i", mode = { "x", "o" } },
		-- },
		event = "VeryLazy",
		dependencies = { "nvim-treesitter-textobjects" },
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
				},
			}
		end,
		config = function(_, opts)
			require("mini.ai").setup(opts)
			-- register all text objects with which-key
			require("utils").on_load("which-key.nvim", function()
				---@type table<string, string|table>
				local i = {
					[" "] = "Whitespace",
					['"'] = 'Balanced "',
					["'"] = "Balanced '",
					["`"] = "Balanced `",
					["("] = "Balanced (",
					[")"] = "Balanced ) including white-space",
					[">"] = "Balanced > including white-space",
					["<lt>"] = "Balanced <",
					["]"] = "Balanced ] including white-space",
					["["] = "Balanced [",
					["}"] = "Balanced } including white-space",
					["{"] = "Balanced {",
					["?"] = "User Prompt",
					_ = "Underscore",
					a = "Argument",
					b = "Balanced ), ], }",
					c = "Class",
					f = "Function",
					o = "Block, conditional, loop",
					q = "Quote `, \", '",
					t = "Tag",
				}
				local a = vim.deepcopy(i)
				for k, v in pairs(a) do
					a[k] = v:gsub(" including.*", "")
				end

				local ic = vim.deepcopy(i)
				local ac = vim.deepcopy(a)
				for key, name in pairs({ n = "Next", l = "Last" }) do
					i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
					a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
				end
				require("which-key").register({
					mode = { "o", "x" },
					i = i,
					a = a,
				})
			end)
		end,
	},
	-- copilot
	--[[{
		"zbirenbaum/copilot.lua",j
		cmd = "Copilot",
		build = ":Copilot auth",
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
			filetypes = {
				markdown = true,
				help = true,
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		optional = true,
		event = "VeryLazy",
		opts = function(_, opts)
			local Util = require("utils")
			local colors = {
				[""] = Util.fg("Special"),
				["Normal"] = Util.fg("Special"),
				["Warning"] = Util.fg("DiagnosticError"),
				["InProgress"] = Util.fg("DiagnosticWarn"),
			}
			require("utils").on_load("lualine", ModifyLualine)
			function ModifyLualine()
				table.insert(opts.section.lualine_x, 2, {
					function()
						local icon = require("config").defaults.icons.kinds.Copilot
						local status = require("copilot.api").status.data
						return icon .. (status.message or "")
					end,
					cond = function()
						local ok, clients = pcall(vim.lsp.get_active_clients, { name = "copilot", bufnr = 0 })
						return ok and #clients > 0
					end,
					color = function()
						if not package.loaded["copilot"] then
							return
						end
						local status = require("copilot.api").status.data
						return colors[status.status] or colors[""]
					end,
				})
			end
		end,
	},
	-- copilot cmp source
	{
		"nvim-cmp",
		dependencies = {
			{
				"zbirenbaum/copilot-cmp",
				dependencies = "copilot.lua",
				opts = {},
				config = function(_, opts)
					local copilot_cmp = require("copilot_cmp")
					copilot_cmp.setup(opts)
					-- attach cmp source whenever copilot attaches
					-- fixes lazy-loading issues with the copilot cmp source
					require("utils").on_attach(function(client)
						if client.name == "copilot" then
							copilot_cmp._on_insert_enter({})
						end
					end)
				end,
			},
		},
		---@param opts cmp.ConfigSchema
		opts = function(_, opts)
			table.insert(opts.sources, 1, { name = "copilot", group_index = 2 })
			opts.sorting = opts.sorting or require("cmp.config.default")().sorting
			table.insert(opts.sorting.comparators, 1, require("copilot_cmp.comparators").prioritize)
		end,
	},
    --]]
}
