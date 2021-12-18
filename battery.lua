-------------------------------------------------
-- Battery widget
-------------------------------------------------

local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

local text = wibox.widget{
    font = tostring(beautiful.get().font),
    widget = wibox.widget.textbox,
}

local widget = wibox.widget.background()
widget:set_widget(text)

gears.timer {
    timeout = 20,
    autostart = true,
    call_now = true,
    callback = function()
        awful.spawn.easy_async_with_shell("cat /sys/class/power_supply/BAT*/uevent", function(out)
            local capacity_raw = string.match(out, "POWER_SUPPLY_CAPACITY=%d*")
            local capacity = string.sub(string.match(capacity_raw, "=%d*"), 2)

            local status_raw = string.match(out, "POWER_SUPPLY_STATUS=%u")
            local status_stripped = string.match(status_raw, "=%u")
            local status_letter = string.match(status_stripped, "%u"):lower()

            text:set_text("ba:"..capacity..status_letter)

            local not_charging = status_letter == "d"
            local is_bat_low = tonumber(capacity) < 21
            local color = "#c6c8d1"

            if (not_charging) and (is_bat_low) then
                color = "#e98989"
            end

            widget:set_fg(color)
        end)
    end
}

return widget
