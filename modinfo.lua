name = "TrapBox-陷阱阵"
version = "1.0"
description = "陷阱阵打包盒. version: "..version
author = "Jeffssss"
api_version = 10
forumthread = ""
icon_atlas = "modicon.xml"
icon = "modicon.tex"
dont_starve_compatible = false
reign_of_giants_compatible = false
dst_compatible = true
client_only_mod = false
all_clients_require_mod = false
priority = 0
configuration_options =
{
	{
		name = "trap_size",
		label = "狗牙阵尺寸",
		options = 
		{
			{description = "3x3", data = 3},
			{description =  "5x5", data = 5},
			{description =  "7x7", data = 7},
		},
		default = 3,
	},
	{
		name = "trap_padding",
		label = "狗牙陷阱间距",
			hover = "陷阱与陷阱之间的距离",
		options =	{
						{description = "0.75", data = 0.75},
						{description = "1", data = 1},
						{description = "1.25", data = 1.25},
						{description = "1.5", data = 1.5},
						{description = "2", data = 2},
					},
		default = 1,
	},
	{
		name = "trap_reset_interval",
		label = "狗牙陷阱恢复间隔",
		options =	{
						{description = "never", data = -1},
						{description = "15", data = 15},
						{description = "30", data = 30},
						{description = "60", data = 60},
						{description = "120", data = 120}
					},
		default = 30,
	},
	{
		name = "rabbit_trap_size",
		label = "陷阱阵尺寸",
		options = 
		{
			{description = "3x3", data = 3},
			{description =  "5x5", data = 5},
			{description =  "7x7", data = 7},
		},
		default = 3,
	},
	{
		name = "rabbit_trap_padding",
		label = "陷阱间距",
			hover = "陷阱与陷阱之间的举例",
		options =	{
						{description = "1", data = 1},
						{description = "1.25", data = 1.25},
						{description = "1.5", data = 1.5},
						{description = "2", data = 2},
						{description = "2.25", data = 2.25},
						{description = "2.5", data = 2.5},
					},
		default = 1,
	}
}