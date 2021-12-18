-------------------------------------------------
-- Mic widget
-------------------------------------------------

local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local text = wibox.widget{
    font = tostring(beautiful.get().font),
    widget = wibox.widget.textbox,
}

local widget = wibox.widget.background()
widget:set_widget(text)

local function set_widget()
    awful.spawn.easy_async("amixer", function(out)
        local is_on = string.find(out, "Capture.*%[on%]") ~= nil

        local val = 0
        if is_on then
            val = 1
        end

        text:set_text("mi:"..val)
    end)
end

set_widget()

local function update_widget(cmd)
    awful.spawn.easy_async(cmd, set_widget)
end

function widget:toggle()
    update_widget("amixer sset Capture toggle")
end

function widget:mute()
    update_widget("amixer sset Capture cap")
end

function widget:unmute()
    update_widget("amixer sset Capture nocap")
end

function widget:inc_vol()
    update_widget("amixer sset Capture 5%+")
end

function widget:dec_vol()
    update_widget("amixer sset Capture 5%-")
end

return widget

