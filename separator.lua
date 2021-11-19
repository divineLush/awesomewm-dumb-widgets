-------------------------------------------------
-- Separator widget
-------------------------------------------------

local wibox = require("wibox")

local widget = wibox.widget{
    widget = wibox.widget.separator,
    forced_width = 20,
    thickness = 2,
    color = "#84a0c6"
}

return widget
