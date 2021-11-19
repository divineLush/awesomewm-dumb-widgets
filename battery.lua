-------------------------------------------------
-- Battery widget
-------------------------------------------------

local wibox = require("wibox")
local watch = require("awful.widget.watch")

local text = wibox.widget{
    font = "Hack 12",
    widget = wibox.widget.textbox,
}

local widget = wibox.widget.background()
widget:set_widget(text)

watch("acpi -b", 10, function(widget, stdout, stderr, exitreason, exitcode)
        local perc = string.match(stdout, "%d%d%%")
        local val = string.sub(perc, 1, -2)
        local is_100 = string.find(stdout, "100%%") ~= nil

        if is_100 then
            val = "100"
        end

        local msg = "ba: "..val
        text:set_text(msg)

        local not_charging = string.find(stdout, "Charging") == nil
        local is_bat_low = tonumber(val) < 21
        local color = "#c6c8d1"

        if (not_charging) and (is_bat_low) then
            color = "#e98989"
        end

        widget:set_fg(color)
    end,
    widget
    )

return widget
