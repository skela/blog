---
date: 2024-01-14 10:27
description: Using an alternative formatter for dart.
id: Custom Formatter for dart
tags: dart, formatters, nvim, blink, editorconfig
---

First thing I always do when setting up any new dart project is to make sure the default formatter baked in to the SDK is disabled.
This is because the built in formatter offers nothing in the way of customization, you are in other words stuck with awful unreadable code indented with spaces.

So what is someone who still thinks code should always be indented with tabs, or prefers the Allman style, to do about that?

### Meet blink

Well, I have been working on my own dart code formatter, [blink](https://github.com/skela/blink), the world's first customizable dart code formatter. Now its still not ready, but we do use it from time to time.
My goal is to build a dart code formatter that's customizable via [EditorConfig](https://editorconfig.org/) files.

### Using blink

I was never able to figure out how to use my own code formatter for dart back when i was using VSCode, but now that I use [nvim](https://neovim.io/) that might be different.
Turns out yes, its a lot easier to do this sort of stuff using nvim, infact it took me only 5 minutes to get it up and running, including format on save!

```
{
	"stevearc/conform.nvim",
	optional = true,
	opts = {
		formatters_by_ft = {
			["dart"] = { "blink" },
		},
		formatters = {
			blink = {
				command = "/home/skela/code/blink/target/release/blink",
				args = { "$FILENAME" },
				stdin = false,
				cwd = require("conform.util").root_file({ ".editorconfig", "Pubspec.yaml" }),
			},
		},
	},
},
```

### EditorConfig

I've got this snippet below added to my `.editorconfig` file. blink looks for an .editorconfig in your code repo and your home directory.

```
[*.dart]
indent_style = tab
indent_size = 2
curly_bracket_next_line = true
trim_trailing_whitespace = true
```
