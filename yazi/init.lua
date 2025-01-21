require("full-border"):setup()

require("githead"):setup()

function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		time = ""
	elseif os.date("%Y", time) == os.date("%Y") then
		time = os.date("%b %d %H:%M", time)
	else
		time = os.date("%b %d, %Y", time)
	end

	local size = self._file:size()
	return string.format("%s %s", size and ya.readable_size(size) or "-", time)
end

require("mactag"):setup({
	-- Keys used to add or remove tags
	keys = {
		r = "Red",
		o = "Orange",
		y = "Yellow",
		g = "Green",
		b = "Blue",
		p = "Purple",
	},
	-- Colors used to display tags
	colors = {
		Red = "#ee7b70",
		Orange = "#f5bd5c",
		Yellow = "#fbe764",
		Green = "#91fc87",
		Blue = "#5fa3f8",
		Purple = "#cb88f8",
	},
})

require("relative-motions"):setup({ show_numbers = "relative", show_motion = true })

require("yatline"):setup({
	section_separator = { open = "", close = "" },
	part_separator = { open = "", close = "" },
	-- inverse_separator = { open = "", close = "" },
	inverse_separator = { open = "", close = "" },

	style_a = {
		fg = "black",
		bg_mode = {
			normal = "blue",
			select = "brightyellow",
			un_set = "magenta",
		},
	},
	style_b = { bg = "#463465", fg = "#72f1b8" },
	style_c = { bg = "#251c2e", fg = "#ff00ff" },

	permissions_t_fg = "green",
	permissions_r_fg = "yellow",
	permissions_w_fg = "red",
	permissions_x_fg = "cyan",
	permissions_s_fg = "white",

	tab_width = 20,
	tab_use_inverse = false,

	selected = { icon = "󰻭", fg = "yellow" },
	copied = { icon = "", fg = "green" },
	cut = { icon = "", fg = "red" },

	total = { icon = "󰮍", fg = "yellow" },
	succ = { icon = "", fg = "green" },
	fail = { icon = "", fg = "red" },
	found = { icon = "󰮕", fg = "blue" },
	processed = { icon = "󰐍", fg = "green" },

	show_background = false,

	display_header_line = true,
	display_status_line = true,

	component_positions = { "header", "tab", "status" },

	header_line = {
		left = {
			section_a = {
				{ type = "line", custom = false, name = "tabs", params = { "left" } },
			},
			section_b = {},
			section_c = {},
		},
		right = {
			section_a = {
				{
					type = "string",
					custom = true,
					name = "󱙧               󱙧 ",
				},
			},
			section_b = {
				{ type = "coloreds", custom = false, name = "githead" },
			},
			section_c = {},
		},
	},

	status_line = {
		left = {
			section_a = {
				{ type = "string", custom = false, name = "tab_mode" },
			},
			section_b = {
				{ type = "string", custom = false, name = "hovered_size" },
			},
			section_c = {
				{ type = "string", custom = false, name = "hovered_path" },
				{ type = "coloreds", custom = false, name = "count" },
			},
		},
		right = {
			section_a = {
				{ type = "string", custom = false, name = "cursor_position" },
			},
			section_b = {
				{ type = "string", custom = false, name = "cursor_percentage" },
			},
			section_c = {
				{ type = "string", custom = false, name = "hovered_file_extension", params = { true } },
				{ type = "coloreds", custom = false, name = "permissions" },
			},
		},
	},
})

require("yatline-githead"):setup({
	show_branch = true,
	branch_prefix = "",
	branch_symbol = "",
	branch_borders = "",

	commit_symbol = " ",

	show_behind_ahead = true,
	behind_symbol = " ",
	ahead_symbol = " ",

	show_stashes = true,
	stashes_symbol = " ",

	show_state = true,
	show_state_prefix = true,
	state_symbol = "󱅉",

	show_staged = true,
	staged_symbol = " ",

	show_unstaged = true,
	unstaged_symbol = " ",

	show_untracked = true,
	untracked_symbol = " ",

	prefix_color = "#ff00ff",
	branch_color = "#e5fe5d",
	commit_color = "#00ffff",
	stashes_color = "#97e736",
	state_color = "#abf3fd",
	staged_color = "#72f1b8",
	unstaged_color = "#fede5d",
	untracked_color = "#ff00ff",
	ahead_color = "#72f1b8",
	behind_color = "#ff8b39",
})

require("zoxide"):setup({
	update_db = true,
})
