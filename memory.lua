-------------------------------------------------
-- Memory widget
-------------------------------------------------

local wibox = require("wibox")
local watch = require("awful.widget.watch")

local text = wibox.widget{
    font = "Hack 12",
    widget = wibox.widget.textbox,
}

local widget = wibox.widget.background()
widget:set_widget(text)

watch("free -m", 10, function(widget, stdout, stderr, exitreason, exitcode)
        local raw = string.match(stdout, "%d+%s+%d+")
        local strip_raw = string.match(raw, "%s+%d+")
        local free = string.match(strip_raw, "%d+")

        text:set_text("me: "..free)
    end,
    widget
    )

return widget
