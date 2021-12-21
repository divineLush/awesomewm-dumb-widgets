-------------------------------------------------
-- Timer widget
-------------------------------------------------

local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")


local text = wibox.widget {
    font = "Hack 11",
    widget = wibox.widget.textbox,
}

local function set_text(arg)
    text:set_text('ti:'..arg)
end

local time = 25

local widget_timer = gears.timer {
    timeout = 60,
    callback = function()
        time = time - 1
        set_text(time)
    end
}

local timer = gears.timer {
    timeout = 1500,
    single_shot = true,
    callback = function()
        naughty.notify({ title = "Fun Fact!", text = "You wasted 25 minutes of your life!", timeout = 0 })
        set_text(0)
        time = 25
        if widget_timer.started then
            widget_timer:stop()
        end
    end
}

local widget = wibox.widget.background()
widget:set_widget(text)
set_text(0)

function widget:toggle()
    time = 25
    if timer.started then
        timer:stop()
        widget_timer:stop()
        set_text(0)
        naughty.notify({ title = 'Achtung!', text = 'Timer Stopped!' })
    else
        timer:start()
        widget_timer:start()
        set_text(25)
        naughty.notify({ title = 'Achtung!', text = 'Timer Started!' })
    end
end

return widget
