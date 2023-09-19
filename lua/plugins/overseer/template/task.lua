-- tasks.lua

local M = {}

M.tasks = {
	{
		name = "npm install",
		type = "npm",
		script = "install",
		options = {
			cwd = "./frontend",
		},
		presentation = {
			clear = true,
			panel = "shared",
			showReuseMessage = false,
		},
		problemMatcher = {},
	},
	{
		name = "npm run build",
		type = "npm",
		script = "build",
		options = {
			cwd = "./frontend",
		},
		presentation = {
			clear = true,
			panel = "shared",
			showReuseMessage = false,
		},
		problemMatcher = {},
	},
	{
		name = "build",
		type = "shell",
		options = {
			cwd = "./",
		},
		command = "go",
		args = {
			"build",
			"-tags",
			"dev",
			"-gcflags",
			"all=-N -l",
			"-o",
			"build/bin/vscode.exe",
		},
		dependsOn = { "npm install", "npm run build" },
	},
}

return M
