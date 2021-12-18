-------------------------------------------------
-- Volume widget
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

-- widget:set_bg("#008800")
-- widget:set_fg("#ffffff")

local function set_widget()
    awful.spawn.easy_async("amixer", function(out)
        local substr = string.match(out, "Master.*%[%d*%%%]")
        local val = string.match(substr, "%[%d*%%%]")
        local raw_val = string.sub(val, 2, -3)

        local muted_substr = string.match(out, "Master.*%[%l*%]")
        local muted_val = string.match(muted_substr, "%[%l*%]")
        local raw_muted = string.find(muted_val, "off") ~= nil

        local msg_muted = ''
        if raw_muted then
            msg_muted = 'm'
        end

        text:set_text("vo:"..raw_val..msg_muted)
    end)
end

set_widget()

local function update_widget(cmd)
    awful.spawn.easy_async(cmd, set_widget)
end

function widget:inc()
    update_widget("amixer -D pulse sset Master 5%+")
end

function widget:dec()
    update_widget("amixer -D pulse sset Master 5%-")
end

function widget:toggle()
    update_widget("amixer -D pulse sset Master toggle")
end

function widget:set_zero()
    update_widget("amixer -D pulse sset Master 0%")
end

function widget:set_half()
    update_widget("amixer -D pulse sset Master 50%")
end

function widget:set_full()
    update_widget("amixer -D pulse sset Master 100%")
end

return widget
