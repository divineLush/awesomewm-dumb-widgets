-------------------------------------------------
-- Timer widget
-------------------------------------------------

local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")

local text = wibox.widget {
    font = tostring(beautiful.get().font),
    widget = wibox.widget.textbox,
}

local function set_text(arg)
    text:set_text('ti:'..arg)
end

local timer = gears.timer {
    timeout = 1500,
    single_shot = true,
    callback = function()
        naughty.notify({ title = "Fun Fact!", text = "You wasted 25 minutes of your life!", timeout = 0 })
        set_text(0)
    end
}

local widget = wibox.widget.background()
widget:set_widget(text)
set_text(0)

local function start()
    timer:start()
    set_text(1)
    naughty.notify({ title = 'Achtung!', text = 'Timer Started!' })
end

local function stop()
    timer:stop()
    set_text(0)
    naughty.notify({ title = 'Achtung!', text = 'Timer Stopped!' })
end

function widget:toggle()
    if timer.started then
        stop()
    else
        start()
    end
end

return widget
