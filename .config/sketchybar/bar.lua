local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
	topmost = "window",
	height = 32,
	color = colors.bar.bg,
	padding_right = 2,
	padding_left = 2,
})
